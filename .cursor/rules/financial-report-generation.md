# Financial Report Generation Workflow

## Overview
Process for creating realistic synthetic financial reports for core companies in the FSI Cortex Assistant demo.

## Report Types
- **Quarterly Earnings Reports** - Q2/Q3/Q4 financial results
- **Format**: PDF (generated from SVG)
- **Target Date**: August 2024 (immediately following earnings calls)

## 4-Step Workflow

### Step 1: Company Branding & Styling
Create unique visual identity for each of the 8 core companies:

#### Brand Elements:
- **Primary Color** - Main brand color (used in headers, accents)
- **Secondary Color** - Supporting color (used in charts, highlights)
- **Font Choices** - Professional corporate fonts
- **Logo Style** - Text-based or abstract mark
- **Design Aesthetic** - Modern, traditional, tech-forward, etc.

#### Example Branding:
```
SNOW: Blue gradient (#2962FF → #0D47A1), modern sans-serif, snowflake icon
NRNT: Purple/pink (#9C27B0 → #E91E63), playful modern, neuron/brain icon
ICBG: Teal/cyan (#00BCD4 → #006064), open-source feel, iceberg icon
QRYQ: Orange/red (#FF5722 → #D84315), aggressive bold, lightning icon
DFLX: Green (#4CAF50 → #2E7D32), neutral professional, flex/wave icon
STRM: Blue-purple (#3F51B5 → #7C4DFF), flowing modern, stream/pipeline icon
VLTA: Electric yellow (#FDD835 → #F57F17), AI-forward, lightning bolt
CTLG: Navy/gray (#37474F → #607D8B), governance, shield/catalog icon
```

### Step 2: Content Creation (Markdown)
Draft report content in markdown to establish structure:

#### Report Sections:
1. **Cover Page**
   - Company name and logo
   - Report title (e.g., "Q2 FY2025 Financial Results")
   - Date (August 2024)
   - Confidential/Investor Relations footer

2. **Executive Summary**
   - Key financial highlights (1-2 paragraphs)
   - Revenue, growth rate, profitability metrics
   - Strategic highlights

3. **Financial Performance**
   - Revenue breakdown (table)
   - Operating metrics (chart references)
   - Year-over-year comparisons
   - Sequential quarter comparisons

4. **Business Highlights**
   - Customer growth
   - Product developments
   - Market positioning
   - Competitive dynamics (reference other core companies)

5. **Financial Statements (Simplified)**
   - Income statement summary
   - Balance sheet highlights
   - Cash flow summary

6. **Outlook & Guidance**
   - Q3/Q4 guidance
   - Full year outlook
   - Strategic priorities

7. **Investor Information**
   - Contact details
   - Disclaimer language
   - Date and report ID

#### Content Sources:
- **Revenue/metrics**: Extract from `DATA/companies.csv` story field
- **Narrative consistency**: Reference earnings calls from `DATA/unique_transcripts.csv`
- **Timeline accuracy**: Follow `.cursor/rules/timeline.md`
- **Relationships**: Show partnerships/competition per `.cursor/rules/company-narratives.md`

### Step 3: SVG Design (Professional Layout)
Convert markdown to sophisticated SVG document:

#### Design Principles:
- **Professional**: Corporate annual report aesthetic
- **Clean**: Ample whitespace, clear hierarchy
- **Data Visualization**: Charts, graphs, tables with brand colors
- **Typography**: Consistent heading styles, readable body text
- **Branding**: Company colors throughout, logo on every page

#### SVG Structure:
```svg
<svg width="816" height="1056" xmlns="http://www.w3.org/2000/svg">
  <!-- Page 1: Cover -->
  <g id="cover-page">
    <!-- Background gradient -->
    <!-- Company logo -->
    <!-- Report title -->
    <!-- Date -->
  </g>
  
  <!-- Page 2: Executive Summary -->
  <g id="page-2" transform="translate(850, 0)">
    <!-- Header with logo -->
    <!-- Content sections -->
    <!-- Footer with page number -->
  </g>
  
  <!-- Additional pages... -->
</svg>
```

