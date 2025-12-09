# Annual Report Design Specifications

**Purpose**: Detailed CSS and design specifications for each company's annual reports  
**Principle**: Each company has a unique visual identity while maintaining professional standards

---

## Design Philosophy

- **Professional**: Corporate annual report aesthetic
- **Unique**: Each company has distinctive visual style
- **Consistent**: Same structural elements across all reports
- **Brand-Aligned**: Colors match cursor rules and existing materials
- **Readable**: High contrast, clear typography

---

## 1. SNOW (Snowflake Inc.)

### Brand Identity
- **Primary Colors**: #2962FF (vibrant blue) → #0D47A1 (deep blue)
- **Accent**: #29B5E8 (Snowflake brand blue)
- **Aesthetic**: Clean, modern, enterprise-grade
- **Icon**: ❄️ Snowflake
- **Personality**: Market leader, confident, innovative

### CSS Specifications

```html
<!-- Header -->
<div style="background: linear-gradient(135deg, #2962FF 0%, #0D47A1 100%); color: white; padding: 50px 40px; text-align: center; border-radius: 10px; margin-bottom: 30px; box-shadow: 0 10px 30px rgba(41, 98, 255, 0.3);">
  <div style="display: inline-block; background: rgba(255,255,255,0.15); padding: 15px 30px; border-radius: 50px; margin-bottom: 20px; backdrop-filter: blur(10px);">
    <h1 style="margin: 0; font-size: 48px; font-weight: 700; letter-spacing: -1px;">❄️ Snowflake Inc.</h1>
  </div>
  <h2 style="margin: 15px 0 0 0; font-weight: 300; font-size: 28px; opacity: 0.95;">Annual Report - Fiscal Year 20XX</h2>
  <p style="margin: 15px 0 0 0; font-size: 18px; opacity: 0.9;">Year Ended April 30, 20XX</p>
  <div style="margin-top: 25px; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.3);">
    <p style="margin: 0; font-size: 16px; font-weight: 600; letter-spacing: 3px;">NASDAQ: SNOW</p>
  </div>
</div>

<!-- Section Headers -->
<h2 style="color: #2962FF; border-left: 5px solid #29B5E8; padding-left: 15px; font-size: 28px; margin: 30px 0 15px 0;">Section Title</h2>

<!-- Key Metrics Box -->
<div style="background: linear-gradient(135deg, #E3F2FD 0%, #BBDEFB 100%); border-left: 5px solid #2962FF; padding: 20px; border-radius: 8px; margin: 20px 0;">
  <strong>Key Metric</strong>: Value
</div>

<!-- Tables -->
<table style="width: 100%; border-collapse: collapse; margin: 20px 0; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
  <thead style="background: linear-gradient(135deg, #2962FF 0%, #0D47A1 100%); color: white;">
    <tr><th style="padding: 12px; text-align: left;">Header</th></tr>
  </thead>
  <tbody>
    <tr style="border-bottom: 1px solid #E3F2FD;"><td style="padding: 10px;">Data</td></tr>
  </tbody>
</table>
```

---

## 2. NRNT (Neuro-Nectar Corporation)

### Brand Identity
- **Primary Colors**: #9C27B0 (vibrant purple) → #E91E63 (hot pink)
- **Warning Color**: #DC2626 (red for liquidation)
- **Aesthetic**: Playful, innovative (FY2024) → Distressed, warning (FY2025)
- **Icon**: 🧠 Brain
- **Personality**: Disruptive innovator turned cautionary tale

### CSS Specifications

