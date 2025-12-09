# Build an AI Assistant for Telco using AISQL and Snowflake Intelligence

<p align="center">
  <strong>A comprehensive AI-powered business intelligence platform for B2B telecommunications</strong>
</p>

<p align="center">
  <a href="#quick-start">Quick Start</a> •
  <a href="#features">Features</a> •
  <a href="#architecture">Architecture</a> •
  <a href="#local-testing">Local Testing</a>
</p>

---

## 🎯 Overview

This project demonstrates how to build a production-ready AI assistant for **CityFibre**, the UK's independent wholesale-only full fibre network. It uses **Snowflake Cortex AI**, **Snowflake Intelligence**, and **Cortex Analyst** to answer questions about build progress, premises passed/ready for service, partner take-up, financing, and network reliability (e.g., 4.6M premises ready for service and 620k consumers connected as of H1 2025; speeds up to 5.5 Gbps, up to 95x faster than FTTC; target 8M premises)\*.

\*Sources: `reports/CityFibre-Mid-year-update.pdf`, `reports/CFIH-Group-2024-Accounts.pdf`, and the [CityFibre website](https://cityfibre.com/).

### What You Get

**Core Data Platform**:
- **📊 20+ Dimension & Fact Tables** - Sales, Finance, Marketing, HR data
- **📄 60+ Business Documents** - PDFs, DOCX, MD files across departments
- **🎙️ 25 Call Recordings** - Customer service audio files
- **📧 Email Previews** - Sample communications data

**AI & ML Tools**:
- **🔍 6 Search Services** - Finance, HR, Marketing, Sales, Strategy, Network
- **📈 4 Semantic Views** - Finance, Sales, Marketing, HR datamarts
- **🤖 1 AI Agent** - CityFibre Executive Agent with 12 tools
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
cd Snowflake_AI_Demo_CityFibre

# 3. Configure Snowflake connection
snow connection add --connection-name telco-local

# 4. Run the pipeline
cd local-testing
./run_pipeline.sh
```

### What Gets Deployed

```
✅ Database: CITYFIBRE_AI_DEMO
✅ Warehouse: CITYFIBRE_DEMO_WH
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

### 🤖 CityFibre Executive Agent

**12 integrated tools**:
- 4 Cortex Analyst tools (Query Finance/Sales/Marketing/HR Datamarts)
- 6 Cortex Search tools (Search internal documents)
- 1 Web scraper tool
- 1 Email sending tool

**Sample questions**:
- "What is our total revenue by customer industry?"
- "Where are our data centres located?"
- "How do we compare to 8x8 and RingCentral?"
- "Which marketing campaigns generated the most leads?"

---

## 🏗 Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                   CITYFIBRE AI DEMO PLATFORM                        │
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
│  │  CityFibre Executive Agent: 12 Tools | Multi-Modal | REST API  ││
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

### Exec Questions to Try (CityFibre)
- Coverage & take-up: "Premises RFS by region vs target 8M; what’s the take-up % and velocity?"
- Partner performance: "Net adds and penetration by ISP partner (Vodafone, Sky, TalkTalk, Zen, toob, Cuckoo)."
- Revenue mix: "Top revenue by product category: FTTP tiers, DIA/Ethernet, dark fibre, backhaul, wholesale access."
- Network quality: "Uptime and latency by region; where do we need capacity or resilience upgrades?"
- Delivery: "Median/P90 install lead times by product and region; main blockers (civils/wayleaves)."
- Financing/ROI: "Summarize the £2.3bn 2025 financing and planned capex deployment; which segments drive ARPA/ARPU uplift?"
- Smart city/public sector: "Recent campus/transport/CCTV/IoT connections and SLA/NPS highlights."
- Mobile/5G: "Where do we need additional backhaul or Open RAN fronthaul capacity?"
- Marketing/demand: "Which campaigns or co-marketing motions are driving the most net adds and installs?"

---

## 🔧 Configuration

### Variables (dataops/event/variables.yml)

Key configuration options:

```yaml
variables:
  EVENT_DATABASE: "CITYFIBRE_AI_DEMO"
  EVENT_SCHEMA: "CITYFIBRE_SCHEMA"
  EVENT_WAREHOUSE: "CITYFIBRE_DEMO_WH"
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
- CityFibre facts in prompts are sourced from the included official reports (`reports/CFIH-Group-2024-Accounts.pdf`, `reports/CityFibre-Mid-year-update.pdf`) and the public website; numbers are for demo only
- Use only for learning Snowflake Cortex AI capabilities

---

<p align="center">
  <strong>Built with ❄️ Snowflake Cortex AI</strong>
</p>
