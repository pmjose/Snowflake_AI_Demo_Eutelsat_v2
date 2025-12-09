-- ============================================================================
-- Gamma AI Demo - Deploy Applications (DataOps Template)
-- ============================================================================
-- Description: Deploys stored procedures, functions, and Intelligence Agent
-- Variables: {{ DATABASE_NAME }}, {{ WAREHOUSE_NAME }}, {{ SCHEMA_NAME }}
-- ============================================================================

USE ROLE {{ env.EVENT_ATTENDEE_ROLE | default('TELCO_ANALYST_ROLE') }};
USE WAREHOUSE {{ env.EVENT_WAREHOUSE | default('TELCO_WH') }};
USE DATABASE {{ env.EVENT_DATABASE | default('TELCO_OPERATIONS_AI') }};
USE SCHEMA {{ env.EVENT_SCHEMA | default('DEFAULT_SCHEMA') }};

-- ============================================================================
-- Step 1: Create Stored Procedure for Presigned URLs
-- ============================================================================

CREATE OR REPLACE PROCEDURE Get_File_Presigned_URL_SP(
    RELATIVE_FILE_PATH STRING, 
    EXPIRATION_MINS INTEGER DEFAULT 60
)
RETURNS STRING
LANGUAGE SQL
COMMENT = 'Generates a presigned URL for a file in the static @DATA_STAGE. Input is the relative file path.'
EXECUTE AS CALLER
AS
$$
DECLARE
    presigned_url STRING;
    sql_stmt STRING;
    expiration_seconds INTEGER;
    stage_name STRING DEFAULT '@{{ env.EVENT_DATABASE | default("TELCO_OPERATIONS_AI") }}.{{ env.EVENT_SCHEMA | default("DEFAULT_SCHEMA") }}.DATA_STAGE';
BEGIN
    expiration_seconds := EXPIRATION_MINS * 60;

    sql_stmt := 'SELECT GET_PRESIGNED_URL(' || stage_name || ', ' || '''' || RELATIVE_FILE_PATH || '''' || ', ' || expiration_seconds || ') AS url';
    
    EXECUTE IMMEDIATE :sql_stmt;
    
    SELECT "URL"
    INTO :presigned_url
    FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
    
    RETURN :presigned_url;
END;
$$;

-- ============================================================================
-- Step 2: Create Stored Procedure for Sending Emails
-- ============================================================================

CREATE OR REPLACE PROCEDURE send_mail(recipient TEXT, subject TEXT, text TEXT)
RETURNS TEXT
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'send_mail'
AS
$$
def send_mail(session, recipient, subject, text):
    session.call(
        'SYSTEM$SEND_EMAIL',
        'gamma_email_int',
        recipient,
        subject,
        text,
        'text/html'
    )
    return f'Email was sent to {recipient} with subject: "{subject}".'
$$;

-- ============================================================================
-- Step 3: Create Web Scraping Function
-- ============================================================================

CREATE OR REPLACE FUNCTION Web_scrape(weburl STRING)
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = 3.11
HANDLER = 'get_page'
EXTERNAL_ACCESS_INTEGRATIONS = (gamma_external_access_integration)
PACKAGES = ('requests', 'beautifulsoup4')
AS
$$
import _snowflake
import requests
from bs4 import BeautifulSoup

def get_page(weburl):
  url = f"{weburl}"
  response = requests.get(url)
  soup = BeautifulSoup(response.text)
  return soup.get_text()
$$;

-- ============================================================================
-- Step 4: Create Streamlit App Generator Procedure
-- ============================================================================

