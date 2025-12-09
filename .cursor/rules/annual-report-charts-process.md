# Annual Report Chart Generation Process

**Purpose**: Create professional SVG charts and KPI visualizations for all 22 annual reports  
**Output**: Embedded SVG images in markdown documents  
**Principle**: Each company gets customized charts with their brand colors

---

## Process Overview

### 4-Step Workflow

1. **Design Chart Types** - Determine what charts each company needs
2. **Create SVG Files** - Generate company-branded SVG charts
3. **Organize Assets** - Store in structured directories
4. **Embed in Markdown** - Reference SVGs using markdown image syntax

---

## Step 1: Chart Types by Company

### Universal Charts (All Companies)

**1. Revenue Growth Timeline**
- Line chart showing revenue progression
- FY2024: Show FY2022, FY2023, FY2024
- FY2025: Show FY2023, FY2024, FY2025
- Brand colors for line and points

**2. Key Metrics Dashboard**
- 3-4 KPI cards in grid layout
- Revenue, Growth %, NRR, Customers
- Large numbers with icons
- Brand gradient backgrounds

**3. Financial Summary Bar Chart**
- Revenue vs. Operating Income comparison
- Side-by-side bars
- Show profitability progress

### Company-Specific Charts

**SNOW**:
- Market share pie chart (SNOW vs. ICBG vs. QRYQ vs. Others)
- Customer growth area chart
- NRNT episode timeline (FY2025 only) - stock price impact

**NRNT**:
- FY2024: Explosive growth chart (vertical bars shooting up)
- FY2025: Stock crash waterfall chart (-90.4% collapse)
- Timeline visualization (Aug peak → Nov delisting)

**ICBG**:
- Win rate vs. Snowflake (gauge chart)
- Open standard adoption curve
- Data under management growth

**QRYQ**:
- Price-performance comparison (QRYQ vs. SNOW bars)
- Win rate progression (23% → 37%)
- Competitive positioning matrix

**DFLX**:
- Platform neutrality diagram (works with all)
- Path to profitability chart (Q1-Q4 margins)
- Multi-platform customer distribution

**STRM**:
- Connector growth (203 → 342)
- Events processed volume (billions)
- Batch vs. Streaming shift (pie chart)

**VLTA**:
- Highest growth rate comparison (312%)
- ACV comparison ($512K vs. others)
- ML models managed growth

**CTLG**:
- Governance coverage (platforms governed)
- Compliance timeline (GDPR, CCPA, AI regs)
- Cost savings vs. bundled solutions (30-40%)

**PROP, GAME, MKTG**:
- Simpler charts (fewer, less elaborate)
- Focus on key metrics only
- Growth trajectory and challenges

---

## Step 2: SVG Specifications

### Directory Structure

```
annual_reports_2024/
├── charts/
│   ├── SNOW/
│   │   ├── revenue_growth.svg
│   │   ├── key_metrics.svg
│   │   ├── market_share.svg
│   │   └── customer_growth.svg
│   ├── NRNT/
│   │   ├── revenue_growth.svg
│   │   ├── key_metrics.svg
│   │   └── growth_trajectory.svg
│   └── [other companies...]
│
annual_reports_2025/
├── charts/
│   ├── SNOW/
│   │   ├── revenue_growth.svg
│   │   ├── key_metrics.svg
│   │   ├── nrnt_episode.svg  (unique to FY2025)
│   │   └── competitive_position.svg
│   ├── NRNT/
│   │   ├── stock_crash.svg  (unique to FY2025)
│   │   ├── timeline.svg
│   │   └── liquidation_recovery.svg
│   └── [other companies...]
```

### SVG Template Structure

