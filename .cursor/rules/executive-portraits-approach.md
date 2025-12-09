# Executive Portrait Generation Approach

**Challenge**: Create executive photos that are clearly AI-generated/synthetic (not real people)

**Solution**: Use abstract SVG-based portraits with geometric designs

---

## Portrait Style Options

### Option 1: Geometric Abstract Avatars (RECOMMENDED)

**Style**: Colorful geometric shapes forming abstract faces
- Circles, triangles, rectangles
- Company brand colors
- Modern, tech-forward aesthetic
- Obviously synthetic (not trying to look real)

**Benefits**:
- ✅ Clearly AI-generated/abstract
- ✅ Company-branded (use brand colors)
- ✅ Professional looking
- ✅ Easy to create as SVG
- ✅ Unique per person

**Example Design**:
```
Circle (face shape) in company primary color
+ Triangle (nose)
+ Two circles (eyes) in accent color
+ Curved path (smile)
+ Optional: Geometric hair (rectangles/curves)
+ Background: Company gradient
```

### Option 2: Minimalist Line Art Portraits

**Style**: Simple line drawings, profile or front-facing
- Single color line art
- Abstract features
- Professional but artistic
- Company color outlines

### Option 3: Data-Inspired Avatars

**Style**: Made from data visualizations
- Pixelated/matrix style
- Code/binary background
- Geometric patterns
- Tech aesthetic

---

## Selected Approach: Geometric Abstract Avatars

### Design Specifications

**Dimensions**: 400x400px (square)  
**Format**: SVG (scalable)  
**Style**: Geometric shapes in company colors  

**Color Scheme per Company**:
- Use company primary + secondary gradient
- Background: Light version of brand color
- Shapes: Primary and accent colors

**Variation per Executive**:
- Different geometric arrangements
- Unique shape combinations
- Slight color variations (lighter/darker)

---

## Avatar Template Structure

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 400">
  <defs>
    <linearGradient id="bgGradient">
      <stop offset="0%" stop-color="[COMPANY_LIGHT]"/>
      <stop offset="100%" stop-color="[COMPANY_PRIMARY]" stop-opacity="0.1"/>
    </linearGradient>
    <linearGradient id="faceGradient">
      <stop offset="0%" stop-color="[COMPANY_PRIMARY]"/>
      <stop offset="100%" stop-color="[COMPANY_SECONDARY]"/>
    </linearGradient>
  </defs>
  
  <!-- Background -->
  <rect width="400" height="400" fill="url(#bgGradient)"/>
  
  <!-- Face shape (circle or rounded rect) -->
  <circle cx="200" cy="180" r="100" fill="url(#faceGradient)" opacity="0.8"/>
  
  <!-- Eyes (two circles) -->
  <circle cx="175" cy="165" r="8" fill="white"/>
  <circle cx="225" cy="165" r="8" fill="white"/>
  
  <!-- Nose (triangle) -->
  <polygon points="200,175 195,190 205,190" fill="rgba(0,0,0,0.1)"/>
  
  <!-- Smile (arc) -->
  <path d="M 180 200 Q 200 210 220 200" stroke="white" stroke-width="4" fill="none" stroke-linecap="round"/>
  
  <!-- Optional: Hair/head shape -->
  <circle cx="200" cy="120" r="80" fill="[COMPANY_SECONDARY]" opacity="0.6"/>
  
  <!-- Name badge at bottom -->
  <rect x="50" y="320" width="300" height="60" rx="10" fill="white" opacity="0.9"/>
  <text x="200" y="345" text-anchor="middle" font-size="18" font-weight="700" fill="[COMPANY_PRIMARY]">
    CEO Name
  </text>
  <text x="200" y="365" text-anchor="middle" font-size="14" fill="#666">
    Chief Executive Officer
  </text>