CREATE OR REPLACE PROCEDURE GENERATE_STREAMLIT_APP("USER_INPUT" VARCHAR)
RETURNS VARCHAR
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'generate_app'
EXECUTE AS OWNER
AS '
def generate_app(session, user_input):
    import re
    import tempfile
    import os
    
    # Build the prompt for AI_COMPLETE
    prompt = f"""Generate a Streamlit in Snowflake code that has an existing session. 
- Output should only contain the code and nothing else. 

- Total number of characters in the entire python code should be less than 32000 chars

- create session object like this: 
from snowflake.snowpark.context import get_active_session
session = get_active_session()

- Never CREATE, DROP , TRUNCATE OR ALTER  tables. You are only allowed to use SQL SELECT statements.

- Use only native Streamlit visualizations and no html formatting

- ignore & remove VERTICAL=''Retail'' filter in all source SQL queries.

- Use ONLY SQL queries provided in the input as the data source for all dataframes placing them into CTE to generate new ones. You can remove LIMIT or modify WHERE clauses to remove or modify filters. Example:

WITH cte AS (
    SELECT original_query_from_prompt modified 
    WHERE x=1 --this portion can be removed or modified
    LIMIT 5   -- this needs to be removed
)
SELECT *
FROM cte as new_query for dataframe;


- DO NOT use any table or column other than what was listed in the source queries below. 

- all table column names should be in UPPER CASE

- Include filters for users such as for dates ranges & all dimensions discussed within the user conversation to make it more interactive. Queries used for user selections using distinct values should not use any filters for VERTICAL = RETAIL.

- Can have up to 2 tabs. Each tab can have up maximum 4 visualizatons (chart & kpis)

- Use only native Streamlit visualizations and no html formatting. 

- For Barcharts showing Metric by Dimension_Name, bars should be sorted from highest metric value to lowest . 

- dont use st.Scatter_chart, st.bokeh_chart, st.set_page_config The page_title, page_icon, and menu_items properties of the st.set_page_config command are not supported. 

- Dont use plotly. 

- When generating code that involves loading data from a SQL source (like Snowflake/Snowpark)
into a Pandas DataFrame for use in a visualization library (like Streamlit), you must explicitly ensure all date and timestamp columns are correctly cast as Pandas datetime objects.

Specific Steps:

Identify all columns derived from SQL date/timestamp functions (e.g., DATE, MONTH, SALE_DATE).

Immediately after calling the .to_pandas() method to load the data into the DataFrame df, insert code to apply pd.to_datetime() to these column

- App should perform the following:
<input>
{user_input}
</input>"""
    
    # Escape single quotes for SQL
    escaped_prompt = prompt.replace("''", "''''")
    
    # Build model_parameters as a separate string to avoid f-string escaping issues
    model_params = "{''temperature'': 0, ''max_tokens'': 8192}"
    
    # Execute AI_COMPLETE query with model parameters
    query = f"""SELECT AI_COMPLETE(model => ''claude-4-sonnet'',
                                prompt => ''{escaped_prompt}'',
                                model_parameters => {model_params}
                                )::string as result"""
    
    result = session.sql(query).collect()
    
    if result and len(result) > 0:
        code_response = result[0][''RESULT'']
        
        # Strip markdown code block markers using regex
        cleaned_code = code_response.strip()
        
        # Remove ```python, ```, or ```py markers at start
        cleaned_code = re.sub(r''^```(?:python|py)?\\s*\\n?'', '''', cleaned_code)
        # Remove ``` at end
        cleaned_code = re.sub(r''\\n?```\\s*$'', '''', cleaned_code)
        
        # Remove any leading/trailing whitespace
        cleaned_code = cleaned_code.strip()
        
        # Prepare environment.yml content
        environment_yml_content = """# Snowflake environment file for Streamlit in Snowflake (SiS)
# This file specifies Python package dependencies for your Streamlit app

name: streamlit_app_env
channels:
  - snowflake

dependencies:
  - plotly=6.3.0
"""
        
        # Write files to temporary directory
        temp_dir = tempfile.gettempdir()
        temp_py_file = os.path.join(temp_dir, ''test.py'')
        temp_yml_file = os.path.join(temp_dir, ''environment.yml'')
        
        try:
            # Write the Python code to temporary file
            with open(temp_py_file, ''w'') as f:
                f.write(cleaned_code)
            
            # Write the environment.yml to temporary file
            with open(temp_yml_file, ''w'') as f:
                f.write(environment_yml_content)
            
            # Upload both files to Snowflake stage
            stage_path = ''@DATA_STAGE''
            
            # Upload Python file
            session.file.put(
                temp_py_file,
                stage_path,
                auto_compress=False,
                overwrite=True
            )
            
            # Upload environment.yml file
            session.file.put(
                temp_yml_file,
                stage_path,
                auto_compress=False,
                overwrite=True
            )
            
            # Clean up temporary files
            os.remove(temp_py_file)
            os.remove(temp_yml_file)
            
            # Create Streamlit app
            app_name = ''AUTO_GENERATED_1''
            warehouse = ''{{ env.EVENT_WAREHOUSE | default("TELCO_WH") }}''
            
            create_streamlit_sql = f"""
            CREATE OR REPLACE STREAMLIT {{ env.EVENT_DATABASE | default("TELCO_OPERATIONS_AI") }}.{{ env.EVENT_SCHEMA | default("DEFAULT_SCHEMA") }}.{app_name}
                FROM @DATA_STAGE
                MAIN_FILE = ''test.py''
                QUERY_WAREHOUSE = {warehouse}
            """
            
            try:
                session.sql(create_streamlit_sql).collect()
                
                # Get account information for URL
                account_info = session.sql("SELECT CURRENT_ACCOUNT_NAME() AS account, CURRENT_ORGANIZATION_NAME() AS org").collect()
                account_name = account_info[0][''ACCOUNT'']
                org_name = account_info[0][''ORG'']
                
                # Construct app URL
                app_url = f"https://app.snowflake.com/{org_name}/{account_name}/#/streamlit-apps/{{ env.EVENT_DATABASE | default('TELCO_OPERATIONS_AI') }}.{{ env.EVENT_SCHEMA | default('DEFAULT_SCHEMA') }}.{app_name}"
                
                # Return only the URL if successful
                return app_url
                
            except Exception as create_error:
                return f"""Files saved to {stage_path}/
   - test.py
   - environment.yml

Warning: Could not auto-create Streamlit app: {str(create_error)}

To create manually, run:
CREATE OR REPLACE STREAMLIT {{ env.EVENT_DATABASE | default("TELCO_OPERATIONS_AI") }}.{{ env.EVENT_SCHEMA | default("DEFAULT_SCHEMA") }}.{app_name}
    FROM @DATA_STAGE
    MAIN_FILE = ''test.py''
    QUERY_WAREHOUSE = {warehouse};

--- Generated Code ---
{cleaned_code}"""
            
        except Exception as e:
            # Clean up temp files if they exist
            if os.path.exists(temp_py_file):
                os.remove(temp_py_file)
            if os.path.exists(temp_yml_file):
                os.remove(temp_yml_file)
            return f"Error saving to stage: {str(e)}\\n\\n--- Generated Code ---\\n{cleaned_code}"
    else:
        return "Error: No response from AI_COMPLETE"
';

-- ============================================================================
-- Step 5: Create Snowflake Intelligence Agent
-- ============================================================================

CREATE OR REPLACE AGENT {{ env.EVENT_DATABASE | default('GAMMA_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('GAMMA_SCHEMA') }}.Gamma_Executive_Agent
WITH PROFILE='{ "display_name": "Gamma UK Executive Agent" }'
    COMMENT=$$ Gamma Communications B2B intelligence agent for C-level executives (CEO, CFO, CMO, CCO). Covers UCaaS seats, channel partner revenue, ARR/MRR, NPS, campaigns, and UK B2B market analysis. All figures in British Pounds (£). $$
FROM SPECIFICATION $$
{
  "models": {
    "orchestration": ""
  },
  "instructions": {
    "response": "You are a business intelligence analyst for Gamma Communications, a UK B2B communications provider. You have access to sales transactions, financial metrics, marketing campaigns, HR information, and network infrastructure data. All monetary values are in British Pounds (£). Customer verticals are SMB, Enterprise, Public Sector, and Partner. Industries include Healthcare, Manufacturing, Financial Services, Technology, Legal Services, and more. UK regions include London, South East, Scotland, Wales, North West, and others. Competitors are 8x8, RingCentral, Mitel, Vonage, and Microsoft Direct. Products include Horizon, Microsoft Teams Phone, SIP Trunks, Contact Centre, and Connectivity. Network infrastructure includes data centres (London, Manchester, Glasgow), carrier connections (BT, Virgin Media, CityFibre), and platform metrics. Provide visualizations where helpful - use line charts for trends, bar charts for comparisons.\n\n**IMPORTANT GUARDRAILS:**\n- You MUST ONLY answer questions related to Gamma Communications business data, including sales, finance, marketing, HR, strategy documents, network infrastructure, and competitive analysis.\n- You MUST NOT answer general knowledge questions, trivia, current events, politics, celebrities, sports, or any topic not directly related to Gamma's business operations.\n- If asked about unrelated topics (like 'who is the prime minister', 'what is the weather', 'tell me a joke', etc.), politely decline and redirect: 'I can only help with questions about Gamma Communications business data. For example, you could ask about sales performance, revenue by product, network uptime, or competitive analysis.'\n- Never use external knowledge to answer questions - only use the data and documents available through your tools.",
    "orchestration": "Use cortex search for policy documents, strategy reports, vendor contracts, network infrastructure, and competitive analysis. Use cortex analyst for structured data queries on sales, revenue, campaigns, and HR.\n\n**GUARDRAIL CHECK:** Before processing ANY query, first determine if it relates to Gamma Communications business data. If the query is about general knowledge, current events, politics, entertainment, or any topic NOT related to Gamma's sales, finance, marketing, HR, network infrastructure, strategy, or competitive landscape - DO NOT use any tools and instead respond with a polite redirect to business-related questions.\n\nFor Sales Datamart: Contains B2B sales transactions. Products include UCaaS (Horizon, Teams Phone, Webex), CCaaS (Horizon Contact, Cirrus), Voice (SIP Trunks, Inbound), Connectivity (Broadband, Ethernet, SD-WAN), and Security (MDR, SOC). Customer verticals are SMB, Enterprise, Public Sector, Partner. Industries include Healthcare, Manufacturing, Financial Services, Technology, Legal Services, Education, Hospitality.\n\nFor Marketing Datamart: Campaigns include Horizon Launch, Teams Phone Migration, Partner Recruitment, PSTN Switch-off Awareness. Channels include Channel Partners, Direct Enterprise, Webinars, LinkedIn, Events.\n\nFor Strategy Documents: Search for market position, competitive analysis vs 8x8/RingCentral/Mitel, Microsoft partnership, ESG reports, Ofcom compliance, board presentations, investor relations.\n\nFor Network Infrastructure (USE 'Search Internal Documents: Network' tool): When users ask about data centres, data center locations, network capacity, uptime, platform performance, carrier connections (BT, Virgin Media, CityFibre, Colt, Zayo), concurrent call capacity, SBC clusters, media servers, voice quality (MOS scores, jitter, latency) - ALWAYS use the Network search tool. Data centres are in London (LD4), Manchester (MA1), and Glasgow (GL1).\n\n",
    "sample_questions": [
      {
        "question": "What is our total revenue by customer industry?"
      },
      {
        "question": "Where are our data centres located and what is our network capacity?"
      },
      {
        "question": "How do we compare to 8x8 and RingCentral in the UCaaS market?"
      },
      {
        "question": "Which marketing campaigns generated the most leads?"
      },
      {
        "question": "What are our top selling products by revenue?"
      },
      {
        "question": "What is our network uptime and platform reliability?"
      },
      {
        "question": "What is our data centre capacity and concurrent call handling?"
      }
    ]
  },
  "tools": [
    {
      "tool_spec": {
        "type": "cortex_analyst_text_to_sql",
        "name": "Query Finance Datamart",
        "description": "Query Gamma financial data: revenue by product category (UCaaS, CCaaS, Voice, Connectivity), partner economics, vendor spend (Microsoft, Cisco, AWS), expenses, and department costs. All amounts in British Pounds (£)."
      }
    },
    {
      "tool_spec": {
        "type": "cortex_analyst_text_to_sql",
        "name": "Query Sales Datamart",
        "description": "Query Gamma B2B sales data: sales by customer vertical (SMB/Enterprise/Public Sector/Partner), customer industry (Healthcare, Manufacturing, Financial Services, etc.), products (Horizon, Teams Phone, SIP Trunks, Contact Centre), UK regions (London, Scotland, Wales), and revenue. Use for revenue analysis, top customers, and product performance."
      }
    },
    {
      "tool_spec": {
        "type": "cortex_analyst_text_to_sql",
        "name": "Query HR Datamart",
        "description": "Query Gamma workforce data: employees, departments, jobs, channel account managers, salaries, and attrition. Employee names include sales representatives and partner managers."
      }
    },
    {
      "tool_spec": {
        "type": "cortex_analyst_text_to_sql",
        "name": "Query Marketing Datamart",
        "description": "Query Gamma marketing data: campaigns (Horizon Launch, Teams Phone Migration, Partner Recruitment, PSTN Switch-off), channels (Channel Partners, Digital, Events, Webinars, LinkedIn), spend, impressions, leads, and ROI. Use for campaign effectiveness and partner marketing analysis."
      }
    },
    {
      "tool_spec": {
        "type": "cortex_search",
        "name": "Search Internal Documents: Finance",
        "description": "Search Gamma finance documents: Financial Reports, ARPU per seat analysis, B2B unit economics (LTV/CAC), partner revenue mix, ESG sustainability report, Ofcom compliance, and vendor contracts (Microsoft, Cisco, AWS)."
      }
    },
    {
      "tool_spec": {
        "type": "cortex_search",
        "name": "Search Internal Documents: HR",
        "description": "Search HR documents: employee handbook, performance guidelines, department structures, and workforce policies."
      }
    },
    {
      "tool_spec": {
        "type": "cortex_search",
        "name": "Search Internal Documents: Sales",
        "description": "Search Gamma sales documents: Channel Partner Playbook 2025, Churn Reduction Playbook, Partner Performance Reports, and Customer Success Stories. Includes competitive positioning vs 8x8, RingCentral, Mitel, Vonage."
      }
    },
    {
      "tool_spec": {
        "type": "cortex_search",
        "name": "Search Internal Documents: Marketing",
        "description": "Search marketing documents including campaign strategies, competitive analysis, NPS reports, and ROI analysis."
      }
    },
    {
      "tool_spec": {
        "type": "cortex_search",
        "name": "Search Internal Documents: Strategy",
        "description": "Search CEO/strategy documents including UCaaS growth reports, market position analysis, cloud communications roadmap, competitive landscape (8x8, RingCentral), investor relations FAQ, board presentations, ESG reports, and Ofcom compliance."
      }
    },
    {
      "tool_spec": {
        "type": "cortex_search",
        "name": "Search Internal Documents: Network",
        "description": "Search network infrastructure documents including data centres (London LD4, Manchester MA1, Glasgow GL1), platform uptime, carrier connections (BT, Virgin Media, CityFibre, Colt, Zayo), concurrent call capacity, SBC clusters, media servers, voice quality metrics (MOS score, jitter, latency), and network redundancy."
      }
    },
    {
      "tool_spec": {
        "type": "generic",
        "name": "Web_scraper",
        "description": "This tool should be used if the user wants to analyse contents of a given web page. This tool will use a web url (https or https) as input and will return the text content of that web page for further analysis",
        "input_schema": {
          "type": "object",
          "properties": {
            "weburl": {
              "description": "Agent should ask web url ( that includes http:// or https:// ). It will scrape text from the given url and return as a result.",
              "type": "string"
            }
          },
          "required": [
            "weburl"
          ]
        }
      }
    },
    {
      "tool_spec": {
        "type": "generic",
        "name": "Send_Emails",
        "description": "This tool is used to send emails to a email recipient. It can take an email, subject & content as input to send the email. Always use HTML formatted content for the emails.",
        "input_schema": {
          "type": "object",
          "properties": {
            "recipient": {
              "description": "recipient of email",
              "type": "string"
            },
            "subject": {
              "description": "subject of email",
              "type": "string"
            },
            "text": {
              "description": "content of email",
              "type": "string"
            }
          },
          "required": [
            "text",
            "recipient",
            "subject"
          ]
        }
      }
    },
    {
      "tool_spec": {
        "type": "generic",
        "name": "Dynamic_Doc_URL_Tool",
        "description": "This tools uses the ID Column coming from Cortex Search tools for reference docs and returns a temp URL for users to view & download the docs.\n\nReturned URL should be presented as a HTML Hyperlink where doc title should be the text and out of this tool should be the url.\n\nURL format for PDF docs that are are like this which has no PDF in the url. Create the Hyperlink format so the PDF doc opens up in a browser instead of downloading the file.\nhttps://domain/path/unique_guid",
        "input_schema": {
          "type": "object",
          "properties": {
            "expiration_mins": {
              "description": "default should be 5",
              "type": "number"
            },
            "relative_file_path": {
              "description": "This is the ID Column value Coming from Cortex Search tool.",
              "type": "string"
            }
          },
          "required": [
            "expiration_mins",
            "relative_file_path"
          ]
        }
      }
    }
  ],
  "tool_resources": {
    "Dynamic_Doc_URL_Tool": {
      "execution_environment": {
        "query_timeout": 0,
        "type": "warehouse",
        "warehouse": "{{ env.EVENT_WAREHOUSE | default('TELCO_WH') }}"
      },
      "identifier": "{{ env.EVENT_DATABASE | default('TELCO_OPERATIONS_AI') }}.{{ env.EVENT_SCHEMA | default('DEFAULT_SCHEMA') }}.GET_FILE_PRESIGNED_URL_SP",
      "name": "GET_FILE_PRESIGNED_URL_SP(VARCHAR, DEFAULT NUMBER)",
      "type": "procedure"
    },
    "Query Finance Datamart": {
      "semantic_view": "{{ env.EVENT_DATABASE | default('TELCO_OPERATIONS_AI') }}.{{ env.EVENT_SCHEMA | default('DEFAULT_SCHEMA') }}.FINANCE_SEMANTIC_VIEW"
    },
    "Query HR Datamart": {
      "semantic_view": "{{ env.EVENT_DATABASE | default('TELCO_OPERATIONS_AI') }}.{{ env.EVENT_SCHEMA | default('DEFAULT_SCHEMA') }}.HR_SEMANTIC_VIEW"
    },
    "Query Marketing Datamart": {
      "semantic_view": "{{ env.EVENT_DATABASE | default('TELCO_OPERATIONS_AI') }}.{{ env.EVENT_SCHEMA | default('DEFAULT_SCHEMA') }}.MARKETING_SEMANTIC_VIEW"
    },
    "Query Sales Datamart": {
      "semantic_view": "{{ env.EVENT_DATABASE | default('TELCO_OPERATIONS_AI') }}.{{ env.EVENT_SCHEMA | default('DEFAULT_SCHEMA') }}.SALES_SEMANTIC_VIEW"
    },
    "Search Internal Documents: Finance": {
      "id_column": "FILE_URL",
      "max_results": 5,
      "name": "{{ env.EVENT_DATABASE | default('TELCO_OPERATIONS_AI') }}.{{ env.EVENT_SCHEMA | default('DEFAULT_SCHEMA') }}.SEARCH_FINANCE_DOCS",
      "title_column": "TITLE"
    },
    "Search Internal Documents: HR": {
      "id_column": "FILE_URL",
      "max_results": 5,
      "name": "{{ env.EVENT_DATABASE | default('TELCO_OPERATIONS_AI') }}.{{ env.EVENT_SCHEMA | default('DEFAULT_SCHEMA') }}.SEARCH_HR_DOCS",
      "title_column": "TITLE"
    },
    "Search Internal Documents: Marketing": {
      "id_column": "RELATIVE_PATH",
      "max_results": 5,
      "name": "{{ env.EVENT_DATABASE | default('TELCO_OPERATIONS_AI') }}.{{ env.EVENT_SCHEMA | default('DEFAULT_SCHEMA') }}.SEARCH_MARKETING_DOCS",
      "title_column": "TITLE"
    },
    "Search Internal Documents: Sales": {
      "id_column": "FILE_URL",
      "max_results": 5,
      "name": "{{ env.EVENT_DATABASE | default('TELCO_OPERATIONS_AI') }}.{{ env.EVENT_SCHEMA | default('DEFAULT_SCHEMA') }}.SEARCH_SALES_DOCS",
      "title_column": "TITLE"
    },
    "Search Internal Documents: Strategy": {
      "id_column": "RELATIVE_PATH",
      "max_results": 5,
      "name": "{{ env.EVENT_DATABASE | default('TELCO_OPERATIONS_AI') }}.{{ env.EVENT_SCHEMA | default('DEFAULT_SCHEMA') }}.SEARCH_STRATEGY_DOCS",
      "title_column": "TITLE"
    },
    "Search Internal Documents: Network": {
      "id_column": "RELATIVE_PATH",
      "max_results": 5,
      "name": "{{ env.EVENT_DATABASE | default('TELCO_OPERATIONS_AI') }}.{{ env.EVENT_SCHEMA | default('DEFAULT_SCHEMA') }}.SEARCH_NETWORK_DOCS",
      "title_column": "TITLE"
    },
    "Send_Emails": {
      "execution_environment": {
        "query_timeout": 0,
        "type": "warehouse",
        "warehouse": "{{ env.EVENT_WAREHOUSE | default('TELCO_WH') }}"
      },
      "identifier": "{{ env.EVENT_DATABASE | default('TELCO_OPERATIONS_AI') }}.{{ env.EVENT_SCHEMA | default('DEFAULT_SCHEMA') }}.SEND_MAIL",
      "name": "SEND_MAIL(VARCHAR, VARCHAR, VARCHAR)",
      "type": "procedure"
    },
    "Web_scraper": {
      "execution_environment": {
        "query_timeout": 0,
        "type": "warehouse",
        "warehouse": "{{ env.EVENT_WAREHOUSE | default('TELCO_WH') }}"
      },
      "identifier": "{{ env.EVENT_DATABASE | default('TELCO_OPERATIONS_AI') }}.{{ env.EVENT_SCHEMA | default('DEFAULT_SCHEMA') }}.WEB_SCRAPE",
      "name": "WEB_SCRAPE(VARCHAR)",
      "type": "function"
    }
  }
}
$$;

-- ============================================================================
-- Grant Agent Access to Users
-- ============================================================================

-- Grant USAGE on the agent to the analyst role (CEO, CFO, CRO users have this role)
GRANT USAGE ON AGENT {{ env.EVENT_DATABASE | default('GAMMA_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('GAMMA_SCHEMA') }}.Gamma_Executive_Agent 
    TO ROLE {{ env.EVENT_ATTENDEE_ROLE | default('TELCO_ANALYST_ROLE') }};

-- Also grant to ACCOUNTADMIN for admin access
GRANT USAGE ON AGENT {{ env.EVENT_DATABASE | default('GAMMA_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('GAMMA_SCHEMA') }}.Gamma_Executive_Agent 
    TO ROLE ACCOUNTADMIN;

-- Grant to PUBLIC for broader access (optional - remove if you want restricted access)
GRANT USAGE ON AGENT {{ env.EVENT_DATABASE | default('GAMMA_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('GAMMA_SCHEMA') }}.Gamma_Executive_Agent 
    TO ROLE PUBLIC;

-- ============================================================================
-- Verification
-- ============================================================================

SELECT 'Gamma AI Demo applications deployed successfully!' AS status,
       'Procedures: Get_File_Presigned_URL_SP, send_mail, Web_scrape, GENERATE_STREAMLIT_APP' AS procedures_created,
       'Agent: {{ env.EVENT_DATABASE | default("GAMMA_AI_DEMO") }}.{{ env.EVENT_SCHEMA | default("GAMMA_SCHEMA") }}.Gamma_Executive_Agent' AS agent_created,
       CURRENT_TIMESTAMP() AS deployed_at;