**Dimensions**: 800x400px (standard chart size)  
**ViewBox**: 0 0 800 400 (responsive)  
**Company Colors**: Use gradient from design specs  

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 400" width="800" height="400">
  <!-- Define company gradient -->
  <defs>
    <linearGradient id="companyGradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" style="stop-color:#PRIMARY_START;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#PRIMARY_END;stop-opacity:1" />
    </linearGradient>
  </defs>
  
  <!-- Chart background -->
  <rect width="800" height="400" fill="#FAFAFA" rx="10"/>
  
  <!-- Chart title -->
  <text x="400" y="30" text-anchor="middle" font-size="20" font-weight="700" fill="#333">
    Chart Title
  </text>
  
  <!-- Chart content (bars, lines, etc.) -->
  <!-- ... -->
  
  <!-- Axis labels, legends, etc. -->
  <!-- ... -->
</svg>
```

---

## Step 3: Standard Chart Types

### 1. Revenue Growth Line Chart

**Data Points**: 3-4 fiscal years  
**Y-Axis**: Revenue in millions  
**X-Axis**: Fiscal years  
**Style**: Line with gradient fill underneath  

```svg
<!-- Revenue growth line chart template -->
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 400">
  <defs>
    <linearGradient id="lineGradient" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" stop-color="[COMPANY_PRIMARY]" stop-opacity="0.3"/>
      <stop offset="100%" stop-color="[COMPANY_PRIMARY]" stop-opacity="0.05"/>
    </linearGradient>
  </defs>
  
  <rect width="800" height="400" fill="#FAFAFA" rx="10"/>
  
  <!-- Grid lines -->
  <line x1="100" y1="350" x2="700" y2="350" stroke="#DDD" stroke-width="2"/>
  <line x1="100" y1="100" x2="100" y2="350" stroke="#DDD" stroke-width="2"/>
  
  <!-- Data line and area fill -->
  <path d="M 150,300 L 300,250 L 450,180 L 600,120" 
        stroke="[COMPANY_PRIMARY]" stroke-width="4" fill="none"/>
  
  <path d="M 150,300 L 300,250 L 450,180 L 600,120 L 600,350 L 150,350 Z" 
        fill="url(#lineGradient)"/>
  
  <!-- Data points -->
  <circle cx="150" cy="300" r="8" fill="[COMPANY_PRIMARY]"/>
  <circle cx="300" cy="250" r="8" fill="[COMPANY_PRIMARY]"/>
  <circle cx="450" cy="180" r="8" fill="[COMPANY_PRIMARY]"/>
  <circle cx="600" cy="120" r="8" fill="[COMPANY_PRIMARY]"/>
  
  <!-- Labels -->
  <text x="150" y="375" text-anchor="middle" font-size="14">FY2022</text>
  <text x="300" y="375" text-anchor="middle" font-size="14">FY2023</text>
  <text x="450" y="375" text-anchor="middle" font-size="14">FY2024</text>
  <text x="600" y="375" text-anchor="middle" font-size="14">FY2025</text>
  
  <!-- Values -->
  <text x="150" y="290" text-anchor="middle" font-size="12" font-weight="700">$XXM</text>
  <!-- ... -->
</svg>
```

### 2. KPI Dashboard (4 metrics)

**Layout**: 2x2 grid of metric cards  
**Each Card**: Icon + Large number + Label  
**Colors**: Company gradient background  

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 400">
  <rect width="800" height="400" fill="#FAFAFA" rx="10"/>
  
  <!-- Card 1: Revenue -->
  <rect x="50" y="50" width="340" height="150" rx="10" fill="url(#gradient1)"/>
  <text x="220" y="100" text-anchor="middle" font-size="48" font-weight="900" fill="white">$XXB</text>
  <text x="220" y="130" text-anchor="middle" font-size="16" fill="white" opacity="0.9">Total Revenue</text>
  <text x="220" y="180" text-anchor="middle" font-size="24" font-weight="700" fill="white">+XX% YoY</text>
  
  <!-- Card 2: Customers -->
  <rect x="410" y="50" width="340" height="150" rx="10" fill="url(#gradient2)"/>
  <!-- ... -->
  
  <!-- Card 3: NRR -->
  <rect x="50" y="220" width="340" height="150" rx="10" fill="url(#gradient3)"/>
  <!-- ... -->
  
  <!-- Card 4: Margin/Profit -->
  <rect x="410" y="220" width="340" height="150" rx="10" fill="url(#gradient4)"/>
  <!-- ... -->
</svg>
```