</svg>
```

---

## Executive Roster by Company

### SNOW - Snowflake Inc.

1. **Sridhar Ramaswamy** - CEO (appointed 2024)
2. **Michael Scarpelli** - CFO
3. **Christian Kleinerman** - CTO

### NRNT - Neuro-Nectar (Defunct)

1. **Dr. Marcus Sterling** - CEO & Founder (former)
2. **Lisa Park** - CFO (former)

### ICBG - ICBG Data Systems

1. **Dr. Elena Rodriguez** - CEO & Founder
2. **James Mitchell** - CFO
3. **Priya Kapoor** - CTO

### QRYQ - Querybase Technologies

1. **Michael Zhang** - CEO & Founder
2. **Sarah Thompson** - CFO
3. **David Park** - CTO

### DFLX - DataFlex Analytics

1. **Sarah Chen** - CEO
2. **Robert Kim** - CFO
3. **Maria Garcia** - CPO (Chief Product Officer)

### STRM - StreamPipe Systems

1. **Priya Sharma** - CEO & Founder
2. **Tom Anderson** - CFO
3. **Alex Wu** - CTO

### VLTA - Voltaic AI

1. **Dr. Amit Singh** - CEO & Co-Founder
2. **Jessica Martinez** - CFO
3. **Dr. Kevin Patel** - Chief AI Officer

### CTLG - CatalogX

1. **Rachel Foster** - CEO
2. **Daniel Brooks** - CFO
3. **Sophia Lee** - Chief Data Officer

### PROP - PropTech Analytics

1. **Marcus Brown** - CEO
2. **Jennifer Walsh** - CFO

### GAME - GameMetrics

1. **Alex Kim** - CEO & Founder
2. **Ryan Cooper** - CFO

### MKTG - Marketing Analytics

1. **Jennifer Martinez** - CEO
2. **Chris Johnson** - CFO

**Total Executives**: ~30 people across 11 companies

---

## Bio Content Structure

### Format for Each Executive:

**Name & Title**  
**Age**: XX  
**Education**: University, Degree  
**Previous Experience**: 2-3 prior roles  
**Joined Company**: Year  
**Notable Achievement**: 1-2 key accomplishments  
**Quote**: Personal statement about company/vision  
**Based In**: City, State  

**Example**:

**Sridhar Ramaswamy**  
Chief Executive Officer  
Age: 56  
Education: PhD Computer Science, Brown University; B.Tech IIT Madras  
Previous Experience: SVP Engineering at Google (10 years); CEO Neeva (2019-2023)  
Joined Snowflake: May 2024 (appointed CEO)  
Notable: Led Google Ads engineering; Founded privacy-focused search engine Neeva  
Quote: "The AI Data Cloud represents the most important infrastructure shift since cloud computing itself. Snowflake is uniquely positioned to enable every organization's AI transformation."  
Based In: Palo Alto, California  

---

## Deliverable Format

### Option 1: Individual Bio Pages (Recommended)

One PDF per company with all executives:
- `SNOW_Executive_Team.pdf`
  - Page 1: Sridhar Ramaswamy (photo + bio)
  - Page 2: Michael Scarpelli (photo + bio)
  - Page 3: Christian Kleinerman (photo + bio)

### Option 2: Combined Leadership Directory

Single PDF with all 30 executives:
- `All_Companies_Executive_Directory.pdf`
- Organized by company
- Quick reference

### Option 3: Individual Executive Cards

Separate files per person:
- `Sridhar_Ramaswamy_SNOW.pdf`
- Useful for embedding in other materials

---

## Avatar Generation Process

### Step 1: Create Base Templates (5 variations)

- Template A: Circular geometric face
- Template B: Rectangular modern face
- Template C: Triangular abstract face
- Template D: Hexagonal tech face
- Template E: Organic flowing shapes

### Step 2: Customize per Executive

- Apply company brand colors
- Vary shapes and arrangements
- Unique composition per person
- Add name badge with company branding

### Step 3: Export

- SVG format (vector)
- Can convert to PNG if needed
- Consistent 400x400px size

---

## Next Steps

1. ✅ Create geometric avatar templates
2. ✅ Generate 30 unique executive portraits
3. ✅ Write detailed bios for each executive
4. ✅ Design executive bio pages (photo + bio)
5. ✅ Generate PDFs

**Estimated effort**: ~2-3 hours for complete executive team materials

**Ready to proceed?** I'll create all executive bios with abstract geometric portraits!