```html
<!-- FY2024 Header (Pre-Collapse) -->
<div style="background: linear-gradient(135deg, #9C27B0 0%, #E91E63 100%); color: white; padding: 50px 40px; text-align: center; border-radius: 10px; margin-bottom: 30px; box-shadow: 0 10px 30px rgba(156, 39, 176, 0.4);">
  <div style="background: rgba(255,255,255,0.2); display: inline-block; padding: 10px 25px; border-radius: 30px; margin-bottom: 15px;">
    <span style="font-size: 40px;">🧠</span>
  </div>
  <h1 style="margin: 0; font-size: 48px; font-weight: 700;">Neuro-Nectar Corporation</h1>
  <h2 style="margin: 15px 0 0 0; font-weight: 300; font-size: 26px;">Annual Report - Fiscal Year 20XX</h2>
  <p style="margin: 15px 0 0 0; font-size: 18px;">Year Ended April 30, 20XX</p>
  <p style="margin: 20px 0 0 0; font-size: 16px; font-weight: 600; letter-spacing: 2px;">NYSE: NRNT</p>
  <p style="margin: 5px 0 0 0; font-size: 14px; font-style: italic; opacity: 0.9;">Cognitive Enhancement Through Neuronutrient Innovation</p>
</div>

<!-- FY2025 Liquidation Header (Post-Collapse) -->
<div style="background: linear-gradient(135deg, #9C27B0 0%, #E91E63 100%); color: white; padding: 50px 40px; text-align: center; border-radius: 10px; margin-bottom: 30px; box-shadow: 0 10px 40px rgba(220, 38, 38, 0.5); border: 6px solid #DC2626;">
  <div style="background: #DC2626; display: inline-block; padding: 15px 40px; border-radius: 8px; margin-bottom: 20px; animation: pulse 2s infinite;">
    <h2 style="margin: 0; font-size: 24px; font-weight: 700; letter-spacing: 2px;">⚠️ IN LIQUIDATION - FINAL REPORT ⚠️</h2>
  </div>
  <div style="background: rgba(255,255,255,0.2); display: inline-block; padding: 10px 25px; border-radius: 30px; margin-bottom: 15px;">
    <span style="font-size: 40px;">🧠</span>
  </div>
  <h1 style="margin: 0; font-size: 48px; font-weight: 700;">Neuro-Nectar Corporation</h1>
  <p style="margin: 15px 0; font-size: 18px; background: rgba(0,0,0,0.3); display: inline-block; padding: 8px 20px; border-radius: 5px;">Liquidation Commenced: November 20, 2024</p>
  <p style="margin: 10px 0 0 0; font-size: 16px;">Reporting Period: May 1, 2024 - November 20, 2024</p>
  <p style="margin: 25px 0 0 0; font-size: 16px; font-weight: 600; letter-spacing: 2px; color: #FFE; text-decoration: line-through;">DELISTED (Formerly NYSE: NRNT)</p>
</div>

<!-- Warning Boxes -->
<div style="background: #FEE2E2; border-left: 5px solid #DC2626; padding: 20px; border-radius: 8px; margin: 20px 0; color: #991B1B;">
  <strong style="color: #DC2626;">⚠️ SHAREHOLDER WARNING:</strong> Common stock is worthless
</div>
```

---

## 3. ICBG (ICBG Data Systems)

### Brand Identity
- **Primary Colors**: #00BCD4 (cyan) → #006064 (deep teal)
- **Aesthetic**: Open, transparent, community-driven
- **Icon**: 🏔️ Iceberg (symbolizing Apache Iceberg + data ownership)
- **Personality**: Open-source advocate, customer-centric, transparent

### CSS Specifications

```html
<!-- Header -->
<div style="background: linear-gradient(135deg, #00BCD4 0%, #006064 100%); color: white; padding: 50px 40px; text-align: center; border-radius: 10px; margin-bottom: 30px; box-shadow: 0 10px 30px rgba(0, 188, 212, 0.3); position: relative; overflow: hidden;">
  <div style="position: absolute; top: 20px; right: 20px; font-size: 120px; opacity: 0.1;">🏔️</div>
  <h1 style="margin: 0; font-size: 48px; font-weight: 700; position: relative; z-index: 1;">🏔️ ICBG Data Systems</h1>
  <h2 style="margin: 15px 0 0 0; font-weight: 300; font-size: 26px; position: relative; z-index: 1;">Annual Report - Fiscal Year 20XX</h2>
  <p style="margin: 15px 0 0 0; font-size: 18px; opacity: 0.95; position: relative; z-index: 1;">Year Ended April 30, 20XX</p>
  <div style="margin-top: 25px; padding: 15px 30px; background: rgba(255,255,255,0.15); display: inline-block; border-radius: 25px; backdrop-filter: blur(10px); position: relative; z-index: 1;">
    <p style="margin: 0; font-size: 14px; font-weight: 600;">Private Company | Series C</p>
    <p style="margin: 5px 0 0 0; font-size: 12px; opacity: 0.9;">Open Lakehouse Platform • Apache Iceberg</p>
  </div>
</div>

<!-- Section Headers -->
<h2 style="color: #00BCD4; border-left: 5px solid #00BCD4; border-bottom: 2px solid #B2EBF2; padding-left: 15px; padding-bottom: 10px; font-size: 28px;">Section Title</h2>

<!-- Highlight Boxes -->
<div style="background: #E0F7FA; border: 2px solid #00BCD4; padding: 20px; border-radius: 8px; margin: 20px 0;">
  <strong style="color: #006064;">Open Standard Advantage:</strong> Details
</div>
```

---

## 4. QRYQ (Querybase Technologies)