### 3. Bar Chart (Side-by-Side Comparison)

**Use Cases**: Revenue vs. competitors, quarterly progression  
**Style**: Company color bars with values on top  

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 400">
  <!-- Background -->
  <rect width="800" height="400" fill="#FAFAFA" rx="10"/>
  
  <!-- Bars -->
  <rect x="100" y="150" width="80" height="200" rx="5" fill="[COMPANY_PRIMARY]"/>
  <rect x="200" y="200" width="80" height="150" rx="5" fill="[COMPANY_SECONDARY]"/>
  <!-- ... more bars ... -->
  
  <!-- Value labels on top of bars -->
  <text x="140" y="140" text-anchor="middle" font-size="16" font-weight="700">$XXM</text>
  <!-- ... -->
  
  <!-- X-axis labels -->
  <text x="140" y="380" text-anchor="middle" font-size="14">Q1</text>
  <text x="240" y="380" text-anchor="middle" font-size="14">Q2</text>
  <!-- ... -->
</svg>
```

### 4. NRNT-Specific: Stock Crash Waterfall

**FY2025 Only**: Visualize -90.4% crash  
**Style**: Waterfall chart with red cascading bars  
**Timeline**: Sept → Oct → Nov collapse  

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 500">
  <rect width="800" height="500" fill="#FFF" rx="10"/>
  
  <!-- Title -->
  <text x="400" y="30" text-anchor="middle" font-size="22" font-weight="700" fill="#DC2626">
    NRNT Stock Crash: September - November 2024
  </text>
  
  <!-- Starting point (Sept 19) -->
  <rect x="100" y="100" width="80" height="300" rx="5" fill="#9C27B0"/>
  <text x="140" y="90" text-anchor="middle" font-size="16" font-weight="700">$133.75</text>
  <text x="140" y="430" text-anchor="middle" font-size="12">Sept 19</text>
  
  <!-- Decline bars -->
  <rect x="220" y="200" width="80" height="200" rx="5" fill="#E91E63"/>
  <text x="260" y="190" text-anchor="middle">$108</text>
  <text x="260" y="430" text-anchor="middle" font-size="12">Nov 1</text>
  
  <rect x="340" y="280" width="80" height="120" rx="5" fill="#DC2626"/>
  <text x="380" y="270" text-anchor="middle">$69</text>
  <text x="380" y="430" text-anchor="middle" font-size="12">Nov 14</text>
  
  <!-- Final delisting -->
  <rect x="460" y="370" width="80" height="30" rx="5" fill="#7F1D1D"/>
  <text x="500" y="360" text-anchor="middle" font-size="16" font-weight="700" fill="#DC2626">$12.79</text>
  <text x="500" y="430" text-anchor="middle" font-size="12" font-weight="700">Nov 20</text>
  <text x="500" y="448" text-anchor="middle" font-size="10" fill="#DC2626">DELISTED</text>
  
  <!-- Connecting lines showing decline -->
  <line x1="180" y1="250" x2="220" y2="300" stroke="#DC2626" stroke-width="3" stroke-dasharray="5,5"/>
  <line x1="300" y1="300" x2="340" y2="350" stroke="#DC2626" stroke-width="3" stroke-dasharray="5,5"/>
  <line x1="420" y1="350" x2="460" y2="390" stroke="#DC2626" stroke-width="3" stroke-dasharray="5,5"/>
  
  <!-- Percentage labels -->
  <text x="250" y="280" font-size="14" fill="#DC2626" font-weight="600">-19%</text>
  <text x="370" y="330" font-size="14" fill="#DC2626" font-weight="600">-48%</text>
  <text x="490" y="380" font-size="14" fill="#DC2626" font-weight="600">-90%</text>
</svg>
```

---

## Step 2: Chart Inventory by Company

