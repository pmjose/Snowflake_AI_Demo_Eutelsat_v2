-- ============================================================================
-- Eutelsat AI Demo - Deploy Applications (DataOps Template)
-- ============================================================================
-- Description: Deploys stored procedures, functions, and Intelligence Agent
-- Variables: {{ DATABASE_NAME }}, {{ WAREHOUSE_NAME }}, {{ SCHEMA_NAME }}
-- ============================================================================

USE ROLE {{ env.EVENT_ATTENDEE_ROLE | default('TELCO_ANALYST_ROLE') }};
USE WAREHOUSE {{ env.EVENT_WAREHOUSE | default('EUTELSAT_DEMO_WH') }};
USE DATABASE {{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }};
USE SCHEMA {{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }};

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
    stage_name STRING DEFAULT '@{{ env.EVENT_DATABASE | default("EUTELSAT_AI_DEMO") }}.{{ env.EVENT_SCHEMA | default("EUTELSAT_SCHEMA") }}.DATA_STAGE';
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
        'cityfibre_email_int',
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
EXTERNAL_ACCESS_INTEGRATIONS = (cityfibre_external_access_integration)
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
            warehouse = ''{{ env.EVENT_WAREHOUSE | default("EUTELSAT_DEMO_WH") }}''
            
            create_streamlit_sql = f"""
            CREATE OR REPLACE STREAMLIT {{ env.EVENT_DATABASE | default("EUTELSAT_AI_DEMO") }}.{{ env.EVENT_SCHEMA | default("EUTELSAT_SCHEMA") }}.{app_name}
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
                app_url = f"https://app.snowflake.com/{org_name}/{account_name}/#/streamlit-apps/{{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.{app_name}"
                
                # Return only the URL if successful
                return app_url
                
            except Exception as create_error:
                return f"""Files saved to {stage_path}/
   - test.py
   - environment.yml

Warning: Could not auto-create Streamlit app: {str(create_error)}

To create manually, run:
CREATE OR REPLACE STREAMLIT {{ env.EVENT_DATABASE | default("EUTELSAT_AI_DEMO") }}.{{ env.EVENT_SCHEMA | default("EUTELSAT_SCHEMA") }}.{app_name}
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