### Brand Identity
- **Primary Colors**: #FF5722 (orange) → #D84315 (deep orange-red)
- **Aesthetic**: Aggressive, bold, challenger brand
- **Icon**: ⚡ Lightning bolt
- **Personality**: Fast-moving, disruptive, competitive

### CSS Specifications

```html
<!-- Header -->
<div style="background: linear-gradient(135deg, #FF5722 0%, #D84315 100%); color: white; padding: 50px 40px; text-align: center; border-radius: 10px; margin-bottom: 30px; box-shadow: 0 10px 30px rgba(255, 87, 34, 0.4); border-top: 5px solid #FFD54F;">
  <div style="background: rgba(255,255,255,0.2); width: 80px; height: 80px; margin: 0 auto 20px; border-radius: 50%; display: flex; align-items: center; justify-content: center; border: 3px solid rgba(255,255,255,0.4);">
    <span style="font-size: 45px;">⚡</span>
  </div>
  <h1 style="margin: 0; font-size: 48px; font-weight: 700; text-transform: uppercase; letter-spacing: 2px;">Querybase Technologies</h1>
  <h2 style="margin: 15px 0 0 0; font-weight: 300; font-size: 26px;">Annual Report - Fiscal Year 20XX</h2>
  <p style="margin: 15px 0 0 0; font-size: 18px;">Year Ended April 30, 20XX</p>
  <div style="margin-top: 25px; padding: 12px 30px; background: rgba(255,215,79,0.3); display: inline-block; border-radius: 20px; border: 2px solid #FFD54F;">
    <p style="margin: 0; font-size: 14px; font-weight: 700;">Private Company | Series D</p>
    <p style="margin: 5px 0 0 0; font-size: 13px; font-weight: 600;">2x Better Price-Performance Than Snowflake</p>
  </div>
</div>

<!-- Section Headers -->
<h2 style="color: #FF5722; border-left: 6px solid #FF5722; background: linear-gradient(90deg, #FFF3E0 0%, transparent 100%); padding: 15px 20px; font-size: 28px; font-weight: 700; text-transform: uppercase;">Section Title</h2>

<!-- Metric Callouts -->
<div style="background: linear-gradient(135deg, #FFE0B2 0%, #FFCCBC 100%); border: 3px solid #FF5722; padding: 25px; border-radius: 10px; margin: 20px 0; text-align: center;">
  <p style="margin: 0; font-size: 40px; font-weight: 700; color: #D84315;">287%</p>
  <p style="margin: 5px 0 0 0; color: #BF360C; font-weight: 600;">Revenue Growth</p>
</div>
```

---

## 5. DFLX (DataFlex Analytics)

### Brand Identity
- **Primary Colors**: #4CAF50 (green) → #2E7D32 (forest green)
- **Accent**: #81C784 (light green)
- **Aesthetic**: Neutral, balanced, Swiss precision
- **Icon**: 📊 Chart/Graph
- **Personality**: Switzerland of BI, trusted intermediary

### CSS Specifications

```html
<!-- Header -->
<div style="background: linear-gradient(135deg, #4CAF50 0%, #2E7D32 100%); color: white; padding: 50px 40px; text-align: center; border-radius: 10px; margin-bottom: 30px; box-shadow: 0 10px 30px rgba(76, 175, 80, 0.3); border: 3px solid #A5D6A7;">
  <div style="display: grid; grid-template-columns: auto 1fr auto; align-items: center; max-width: 600px; margin: 0 auto;">
    <span style="font-size: 50px;">📊</span>
    <div>
      <h1 style="margin: 0; font-size: 48px; font-weight: 700;">DataFlex Analytics</h1>
    </div>
    <span style="font-size: 50px;">📊</span>
  </div>
  <h2 style="margin: 20px 0 0 0; font-weight: 300; font-size: 26px; opacity: 0.95;">Annual Report - Fiscal Year 20XX</h2>
  <p style="margin: 15px 0 0 0; font-size: 18px;">Year Ended April 30, 20XX</p>
  <div style="margin-top: 25px; background: rgba(255,255,255,0.2); padding: 10px 25px; display: inline-block; border-radius: 20px;">
    <p style="margin: 0; font-size: 14px; font-weight: 600;">Private Company | Series C</p>
    <p style="margin: 5px 0 0 0; font-size: 13px; font-style: italic;">🇨🇭 The Switzerland of BI • Platform Agnostic</p>
  </div>
</div>

<!-- Section Headers -->
<h2 style="color: #2E7D32; background: linear-gradient(90deg, #E8F5E9 0%, transparent 100%); padding: 15px 20px; font-size: 28px; border-left: 5px solid #4CAF50; border-right: 5px solid #4CAF50;">Section Title</h2>

<!-- Balance/Neutrality Box -->
<div style="background: #F1F8E9; border: 2px dashed #4CAF50; padding: 20px; border-radius: 8px; margin: 20px 0;">
  <p style="color: #2E7D32; margin: 0;"><strong>Platform Neutral:</strong> Works with SNOW, QRYQ, ICBG, and 37 more</p>
</div>
```