### SNOW (Snowflake)

**FY2024 Charts**:
1. `revenue_growth.svg` - 3-year revenue growth
2. `key_metrics.svg` - Revenue, Customers, NRR, RPO
3. `customer_segments.svg` - >$1M customers growth

**FY2025 Charts**:
1. `revenue_growth.svg` - 3-year revenue growth
2. `key_metrics.svg` - Revenue, Customers, NRR, FCF
3. `nrnt_episode_timeline.svg` - Stock price Sept-Nov 2024
4. `competitive_position.svg` - SNOW vs. ICBG vs. QRYQ market share

### NRNT (Neuro-Nectar)

**FY2024 Charts**:
1. `explosive_growth.svg` - Vertical rocket ship showing 412% growth
2. `key_metrics.svg` - Revenue, Units, Locations, Margin
3. `warning_signs.svg` - Return rate 18% vs. industry 2-3%

**FY2025 Charts**:
1. `stock_crash_waterfall.svg` - $133.75 → $12.79 collapse visualization
2. `timeline_collapse.svg` - 62 days from peak to delisting
3. `asset_liquidation.svg` - Recovery rates (7.6% on assets)

### ICBG (ICBG Data Systems)

**FY2024 Charts**:
1. `revenue_growth.svg`
2. `key_metrics.svg`
3. `iceberg_adoption.svg` - Apache Iceberg ecosystem growth

**FY2025 Charts**:
1. `revenue_growth.svg`
2. `key_metrics.svg`
3. `win_rate_snow.svg` - 29% win rate vs. Snowflake (gauge)
4. `open_lakehouse_market.svg` - Market share in open segment

### QRYQ (Querybase)

**FY2024 Charts**:
1. `revenue_growth.svg`
2. `key_metrics.svg`
3. `win_rate_progression.svg` - 14% → 23% vs. SNOW

**FY2025 Charts**:
1. `revenue_growth.svg`
2. `key_metrics.svg`
3. `win_rate_vs_snow.svg` - 37% competitive wins
4. `price_performance.svg` - 2.1x better than SNOW benchmark

### DFLX, STRM, VLTA, CTLG

**Each gets**:
- revenue_growth.svg
- key_metrics.svg
- Company-specific metric (1 unique chart)

**FY2025 additions for DFLX, CTLG**:
- path_to_profitability.svg (showing Q1-Q4 margin progression to positive)

### PROP, GAME, MKTG (Bottom 3)

**Simplified** (2-3 charts each):
- revenue_growth.svg
- key_metrics.svg (simpler, 2-metric version)
- Optional: challenge_indicator.svg (showing burn rate concern)

---

## Step 3: SVG Generation Standards

### Brand Color Application

Each company's SVGs use their specific gradient:

```javascript
const COMPANY_COLORS = {
  SNOW: { start: '#2962FF', end: '#0D47A1', light: '#E3F2FD' },
  NRNT: { start: '#9C27B0', end: '#E91E63', light: '#F3E5F5' },
  ICBG: { start: '#00BCD4', end: '#006064', light: '#E0F7FA' },
  QRYQ: { start: '#FF5722', end: '#D84315', light: '#FFF3E0' },
  DFLX: { start: '#4CAF50', end: '#2E7D32', light: '#E8F5E9' },
  STRM: { start: '#3F51B5', end: '#7C4DFF', light: '#E8EAF6' },
  VLTA: { start: '#FDD835', end: '#F57F17', light: '#FFF9C4' },
  CTLG: { start: '#37474F', end: '#607D8B', light: '#ECEFF1' },
  PROP: { start: '#14B8A6', end: '#0D9488', light: '#CCFBF1' },
  GAME: { start: '#A855F7', end: '#7C3AED', light: '#F3E8FF' },
  MKTG: { start: '#F97316', end: '#EA580C', light: '#FFF7ED' }
};
```

### Typography Standards

