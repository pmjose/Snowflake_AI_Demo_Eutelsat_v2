# Build an AI Assistant for Telco using Snowflake Intelligence (Eutelsat)

<p align="center">
  <strong>A comprehensive AI-powered business intelligence platform for B2B telecommunications</strong>
</p>

<p align="center">
  <a href="#quick-start">Quick Start</a> •
  <a href="#features">Features</a> •
  <a href="#architecture">Architecture</a> •
  <a href="#local-testing">Local Testing</a> •
  <a href="#exec-questions-to-try-eutelsat">Exec Questions & Prompts</a>
</p>

---

## 🎯 Overview

This project demonstrates how to build a production-ready AI assistant for **Eutelsat**, a French-based satellite communications leader (founded 1977, HQ Paris) with a multi-orbit GEO + OneWeb LEO network. It uses **Snowflake Cortex AI**, **Snowflake Intelligence**, and **Cortex Analyst** to answer questions about broadcast reach (nearly 7,000 TV channels, ~1,400 HD, 1,100 radio, 274M homes), multi-orbit performance (35 GEO satellites plus ~600 LEO), vertical solutions (broadcast/video, aviation, maritime, enterprise/backhaul, government), investor updates (e.g., €828m capital increase in Nov 2025), and sustainability commitments (responsible space, digital inclusion)\*.