---

## 6. STRM (StreamPipe Systems)

### Brand Identity
- **Primary Colors**: #3F51B5 (indigo) → #7C4DFF (vibrant purple)
- **Aesthetic**: Flowing, dynamic, continuous
- **Icon**: 〰️ Wave/Stream
- **Personality**: Circulatory system, always moving, connector

### CSS Specifications

```html
<!-- Header -->
<div style="background: linear-gradient(135deg, #3F51B5 0%, #7C4DFF 50%, #3F51B5 100%); color: white; padding: 50px 40px; text-align: center; border-radius: 10px; margin-bottom: 30px; box-shadow: 0 10px 30px rgba(124, 77, 255, 0.4); position: relative; overflow: hidden;">
  <!-- Flowing background pattern -->
  <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; opacity: 0.1;">
    <svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg">
      <path d="M0,50 Q25,30 50,50 T100,50 T150,50 T200,50" stroke="white" stroke-width="3" fill="none" opacity="0.3"/>
      <path d="M0,80 Q25,60 50,80 T100,80 T150,80 T200,80" stroke="white" stroke-width="3" fill="none" opacity="0.2"/>
    </svg>
  </div>
  <div style="position: relative; z-index: 1;">
    <h1 style="margin: 0; font-size: 48px; font-weight: 700;">〰️ StreamPipe Systems 〰️</h1>
    <h2 style="margin: 15px 0 0 0; font-weight: 300; font-size: 26px;">Annual Report - Fiscal Year 20XX</h2>
    <p style="margin: 15px 0 0 0; font-size: 18px;">Year Ended April 30, 20XX</p>
    <p style="margin: 20px 0 0 0; font-size: 14px; font-weight: 600; background: rgba(255,255,255,0.2); display: inline-block; padding: 8px 20px; border-radius: 15px;">Private Company | Series C</p>
    <p style="margin: 10px 0 0 0; font-size: 14px; font-style: italic;">Real-Time Data Integration • The Circulatory System</p>
  </div>
</div>

<!-- Section Headers -->
<h2 style="color: #3F51B5; border-left: 5px solid #7C4DFF; background: linear-gradient(90deg, #E8EAF6 0%, #F3E5F5 50%, transparent 100%); padding: 15px 20px; font-size: 28px;">Section Title</h2>

<!-- Flow Diagram Box -->
<div style="background: linear-gradient(90deg, #E8EAF6 0%, #F3E5F5 100%); border: 2px solid #3F51B5; padding: 20px; border-radius: 8px; margin: 20px 0;">
  Source 〰️ StreamPipe 〰️ Destination
</div>
```

---

## 7. VLTA (Voltaic AI Platform)

### Brand Identity
- **Primary Colors**: #FDD835 (electric yellow) → #F57F17 (amber)
- **Text Color**: #1a1a1a (dark - for readability on yellow)
- **Aesthetic**: High-energy, AI-forward, electric
- **Icon**: ⚡ Lightning bolt
- **Personality**: Cutting-edge AI, fast-moving, powerful

### CSS Specifications