CREATE OR REPLACE AGENT {{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.Eutelsat_Executive_Agent
WITH PROFILE='{ "display_name": "Eutelsat Executive Agent" }'
    COMMENT=$$ Eutelsat executive agent for broadcast, mobility, enterprise/backhaul, telecom, and government services. Focuses on multi-orbit (GEO + OneWeb LEO) performance, revenue mix, pipeline, and ESG commitments. All demo values use EUR unless noted. $$
FROM SPECIFICATION $$
{
  "models": {
    "orchestration": ""
  },
  "instructions": {
    "response": "You are a business intelligence analyst for Eutelsat, operating a global multi-orbit GEO + OneWeb LEO network. You have access to service performance, sales and pipeline, financial performance, marketing campaigns, HR information, and network infrastructure data. All monetary values are in Euros (€) unless otherwise noted. Customer and market segments include Broadcast & Video, Aviation, Maritime, Enterprise/Community WiFi, Government/Defence, and Telecom backhaul. Network coverage is global (pole-to-pole for LEO) with 6,400+ TV channels and ~1B viewers (Eutelsat site) and ongoing capital raises (e.g., €828m reserved capital increase in Nov 2025). Provide visualizations where helpful - use line charts for trends, bar charts for comparisons.\n\n**IMPORTANT GUARDRAILS:**\n- You MUST ONLY answer questions related to Eutelsat business data (multi-orbit performance, sales/pipeline, finance, marketing, HR, ESG, network infrastructure, competitive posture).\n- You MUST NOT answer general knowledge questions, trivia, politics, or unrelated topics. Politely redirect to business questions.\n- Never use external knowledge beyond the provided tools and documents.",
    "response": "You are a business intelligence analyst for Eutelsat, operating a global multi-orbit GEO + OneWeb LEO network. You have access to service performance, sales and pipeline, financial performance, marketing campaigns, HR information, and network infrastructure data. All monetary values are in Euros (€) unless otherwise noted. Customer and market segments include Broadcast & Video, Aviation, Maritime, Enterprise/Community WiFi, Government/Defence, and Telecom backhaul. Network coverage is global (pole-to-pole for LEO) with nearly 7,000 TV channels (~1,400 HD, 1,100 radio) to 274M homes, 35 GEO satellites, and ~600 LEO satellites (Eutelsat site/Wikipedia). Provide visualizations where helpful - use line charts for trends, bar charts for comparisons.\n\n**IMPORTANT GUARDRAILS:**\n- You MUST ONLY answer questions related to Eutelsat business data (multi-orbit performance, sales/pipeline, finance, marketing, HR, ESG, network infrastructure, competitive posture).\n- You MUST NOT answer general knowledge questions, trivia, politics, or unrelated topics. Politely redirect to business questions.\n- Never use external knowledge beyond the provided tools and documents.",
    "orchestration": "Use cortex search for investor reports (consolidated accounts, URD amendment, presentations), sustainability statement, board/governance docs, and network/service briefs. Use cortex analyst for structured data on revenue/pipeline by vertical, capacity/utilisation, SLAs, and HR/finance metrics.\n\n**GUARDRAIL CHECK:** If a query is not about Eutelsat services, performance, finance, HR, ESG, or competitive positioning, DO NOT use tools and redirect the user.\n\nFor Sales Datamart: Contains sales/pipeline across Broadcast & Video, Aviation, Maritime, Enterprise/backhaul, Government/Defence, and Telecom backhaul. Products include video neighbourhoods/managed platforms, IFC and maritime connectivity, community WiFi/backhaul, secure government links, and mobility/backhaul add-ons.\n\nFor Marketing Datamart: Campaigns include broadcast neighbourhood promotions, mobility (aviation/maritime) offers, backhaul on wheels, and government/ESG messaging. Channels include partners, events, webinars, and digital.\n\nFor Strategy Documents: Search for market position, capital increase details, ESG commitments (responsible space, digital inclusion, earth/space environment), partner ecosystem, and board presentations.\n\nFor Network Infrastructure (USE 'Search Internal Documents: Network' tool): When users ask about GEO/LEO availability, latency/jitter, capacity headroom by beam/gateway, gateway expansion, mobility routes, SLA performance, or satellite fleet status, ALWAYS use the Network search tool.",
    "sample_questions": [
      { "question": "Summarize GEO vs LEO availability, latency, and congestion by service (Broadcast, Aviation, Maritime, Backhaul)." },
      { "question": "What do the FY24/25 investor deck and Q1 2025/26 presentation say about growth drivers, capex, and leverage?" },
      { "question": "Break down revenue and pipeline by vertical and product family; highlight trends in mobility/backhaul." },
      { "question": "Which beams or gateways are most utilized and where should we expand capacity?" },
      { "question": "What resilience and responsible space commitments are documented in the Sustainability Statement?" },
      { "question": "Show SLA performance and recent incidents for aviation and maritime customers." },
      { "question": "List top government/defence deals and any security/assurance requirements to note." },
      { "question": "How many active GEO satellites and OneWeb LEO satellites are in service, and which regions do they cover?" }
    ]
  },
  "tools": [
    {
      "tool_spec": {
        "type": "cortex_analyst_text_to_sql",
        "name": "Query Finance Datamart",
        "description": "Query Eutelsat financial data: revenue and margin by vertical (Broadcast & Video, Aviation, Maritime, Enterprise/backhaul, Government/Defence, Telecom backhaul), fleet/gateway capex, spectrum/ground opex, partner economics, and department costs. All amounts in Euros (€) unless noted."
      }
    },
    {
      "tool_spec": {
        "type": "cortex_analyst_text_to_sql",
        "name": "Query Sales Datamart",
        "description": "Query Eutelsat sales and pipeline: by customer/market segment (Broadcast & Video, Aviation, Maritime, Enterprise/backhaul, Government/Defence, Telecom), product family (video neighbourhoods/managed platforms, IFC/maritime connectivity, community WiFi/backhaul, secure links), region, and revenue. Use for revenue analysis, top customers, partner performance, and product adoption."
      }
    },
    {
      "tool_spec": {
        "type": "cortex_analyst_text_to_sql",
        "name": "Query HR Datamart",
        "description": "Query Eutelsat workforce data: employees, departments, jobs, account managers, salaries, and attrition. Includes satellite operations, ground engineering, NOC/SOC, mobility delivery, sales/partner roles."
      }
    },
    {
      "tool_spec": {
        "type": "cortex_analyst_text_to_sql",
        "name": "Query Marketing Datamart",
        "description": "Query Eutelsat marketing data: campaigns for broadcast neighbourhoods, mobility (aviation/maritime), backhaul on wheels, government/ESG messaging; channels (partners, digital, events, webinars). Use for spend, leads, impressions, and ROI."
      }
    },
    {
      "tool_spec": {
        "type": "cortex_search",
        "name": "Search Internal Documents: Finance",
        "description": "Search Eutelsat finance documents: consolidated accounts FY25, URD amendment, FY24/25 investor presentations, Q1 2025/26 deck, capital increase (€828m) notes, ARPU/ARPA analysis, partner revenue mix, ESG and sustainability reporting."
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
        "description": "Search Eutelsat sales documents: partner playbooks for broadcast/mobility/backhaul, performance reports, onboarding guides, customer success stories, and competitive positioning vs other satellite operators/terrestrial alternatives."
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
        "description": "Search CEO/strategy documents including multi-orbit roadmaps, financing summaries, market position analysis, investor relations FAQ, board presentations, ESG reports, and governance content."
      }
    },
    {
      "tool_spec": {
        "type": "cortex_search",
        "name": "Search Internal Documents: Network",
        "description": "Search network infrastructure documents including GEO/LEO coverage, platform uptime, latency/jitter, beam/gateway capacity, mobility/backhaul performance, and resiliency/failover playbooks."
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
        "warehouse": "{{ env.EVENT_WAREHOUSE | default('EUTELSAT_DEMO_WH') }}"
      },
      "identifier": "{{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.GET_FILE_PRESIGNED_URL_SP",
      "name": "GET_FILE_PRESIGNED_URL_SP(VARCHAR, DEFAULT NUMBER)",
      "type": "procedure"
    },
    "Query Finance Datamart": {
      "semantic_view": "{{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.FINANCE_SEMANTIC_VIEW"
    },
    "Query HR Datamart": {
      "semantic_view": "{{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.HR_SEMANTIC_VIEW"
    },
    "Query Marketing Datamart": {
      "semantic_view": "{{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.MARKETING_SEMANTIC_VIEW"
    },
    "Query Sales Datamart": {
      "semantic_view": "{{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.SALES_SEMANTIC_VIEW"
    },
    "Search Internal Documents: Finance": {
      "id_column": "FILE_URL",
      "max_results": 5,
      "name": "{{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.SEARCH_FINANCE_DOCS",
      "title_column": "TITLE"
    },
    "Search Internal Documents: HR": {
      "id_column": "FILE_URL",
      "max_results": 5,
      "name": "{{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.SEARCH_HR_DOCS",
      "title_column": "TITLE"
    },
    "Search Internal Documents: Marketing": {
      "id_column": "RELATIVE_PATH",
      "max_results": 5,
      "name": "{{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.SEARCH_MARKETING_DOCS",
      "title_column": "TITLE"
    },
    "Search Internal Documents: Sales": {
      "id_column": "FILE_URL",
      "max_results": 5,
      "name": "{{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.SEARCH_SALES_DOCS",
      "title_column": "TITLE"
    },
    "Search Internal Documents: Strategy": {
      "id_column": "RELATIVE_PATH",
      "max_results": 5,
      "name": "{{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.SEARCH_STRATEGY_DOCS",
      "title_column": "TITLE"
    },
    "Search Internal Documents: Network": {
      "id_column": "RELATIVE_PATH",
      "max_results": 5,
      "name": "{{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.SEARCH_NETWORK_DOCS",
      "title_column": "TITLE"
    },
    "Send_Emails": {
      "execution_environment": {
        "query_timeout": 0,
        "type": "warehouse",
        "warehouse": "{{ env.EVENT_WAREHOUSE | default('EUTELSAT_DEMO_WH') }}"
      },
      "identifier": "{{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.SEND_MAIL",
      "name": "SEND_MAIL(VARCHAR, VARCHAR, VARCHAR)",
      "type": "procedure"
    },
    "Web_scraper": {
      "execution_environment": {
        "query_timeout": 0,
        "type": "warehouse",
        "warehouse": "{{ env.EVENT_WAREHOUSE | default('EUTELSAT_DEMO_WH') }}"
      },
      "identifier": "{{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.WEB_SCRAPE",
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
GRANT USAGE ON AGENT {{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.Eutelsat_Executive_Agent 
    TO ROLE {{ env.EVENT_ATTENDEE_ROLE | default('TELCO_ANALYST_ROLE') }};

-- Also grant to ACCOUNTADMIN for admin access
GRANT USAGE ON AGENT {{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.Eutelsat_Executive_Agent 
    TO ROLE ACCOUNTADMIN;

-- Grant to PUBLIC for broader access (optional - remove if you want restricted access)
GRANT USAGE ON AGENT {{ env.EVENT_DATABASE | default('EUTELSAT_AI_DEMO') }}.{{ env.EVENT_SCHEMA | default('EUTELSAT_SCHEMA') }}.Eutelsat_Executive_Agent 
    TO ROLE PUBLIC;

-- ============================================================================
-- Verification
-- ============================================================================

SELECT 'Eutelsat AI Demo applications deployed successfully!' AS status,
       'Procedures: Get_File_Presigned_URL_SP, send_mail, Web_scrape, GENERATE_STREAMLIT_APP' AS procedures_created,
       'Agent: {{ env.EVENT_DATABASE | default("EUTELSAT_AI_DEMO") }}.{{ env.EVENT_SCHEMA | default("EUTELSAT_SCHEMA") }}.Eutelsat_Executive_Agent' AS agent_created,
       CURRENT_TIMESTAMP() AS deployed_at;