```svg
<!-- Title -->
font-family: "-apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif"
font-size: 20-24px
font-weight: 700
fill: #333

<!-- Axis Labels -->
font-size: 12-14px
font-weight: 400
fill: #666

<!-- Data Labels (values on charts) -->
font-size: 14-16px
font-weight: 700
fill: [COMPANY_PRIMARY] or white (on colored backgrounds)

<!-- Legends -->
font-size: 12px
font-weight: 600
fill: #444
```

### Chart Elements

**Grid Lines**: `stroke="#DDD" stroke-width="1"`  
**Axes**: `stroke="#888" stroke-width="2"`  
**Bars**: `fill="url(#companyGradient)" rx="5"` (rounded corners)  
**Lines**: `stroke="[COMPANY_PRIMARY]" stroke-width="3-4"`  
**Points**: `fill="[COMPANY_PRIMARY]" r="6-8"`  

---

## Step 4: Markdown Embedding

### Image Syntax

```markdown
## Financial Performance

![Revenue Growth](charts/SNOW/revenue_growth.svg)

*Figure 1: Revenue growth trajectory showing 38% YoY increase*
```

### With Sizing

```markdown
<p align="center">
  <img src="charts/SNOW/key_metrics.svg" width="800" alt="Key Financial Metrics"/>
</p>

*Key metrics dashboard for FY2025*
```

### Multiple Charts in Grid

```markdown
<div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; margin: 30px 0;">
  <div>
    <img src="charts/SNOW/revenue_growth.svg" width="100%" alt="Revenue Growth"/>
    <p style="text-align: center; font-size: 12px; color: #666; margin-top: 10px;">
      <em>Revenue Growth Trend</em>
    </p>
  </div>
  <div>
    <img src="charts/SNOW/customer_growth.svg" width="100%" alt="Customer Growth"/>
    <p style="text-align: center; font-size: 12px; color: #666; margin-top: 10px;">
      <em>Customer Expansion</em>
    </p>
  </div>
</div>
```

---

## Step 5: Placement Strategy

### Where to Insert Charts

**After "Financial Highlights" section**:
- KPI Dashboard (4 key metrics)

**In "Financial Performance" section**:
- Revenue growth chart
- Operating margin progression

**In Company-Specific Sections**:
- Competitive positioning charts
- Market share visualizations
- NRNT episode timeline (SNOW FY2025)
- Stock crash (NRNT FY2025)

**Before "Outlook" section**:
- Summary metrics or trend chart

---

## Implementation Plan

### Phase 1: Create Core Charts (All Companies)

For each company, create:
1. ✅ `revenue_growth.svg` - Standard line chart
2. ✅ `key_metrics.svg` - 4-metric dashboard

**Priority**: FY2025 reports first (more comprehensive)

### Phase 2: Create Company-Specific Charts

Unique charts per company based on their narrative:
- SNOW: NRNT episode timeline, competitive position
- NRNT: Stock crash waterfall, liquidation visualization
- ICBG: Win rates, open standard adoption
- QRYQ: Price-performance comparison, competitive wins
- DFLX, CTLG: Path to profitability (Q1-Q4 progression)
- VLTA: Highest growth comparison, ACV leadership
- STRM: Batch→Streaming shift
- PROP, GAME, MKTG: Challenge indicators, unit economics

### Phase 3: Embed in Markdown

- Insert image references in appropriate sections
- Add captions and context
- Ensure responsive sizing
- Test rendering in markdown viewers

### Phase 4: FY2024 Charts