```html
<!-- Header -->
<div style="background: linear-gradient(135deg, #FDD835 0%, #F57F17 100%); color: #1a1a1a; padding: 50px 40px; text-align: center; border-radius: 10px; margin-bottom: 30px; box-shadow: 0 10px 40px rgba(253, 216, 53, 0.5); border: 4px solid #FBC02D; position: relative;">
  <!-- Electric effect -->
  <div style="position: absolute; top: 10px; left: 10px; font-size: 30px; opacity: 0.3;">⚡</div>
  <div style="position: absolute; top: 10px; right: 10px; font-size: 30px; opacity: 0.3;">⚡</div>
  <div style="position: absolute; bottom: 10px; left: 50%; transform: translateX(-50%); font-size: 30px; opacity: 0.3;">⚡</div>
  
  <div style="background: rgba(0,0,0,0.1); display: inline-block; padding: 15px 30px; border-radius: 50%; margin-bottom: 15px; border: 3px solid rgba(0,0,0,0.2);">
    <span style="font-size: 50px;">⚡</span>
  </div>
  <h1 style="margin: 0; font-size: 48px; font-weight: 900; text-transform: uppercase; letter-spacing: 3px;">Voltaic AI Platform</h1>
  <h2 style="margin: 15px 0 0 0; font-weight: 400; font-size: 26px; opacity: 0.85;">Annual Report - Fiscal Year 20XX</h2>
  <p style="margin: 15px 0 0 0; font-size: 18px; opacity: 0.8;">Year Ended April 30, 20XX</p>
  <div style="margin-top: 25px; background: rgba(0,0,0,0.15); padding: 12px 30px; display: inline-block; border-radius: 25px;">
    <p style="margin: 0; font-size: 14px; font-weight: 700;">Private Company | Series D</p>
    <p style="margin: 5px 0 0 0; font-size: 13px; font-weight: 600;">Production AI Infrastructure • 312% Growth 🚀</p>
  </div>
</div>

<!-- Section Headers -->
<h2 style="color: #F57F17; background: linear-gradient(90deg, #FFF9C4 0%, transparent 100%); padding: 15px 20px; font-size: 28px; font-weight: 700; border-left: 6px solid #FDD835; border-right: 2px solid #F57F17;">Section Title</h2>

<!-- Energy Callout -->
<div style="background: linear-gradient(135deg, #FFF9C4 0%, #FFECB3 100%); border: 3px solid #FDD835; padding: 25px; border-radius: 10px; margin: 20px 0; text-align: center;">
  <p style="margin: 0; font-size: 36px; font-weight: 900; color: #F57F17;">⚡ $512K ACV ⚡</p>
  <p style="margin: 5px 0 0 0; color: #E65100; font-weight: 600;">Highest Average Contract Value</p>
</div>
```

---

## 8. CTLG (CatalogX Corporation)

### Brand Identity
- **Primary Colors**: #37474F (charcoal) → #607D8B (blue-gray)
- **Aesthetic**: Serious, governance-focused, secure
- **Icon**: 🛡️ Shield
- **Personality**: Trustworthy, compliant, protective

### CSS Specifications

```html
<!-- Header -->
<div style="background: linear-gradient(135deg, #37474F 0%, #607D8B 100%); color: white; padding: 50px 40px; text-align: center; border-radius: 10px; margin-bottom: 30px; box-shadow: 0 10px 30px rgba(55, 71, 79, 0.4); border: 2px solid #90A4AE;">
  <div style="background: rgba(255,255,255,0.15); width: 100px; height: 100px; margin: 0 auto 20px; border-radius: 10px; display: flex; align-items: center; justify-content: center; border: 3px solid rgba(255,255,255,0.3);">
    <span style="font-size: 55px;">🛡️</span>
  </div>
  <h1 style="margin: 0; font-size: 48px; font-weight: 700;">CatalogX Corporation</h1>
  <h2 style="margin: 15px 0 0 0; font-weight: 300; font-size: 26px;">Annual Report - Fiscal Year 20XX</h2>
  <p style="margin: 15px 0 0 0; font-size: 18px;">Year Ended April 30, 20XX</p>
  <div style="margin-top: 25px; padding: 12px 30px; background: rgba(255,255,255,0.2); display: inline-block; border-radius: 8px; border: 1px solid rgba(255,255,255,0.4);">
    <p style="margin: 0; font-size: 14px; font-weight: 600;">Private Company | Series C</p>
    <p style="margin: 5px 0 0 0; font-size: 13px;">Cross-Platform Governance • Compliance Leader</p>
  </div>
</div>

<!-- Section Headers -->
<h2 style="color: #37474F; background: #ECEFF1; padding: 15px 20px; font-size: 28px; border-left: 6px solid #607D8B; border-top: 2px solid #90A4AE; font-weight: 700;">Section Title</h2>

<!-- Compliance Badge -->
<div style="background: #ECEFF1; border-left: 5px solid #607D8B; padding: 20px; border-radius: 8px; margin: 20px 0;">
  <p style="margin: 0; color: #37474F;"><strong>🛡️ Governance Certified:</strong> SOC 2 Type II | GDPR | CCPA</p>
</div>
```

---

## 9. PROP (PropTech Analytics)

### Brand Identity
- **Primary Colors**: #14B8A6 (teal) → #0D9488 (dark teal)
- **Aesthetic**: Professional real estate, stable, growth-focused
- **Icon**: 🏢 Building
- **Personality**: Real estate professional, data-driven, analytical

### CSS Specifications