#### Key SVG Elements:
- **Gradients**: `<linearGradient>` for brand colors
- **Text**: `<text>` with proper font-family, size, weight
- **Shapes**: `<rect>`, `<circle>` for design elements
- **Charts**: `<path>` for line charts, `<rect>` for bar charts
- **Tables**: Aligned `<text>` elements with `<line>` separators

#### Chart Types:
- **Revenue Growth**: Line or bar chart showing quarterly progression
- **Customer Growth**: Stacked area or bar chart
- **Operating Margins**: Line chart with trend line
- **Market Share**: Pie or bar chart (if applicable)

### Step 4: PDF Conversion
Convert SVG to PDF using available tools:

#### Option 1: Inkscape (CLI)
```bash
inkscape --export-type=pdf --export-filename=output.pdf input.svg
```

#### Option 2: rsvg-convert (librsvg)
```bash
rsvg-convert -f pdf -o output.pdf input.svg
```

#### Option 3: Chromium/Puppeteer (Node.js)
```javascript
const puppeteer = require('puppeteer');
const browser = await puppeteer.launch();
const page = await browser.newPage();
await page.setContent(svgHtml);
await page.pdf({ path: 'output.pdf', format: 'Letter' });
```

#### Option 4: Python (cairosvg)
```python
import cairosvg
cairosvg.svg2pdf(url='input.svg', write_to='output.pdf')
```

## File Organization

### Directory Structure:
```
document_ai/
├── financial_reports/
│   ├── august_2024/
│   │   ├── SNOW_Q2_FY2025_Report.pdf
│   │   ├── NRNT_Q2_FY2025_Report.pdf
│   │   ├── ICBG_Q2_FY2025_Report.pdf
│   │   ├── QRYQ_Q2_FY2025_Report.pdf
│   │   ├── DFLX_Q2_FY2025_Report.pdf
│   │   ├── STRM_Q2_FY2025_Report.pdf
│   │   ├── VLTA_Q2_FY2025_Report.pdf
│   │   └── CTLG_Q2_FY2025_Report.pdf
│   ├── svg_source/
│   │   └── august_2024/
│   │       ├── SNOW_Q2_FY2025.svg
│   │       └── ... (all SVG files)
│   └── markdown_drafts/
│       └── august_2024/
│           ├── SNOW_Q2_FY2025.md
│           └── ... (all markdown files)
```

## Consistency Requirements

### Temporal Consistency:
- Reports dated August 2024 (after Aug 22-30 earnings calls)
- Content reflects pre-NRNT-collapse period
- All 8 companies operating normally
- NRNT showing strong growth (487% YoY)

### Cross-References:
- SNOW mentions competition from ICBG, QRYQ
- DFLX/STRM/VLTA/CTLG mention partnerships with data platforms
- NRNT mentions potential enterprise applications
- All companies reference market dynamics

### Financial Accuracy:
- Revenue numbers match `DATA/companies.csv` story field
- Growth rates consistent with company narratives
- Metrics align with earnings call transcripts

## Quality Checklist

Before finalizing each report:
- ✅ Brand colors applied consistently
- ✅ Company name/ticker correct throughout
- ✅ Financial figures match source data
- ✅ Cross-references to other companies accurate
- ✅ Timeline consistent (August 2024, pre-collapse)
- ✅ Charts/tables readable and professional
- ✅ Typography consistent and clean
- ✅ PDF renders correctly with all elements visible
- ✅ File naming convention followed

## Automation Considerations

For bulk generation:
1. Create JSON config with all company branding
2. Template SVG with variable substitution
3. Script to generate all 8 reports from data
4. Batch PDF conversion

---

**This workflow ensures consistent, professional, realistic financial reports that integrate seamlessly with the existing synthetic dataset.**