Create simplified versions for FY2024 reports:
- Same core charts (revenue, KPIs)
- No NRNT collapse charts (didn't happen yet)
- Show earlier-stage metrics

---

## Quality Checklist

For each SVG:
- [ ] Uses company brand colors (gradient)
- [ ] Proper viewBox for responsiveness
- [ ] Readable text (proper sizing, contrast)
- [ ] Data labels visible and accurate
- [ ] Grid lines and axes styled consistently
- [ ] Rounded corners on shapes (rx="5-10")
- [ ] Shadows or depth where appropriate
- [ ] Company icon/branding subtle watermark
- [ ] Renders correctly in markdown viewers
- [ ] File size optimized (<50KB per SVG)

For each markdown embedding:
- [ ] Image path relative to markdown file
- [ ] Alt text descriptive
- [ ] Caption with context
- [ ] Sizing appropriate (width="800" or 100%)
- [ ] Alignment specified (center for key charts)
- [ ] Spacing around charts (margins)

---

## Automation Possibilities

### Script-Based Generation

**Python + SVG Template**:
```python
def create_revenue_chart(company, years, values, colors):
    template = load_svg_template('revenue_growth_template.svg')
    svg = template.format(
        company=company,
        gradient_start=colors['start'],
        gradient_end=colors['end'],
        years=years,
        values=values,
        # ... data points, labels, etc.
    )
    save_svg(f'charts/{company}/revenue_growth.svg', svg)
```

### Batch Generation

```bash
# Generate all core charts for all companies
python generate_annual_report_charts.py --year 2025 --type core --all-companies

# Generate company-specific charts
python generate_annual_report_charts.py --year 2025 --type specific --company SNOW
```

---

## Expected Output

### Directory Structure After Generation

```
annual_reports_2024/
├── charts/
│   ├── SNOW/ (4 SVGs)
│   ├── NRNT/ (3 SVGs)
│   ├── ICBG/ (3 SVGs)
│   ├── QRYQ/ (3 SVGs)
│   ├── DFLX/ (2 SVGs)
│   ├── STRM/ (2 SVGs)
│   ├── VLTA/ (2 SVGs)
│   ├── CTLG/ (2 SVGs)
│   ├── PROP/ (2 SVGs)
│   ├── GAME/ (2 SVGs)
│   └── MKTG/ (2 SVGs)
│
annual_reports_2025/
├── charts/
│   ├── SNOW/ (5 SVGs - includes NRNT episode chart)
│   ├── NRNT/ (4 SVGs - includes crash/liquidation charts)
│   ├── ICBG/ (4 SVGs)
│   ├── QRYQ/ (4 SVGs)
│   ├── DFLX/ (3 SVGs - includes profitability chart)
│   ├── STRM/ (3 SVGs)
│   ├── VLTA/ (3 SVGs)
│   ├── CTLG/ (3 SVGs - includes profitability chart)
│   ├── PROP/ (2 SVGs)
│   ├── GAME/ (3 SVGs)
│   └── MKTG/ (2 SVGs)
│
Total SVG Files: ~60-70 charts
```

### Enhanced Markdown

Each annual report will have:
- Professional branded header (already done ✅)
- 2-5 embedded SVG charts (to be added)
- Visual storytelling with data
- Print-ready layout

---

## Benefits

✅ **Visual Impact**: Charts make reports more engaging  
✅ **Data Clarity**: Complex metrics easier to understand  
✅ **Professional Quality**: Corporate annual report standards  
✅ **Brand Consistency**: Company colors throughout  
✅ **Storytelling**: Visualize key narratives (NRNT crash, profitability journey)  
✅ **Reusable**: SVGs can be used in other materials  
✅ **Scalable**: Vector graphics scale to any size  
✅ **Accessible**: Alt text and captions for screen readers  

---

## Next Steps

1. ✅ **Process Defined** - This document
2. ⏭️ **Create Core Charts** - Revenue growth + KPI dashboards for all 11 companies
3. ⏭️ **Create Unique Charts** - Company-specific visualizations
4. ⏭️ **Embed in Markdown** - Add image references to annual reports
5. ⏭️ **Review & Refine** - Test rendering, adjust sizing/placement
6. ⏭️ **Document** - Update READMEs with chart descriptions

**Estimated Effort**:
- Core charts (22 revenue + 22 KPI): ~2 hours
- Unique charts (~20 additional): ~2 hours
- Embedding in markdown: ~1 hour
- **Total**: ~5 hours for complete visualization package

**Is this approach acceptable?** If yes, I'll proceed to create all the SVG charts and embed them in the reports! 🎯