```html
<!-- Header -->
<div style="background: linear-gradient(135deg, #14B8A6 0%, #0D9488 100%); color: white; padding: 50px 40px; text-align: center; border-radius: 10px; margin-bottom: 30px; box-shadow: 0 10px 30px rgba(20, 184, 166, 0.3);">
  <div style="display: flex; align-items: center; justify-content: center; gap: 20px; margin-bottom: 20px;">
    <span style="font-size: 50px;">🏢</span>
    <h1 style="margin: 0; font-size: 48px; font-weight: 700;">PropTech Analytics</h1>
    <span style="font-size: 50px;">🏢</span>
  </div>
  <h2 style="margin: 15px 0 0 0; font-weight: 300; font-size: 26px;">Annual Report - Fiscal Year 20XX</h2>
  <p style="margin: 15px 0 0 0; font-size: 18px;">Year Ended April 30, 20XX</p>
  <div style="margin-top: 25px; padding: 10px 25px; background: rgba(255,255,255,0.2); display: inline-block; border-radius: 20px;">
    <p style="margin: 0; font-size: 14px; font-weight: 600;">Private Company | Series B</p>
    <p style="margin: 5px 0 0 0; font-size: 13px;">Real Estate Data Analytics • Growth Stage</p>
  </div>
</div>

<!-- Section Headers -->
<h2 style="color: #0D9488; border-left: 5px solid #14B8A6; padding-left: 15px; font-size: 28px; margin: 30px 0 15px 0;">Section Title</h2>

<!-- Property Stats Box -->
<div style="background: linear-gradient(135deg, #CCFBF1 0%, #99F6E4 100%); border: 2px solid #14B8A6; padding: 20px; border-radius: 8px; margin: 20px 0;">
  <strong style="color: #0D9488;">🏢 2.4M Properties Analyzed</strong>
</div>
```

---

## 10. GAME (GameMetrics Analytics)

### Brand Identity
- **Primary Colors**: #A855F7 (vibrant purple) → #7C3AED (deep purple)
- **Aesthetic**: Gaming-focused, energetic, playful yet professional
- **Icon**: 🎮 Game controller
- **Personality**: Gaming industry leader, player-focused, data-driven

### CSS Specifications

```html
<!-- Header -->
<div style="background: linear-gradient(135deg, #A855F7 0%, #7C3AED 100%); color: white; padding: 50px 40px; text-align: center; border-radius: 10px; margin-bottom: 30px; box-shadow: 0 10px 30px rgba(168, 85, 247, 0.4); position: relative;">
  <!-- Pixelated border effect -->
  <div style="position: absolute; top: 0; left: 0; right: 0; height: 5px; background: repeating-linear-gradient(90deg, #F9A8D4 0px, #F9A8D4 10px, #C084FC 10px, #C084FC 20px, #A855F7 20px, #A855F7 30px);"></div>
  
  <div style="background: rgba(255,255,255,0.15); display: inline-block; padding: 20px; border-radius: 15px; margin-bottom: 20px;">
    <span style="font-size: 60px;">🎮</span>
  </div>
  <h1 style="margin: 0; font-size: 48px; font-weight: 700; letter-spacing: 1px;">GameMetrics Analytics</h1>
  <h2 style="margin: 15px 0 0 0; font-weight: 300; font-size: 26px;">Annual Report - Fiscal Year 20XX</h2>
  <p style="margin: 15px 0 0 0; font-size: 18px;">Year Ended April 30, 20XX</p>
  <div style="margin-top: 25px; background: rgba(0,0,0,0.2); padding: 12px 30px; display: inline-block; border-radius: 25px;">
    <p style="margin: 0; font-size: 14px; font-weight: 600;">Private Company | Series B</p>
    <p style="margin: 5px 0 0 0; font-size: 13px;">Gaming Analytics Leader • 847M Players Analyzed</p>
  </div>
</div>

<!-- Section Headers -->
<h2 style="color: #7C3AED; background: linear-gradient(90deg, #F3E8FF 0%, transparent 100%); padding: 15px 20px; font-size: 28px; border-left: 5px solid #A855F7; font-weight: 700;">Section Title</h2>

<!-- Player Stats -->
<div style="background: linear-gradient(135deg, #F3E8FF 0%, #E9D5FF 100%); border: 3px solid #A855F7; padding: 25px; border-radius: 10px; margin: 20px 0; text-align: center;">
  <p style="margin: 0; font-size: 40px; font-weight: 700; color: #7C3AED;">🎮 2.7B Events/Day</p>
</div>
```

---

## 11. MKTG (Marketing Analytics Platform)

### Brand Identity
- **Primary Colors**: #F97316 (orange) → #EA580C (deep orange)
- **Aesthetic**: Marketing-focused, data-driven, ROI-oriented
- **Icon**: 📈 Trending up chart
- **Personality**: Marketing intelligence, performance-focused, challenged

### CSS Specifications