\*Sources: `reports/DOC_Investors_ECOM-Consolidated-accounts-FY25_EN_101025.pdf`, `reports/DOC_Investor_Amendment-URD-2024-25_EN_251125.pdf`, `reports/DOC_Group_URD_Eutelsat-Sustainability-Statement-2024-25_EN_301025.pdf`, `reports/DOC_Investors_Presentation-FY2024-25_EN_050825.pdf`, `reports/DOC_Investors_Q1-2025-26-Presentation_EN-211025.pdf`, and the [Eutelsat website](https://www.eutelsat.com/) plus [Wikipedia](https://en.wikipedia.org/wiki/Eutelsat).

### What You Get

**Core Data Platform**:
- **📊 20+ Dimension & Fact Tables** - Sales, Finance, Marketing, HR data
- **📄 60+ Business Documents** - PDFs, DOCX, MD files across departments
- **🎙️ 25 Call Recordings** - Customer service audio files
- **📧 Email Previews** - Sample communications data

**AI & ML Tools**:
- **🔍 6 Search Services** - Finance, HR, Marketing, Sales, Strategy, Network
- **📈 4 Semantic Views** - Finance, Sales, Marketing, HR datamarts
- **🤖 1 AI Agent** - Eutelsat Executive Agent with 12 tools
- **💻 Streamlit Apps** - Cortex Agent interface
- **📓 Snowflake Notebooks** - Data processing workflows

---

## 🚀 Quick Start

### Prerequisites

- Snowflake account with ACCOUNTADMIN access
- Python 3.8+ installed
- Snowflake CLI (`snowflake-cli-labs`)

### Installation

```bash
# 1. Install Snowflake CLI
pip install snowflake-cli-labs

# 2. Clone repository
git clone <repository-url>
cd Snowflake_AI_Demo_Eutelsat

# 3. Configure Snowflake connection
snow connection add --connection-name telco-local

# 4. Run the pipeline
cd local-testing
./run_pipeline.sh
```

### What Gets Deployed

```
✅ Database: EUTELSAT_AI_DEMO
✅ Warehouse: EUTELSAT_DEMO_WH
✅ Role: TELCO_ANALYST_ROLE (with CORTEX_USER)
✅ 20+ tables with demo data
✅ 6 Cortex Search Services
✅ 4 Cortex Analyst Semantic Views
✅ 1 Snowflake Intelligence Agent
✅ Streamlit Applications
```

**Deployment time**: ~10 minutes

---

## ✨ Features

### 🔍 Cortex Search Services (6)

Semantic search across business documents:

| Service | Purpose | Content |
|---------|---------|---------|
| **Search Finance Docs** | Financial reports, policies, contracts | PDFs, DOCX, MD |
| **Search HR Docs** | Employee handbook, guidelines | PDFs, DOCX, MD |
| **Search Marketing Docs** | Campaigns, strategies, analysis | PDFs, DOCX, MD |
| **Search Sales Docs** | Playbooks, customer success | PDFs, DOCX, MD |
| **Search Strategy Docs** | Board presentations, market analysis | MD files |
| **Search Network Docs** | Data centres, infrastructure | MD files |

### 📊 Cortex Analyst Semantic Views (4)

Natural language SQL queries across business datamarts:

| Semantic View | Data Domain |
|---------------|-------------|
| **FINANCE_SEMANTIC_VIEW** | Revenue, expenses, vendor spend, transactions |
| **SALES_SEMANTIC_VIEW** | B2B sales, products, customers, regions |
| **MARKETING_SEMANTIC_VIEW** | Campaigns, channels, leads, ROI |
| **HR_SEMANTIC_VIEW** | Employees, departments, salaries, attrition |

### 🤖 Eutelsat Executive Agent

**12 integrated tools**:
- 4 Cortex Analyst tools (Query Finance/Sales/Marketing/HR Datamarts)
- 6 Cortex Search tools (Search internal documents)
- 1 Web scraper tool
- 1 Email sending tool

**Sample questions**:
- "Summarize GEO vs LEO coverage, availability, and latency for aviation and maritime services."
- "Break down revenue and pipeline by vertical: Broadcast & Video, Aviation, Maritime, Government, Enterprise/backhaul."
- "What did the latest FY24/25 investor deck and Q1 presentation highlight on growth and capex?"
- "Which beams or gateways show the highest utilisation, and where should we add capacity?"
- "How many active GEO satellites and OneWeb LEO satellites are in service, and what markets do they cover?"

---

## 🏗 Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                   EUTELSAT AI DEMO PLATFORM                        │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  Data Sources           AI Processing         Semantic Layer       │
│  ────────────           ──────────────        ──────────────       │
│  • CSV Files            • Cortex Search       • 4 Semantic Views   │
│  • PDFs/DOCX/MD         • Cortex Analyst      • Natural Language   │
│  • Audio Files          • AI Functions        • Text-to-SQL        │
│                                                                     │
│  ┌────────────────────────────────────────────────────────────────┐│
│  │                 SNOWFLAKE INTELLIGENCE                         ││
│  ├────────────────────────────────────────────────────────────────┤│
│  │  Eutelsat Executive Agent: 12 Tools | Multi-Modal | REST API  ││
│  └────────────────────────────────────────────────────────────────┘│
│                                                                     │
│  ┌────────────────────────────────────────────────────────────────┐│
│  │                    APPLICATIONS                                ││
│  ├────────────────────────────────────────────────────────────────┤│
│  │  Streamlit Apps  |  Snowflake Notebooks  |  REST API          ││
│  └────────────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────────────┘
```

---

## 🧪 Local Testing

### Pipeline Steps

The local testing pipeline runs 7 steps:

| Step | Name | Description |
|------|------|-------------|
| 1 | Configure Account | Create roles, warehouse, database, schemas, stages |
| 2 | Upload Files | Upload CSV data and documents to stages |
| 3 | Data Foundation | Create tables and load data |
| 4 | Deploy Search | Create 6 Cortex Search services |
| 5 | Deploy Analyst | Create 4 semantic views (owned by ACCOUNTADMIN) |
| 6 | Deploy Applications | Create agent, procedures, Streamlit apps |
| 7 | Run Notebooks | Execute data processing notebooks |

### Running the Pipeline

```bash
cd local-testing

# List all steps
./run_pipeline.sh --list

# Run full pipeline
./run_pipeline.sh

# Run specific step
./run_pipeline.sh --step 1

# Start from specific step
./run_pipeline.sh --start-from 3

# Dry run (preview only)
./run_pipeline.sh --dry-run
```

### Connection Setup

1. **Configure connection**:
```bash
snow connection add --connection-name telco-local
```

2. **Test connection**:
```bash
snow connection test -c telco-local
```

3. **Required settings**:
   - Account: Your Snowflake account locator
   - User: User with ACCOUNTADMIN access
   - Role: ACCOUNTADMIN
   - Warehouse: Any available warehouse

---

## 📁 Project Structure

```
build-an-ai-assistant-for-telco/
├── full-ci.yml                    # DataOps pipeline definition
├── README.md                      # This file
│
├── dataops/event/
│   ├── variables.yml              # Pipeline variables
│   ├── DATA/
│   │   ├── demo_data/             # 20 CSV files (dimensions, facts)
│   │   └── unstructured_docs/     # PDFs, DOCX, MD by department
│   │       ├── finance/
│   │       ├── hr/
│   │       ├── marketing/
│   │       ├── sales/
│   │       ├── strategy/
│   │       └── network/
│   │
│   ├── analyst/                   # Semantic model YAML files
│   ├── notebooks/                 # Snowflake notebooks
│   ├── streamlit/                 # Streamlit applications
│   │
│   └── *.template.sql             # SQL deployment templates
│       ├── telco_configure_account.template.sql
│       ├── telco_upload_files.template.sql
│       ├── telco_data_foundation.template.sql
│       ├── telco_deploy_search.template.sql
│       ├── telco_deploy_analyst.template.sql
│       ├── telco_deploy_applications.template.sql
│       └── telco_run_notebooks.template.sql
│
├── local-testing/
│   ├── run_pipeline.py            # Python pipeline runner
│   ├── run_pipeline.sh            # Shell wrapper
│   ├── config.toml.example        # Connection config example
│   ├── create_service_user.sql    # Service user setup
│   └── README.md                  # Local testing guide
│
└── pipelines/                     # DataOps pipeline includes
```

---

## 🎯 Use Cases

### Executive Dashboard
- Natural language queries across all business data
- "What is our revenue by product category?"
- "Show employee attrition by department"

### Document Search
- Semantic search across 60+ business documents
- "Find vendor contracts with AWS"
- "What does our expense policy say about travel?"

### Sales Analysis
- B2B sales performance by vertical, region, product
- "Top 10 customers by revenue"
- "Sales by UK region this quarter"

### Marketing ROI
- Campaign performance and attribution
- "Which campaigns generated the most leads?"
- "Marketing ROI by channel"

### Exec Questions to Try (Eutelsat)
- Multi-orbit coverage: "Show GEO vs LEO availability, latency, and congestion by service (Broadcast, Aviation, Maritime, Backhaul)."
- Broadcast reach: "How many TV channels and viewers are served across key video neighbourhoods, and what is the HD/UHD mix?"
- Mobility performance: "Top aviation/maritime routes by utilisation and SLA adherence; where do we need more capacity?"
- Investor view: "Summarize the FY24/25 investor presentations and consolidated accounts—growth drivers, capex, and leverage."
- Government & ESG: "What resilience and responsible space commitments are in the Sustainability Statement? Any recent drills/incidents?"
- Backhaul & enterprise: "Which regions need additional backhaul capacity or new gateways? Show pipeline by vertical."
- Financial mix: "Revenue and margin by vertical; trend lines for mobility/backhaul vs broadcast."
- Fleet view: "List active GEO satellites and OneWeb LEO constellation size; map coverage to major verticals."

---

## 🔧 Configuration

### Variables (dataops/event/variables.yml)

Key configuration options:

```yaml
variables:
  EVENT_DATABASE: "EUTELSAT_AI_DEMO"
  EVENT_SCHEMA: "EUTELSAT_SCHEMA"
  EVENT_WAREHOUSE: "EUTELSAT_DEMO_WH"
  EVENT_ATTENDEE_ROLE: "TELCO_ANALYST_ROLE"
```

### Customization

- Edit `variables.yml` to change database/schema names
- Add data to `DATA/demo_data/` for new tables
- Add documents to `DATA/unstructured_docs/` for search

---

## 🐛 Troubleshooting

### Connection Issues

```bash
# Test connection
snow connection test -c telco-local

# List connections
snow connection list
```

### Permission Errors

Ensure your user has ACCOUNTADMIN role:
```sql
GRANT ROLE ACCOUNTADMIN TO USER <your_user>;
```

### Template Rendering

Check rendered SQL in `local-testing/.rendered/` directory.

---

## 📝 License

This project is provided for educational and demonstration purposes.

**Data Notes**:
- All data is synthetic/generated for demonstration
- Eutelsat facts in prompts are sourced from the provided investor/ESG reports, the public website, and Wikipedia; numbers are for demo only
- Currency: all amounts in semantic views and facts are in EUR
- Datasets are Eutelsat-aligned (GEO/LEO, broadcast/aviation/maritime/backhaul/government, global gateways/teleports)
- Use only for learning Snowflake Cortex AI capabilities

**To refresh Snowflake with the latest Eutelsat data** (requires Snowflake CLI):
1) From a machine with `snow` configured:  
```bash
cd local-testing
./run_pipeline.sh --step 2 --step 3 --step 5 --step 6
```  
- Step 2: Upload updated CSVs and documents (Eutelsat PDFs)  
- Step 3: Data foundation (creates/loads tables like `eutelsat_kpi`, `region_coverage`, `activation_lead_time`, sales/finance/marketing/HR facts with EUR currency)  
- Step 5: Deploy semantic views (aligned to new columns and EUR)  
- Step 6: Deploy applications/agent (Eutelsat agent + search services)

2) Validate post-deploy (optional):
```sql
SELECT * FROM eutelsat_kpi LIMIT 5;
SELECT DISTINCT currency FROM sales_fact;
SELECT DISTINCT region_name FROM region_coverage;
SELECT DISTINCT vertical FROM sf_accounts;
```

---

<p align="center">
  <strong>Built with ❄️ Snowflake Cortex AI</strong>
</p>