```html
<!-- Header -->
<div style="background: linear-gradient(135deg, #F97316 0%, #EA580C 100%); color: white; padding: 50px 40px; text-align: center; border-radius: 10px; margin-bottom: 30px; box-shadow: 0 10px 30px rgba(249, 115, 22, 0.4);">
  <div style="background: rgba(255,255,255,0.2); display: inline-block; padding: 15px 30px; border-radius: 8px; margin-bottom: 20px; border: 2px solid rgba(255,255,255,0.3);">
    <span style="font-size: 45px;">📈</span>
  </div>
  <h1 style="margin: 0; font-size: 48px; font-weight: 700;">Marketing Analytics Platform</h1>
  <h2 style="margin: 15px 0 0 0; font-weight: 300; font-size: 26px;">Annual Report - Fiscal Year 20XX</h2>
  <p style="margin: 15px 0 0 0; font-size: 18px;">Year Ended April 30, 20XX</p>
  <div style="margin-top: 25px; padding: 10px 25px; background: rgba(255,255,255,0.2); display: inline-block; border-radius: 20px;">
    <p style="margin: 0; font-size: 14px; font-weight: 600;">Private Company | Series B</p>
    <p style="margin: 5px 0 0 0; font-size: 13px;">Marketing Attribution • Campaign Analytics</p>
  </div>
</div>

<!-- Section Headers -->
<h2 style="color: #EA580C; border-left: 5px solid #F97316; background: linear-gradient(90deg, #FFF7ED 0%, transparent 100%); padding: 15px 20px; font-size: 28px;">Section Title</h2>

<!-- ROI Metrics -->
<div style="background: linear-gradient(135deg, #FFEDD5 0%, #FED7AA 100%); border-left: 5px solid #F97316; padding: 20px; border-radius: 8px; margin: 20px 0;">
  <strong style="color: #EA580C;">📈 Key Metric:</strong> Value
</div>
```

---

## Universal Design Elements

### Typography Hierarchy

```css
/* H1 - Company Name */
font-size: 48px; font-weight: 700; letter-spacing: -1px to 3px (varies by brand)

/* H2 - Report Title */
font-size: 26-28px; font-weight: 300; opacity: 0.95

/* H2 - Section Headers */
font-size: 28px; font-weight: 700; margin: 30px 0 15px 0

/* H3 - Subsections */
font-size: 22px; font-weight: 600; margin: 20px 0 10px 0

/* Body Text */
font-size: 16px; line-height: 1.6; color: #1a1a1a

/* Metadata */
font-size: 14-18px; opacity: 0.8-0.95
```

### Common Components

**Financial Tables**:
```html
<table style="width: 100%; border-collapse: collapse; margin: 20px 0; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
  <thead style="background: [COMPANY_GRADIENT]; color: white;">
    <tr><th style="padding: 12px; text-align: left; font-weight: 600;">Column</th></tr>
  </thead>
  <tbody>
    <tr style="border-bottom: 1px solid [COMPANY_LIGHT_COLOR];">
      <td style="padding: 10px;">Data</td>
    </tr>
  </tbody>
</table>
```

**Metric Highlights**:
```html
<div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px; margin: 25px 0;">
  <div style="background: [COMPANY_LIGHT]; border-left: 4px solid [COMPANY_PRIMARY]; padding: 20px; border-radius: 8px; text-align: center;">
    <p style="margin: 0; font-size: 32px; font-weight: 700; color: [COMPANY_PRIMARY];">$XXM</p>
    <p style="margin: 5px 0 0 0; font-size: 14px; color: #666;">Metric Name</p>
  </div>
</div>
```

**Quote Boxes**:
```html
<blockquote style="background: [COMPANY_LIGHT]; border-left: 5px solid [COMPANY_PRIMARY]; padding: 20px; margin: 25px 0; border-radius: 8px; font-style: italic; color: #333;">
  "CEO quote here"
  <footer style="margin-top: 10px; font-style: normal; font-weight: 600; color: [COMPANY_PRIMARY];">— CEO Name, Title</footer>
</blockquote>
```

**Warning/Alert Boxes**:
```html
<div style="background: #FEE2E2; border-left: 5px solid #DC2626; padding: 20px; border-radius: 8px; margin: 20px 0; color: #991B1B;">
  <strong style="color: #DC2626;">⚠️ Warning:</strong> Content
</div>
```

**Success/Positive Boxes**:
```html
<div style="background: #D1FAE5; border-left: 5px solid #10B981; padding: 20px; border-radius: 8px; margin: 20px 0; color: #065F46;">
  <strong style="color: #059669;">✅ Achievement:</strong> Content
</div>
```

---

## Stock Exchange Listings

**IMPORTANT**: All 11 companies are publicly traded (or were, in NRNT's case) with stock tickers.

| Company | Ticker | Exchange | Status (FY2025) |
|---------|--------|----------|-----------------|
| Snowflake Inc. | SNOW | NASDAQ | ✅ Active |
| Neuro-Nectar Corp. | NRNT | NYSE | ❌ DELISTED (Nov 20, 2024) |
| ICBG Data Systems | ICBG | NASDAQ | ✅ Active |
| Querybase Technologies | QRYQ | NYSE | ✅ Active |
| DataFlex Analytics | DFLX | NASDAQ | ✅ Active |
| StreamPipe Systems | STRM | NYSE | ✅ Active |
| Voltaic AI Platform | VLTA | NASDAQ | ✅ Active |
| CatalogX Corporation | CTLG | NYSE | ✅ Active |
| PropTech Analytics | PROP | NASDAQ | ✅ Active |
| GameMetrics Analytics | GAME | NASDAQ | ✅ Active |
| Marketing Analytics | MKTG | NYSE | ✅ Active |

**Note**: All companies in this synthetic dataset are publicly traded to enable stock price analysis, earnings calls, and analyst coverage.

## Color Reference Chart

| Company | Primary Start | Primary End | Light BG | Icon | Personality | Stock |
|---------|---------------|-------------|----------|------|-------------|-------|
| SNOW | #2962FF | #0D47A1 | #E3F2FD | ❄️ | Enterprise leader | NASDAQ:SNOW |
| NRNT | #9C27B0 | #E91E63 | #F3E5F5 | 🧠 | Failed (delisted) | NYSE:NRNT (DELISTED) |
| ICBG | #00BCD4 | #006064 | #E0F7FA | 🏔️ | Open & transparent | NASDAQ:ICBG |
| QRYQ | #FF5722 | #D84315 | #FFF3E0 | ⚡ | Aggressive challenger | NYSE:QRYQ |
| DFLX | #4CAF50 | #2E7D32 | #E8F5E9 | 📊 | Neutral Switzerland | NASDAQ:DFLX |
| STRM | #3F51B5 | #7C4DFF | #E8EAF6 | 〰️ | Flowing connector | NYSE:STRM |
| VLTA | #FDD835 | #F57F17 | #FFF9C4 | ⚡ | High-energy AI | NASDAQ:VLTA |
| CTLG | #37474F | #607D8B | #ECEFF1 | 🛡️ | Secure governance | NYSE:CTLG |
| PROP | #14B8A6 | #0D9488 | #CCFBF1 | 🏢 | Real estate pro | NASDAQ:PROP |
| GAME | #A855F7 | #7C3AED | #F3E8FF | 🎮 | Gaming leader | NASDAQ:GAME |
| MKTG | #F97316 | #EA580C | #FFF7ED | 📈 | Marketing focused | NYSE:MKTG |

---

## Application Rules

### For FY2025 Reports (Comprehensive)

Apply full design treatment:
- Branded header with company-specific layout
- Styled section headers throughout
- Branded tables with company gradient
- Metric callout boxes with company colors
- Quote boxes with company styling
- Footer with brand colors

### For FY2024 Reports (Concise)

Apply streamlined design:
- Branded header (same as FY2025)
- Simpler section headers
- Standard tables (less elaborate)
- Minimal callout boxes
- Focus on clarity over decoration

### Special Cases

**NRNT FY2025 (Liquidation)**:
- Add red warning border (6px solid #DC2626)
- Pulsing warning banner animation
- Strikethrough on stock ticker
- Red warning boxes for shareholder notices
- Distressed aesthetic appropriate for bankruptcy

**Profitable Companies (SNOW, DFLX, CTLG in FY2025)**:
- Add success indicators (✅ checkmarks)
- Highlight profitability metrics in green
- Emphasize cash flow positive status
- Professional success branding

**High-Growth Companies (VLTA, QRYQ, GAME)**:
- Emphasize growth metrics
- Dynamic visual elements
- Energy and momentum in design
- Bold typography choices

---

## Implementation Checklist

For each annual report:
- [ ] Replace plain H1 with branded header div
- [ ] Apply company gradient colors
- [ ] Add appropriate company icon
- [ ] Include stock/funding status
- [ ] Add company tagline
- [ ] Style section headers with company colors
- [ ] Add metric callout boxes where appropriate
- [ ] Include styled tables for financial data
- [ ] Add quote boxes for CEO statements
- [ ] Footer with brand colors
- [ ] Ensure visual consistency within company (FY2024 + FY2025 match)
- [ ] Verify readability (contrast, spacing)
- [ ] Test rendering in markdown viewers

---

**This specification ensures each company has a unique, professional, branded annual report while maintaining consistency and readability.**

