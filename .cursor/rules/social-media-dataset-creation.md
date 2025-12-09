# Social Media Dataset Creation Guide

## Overview

This guide documents the creation of the comprehensive multi-modal social media dataset for the NRNT (Neuro-Nectar) crisis narrative, including 4,209 posts across 3 languages with images, geolocation, and viral story tracking.

---

## Dataset Specifications

### Final Dataset Metrics

- **Total Posts**: 4,209
- **Languages**: 3 (English, French, Chinese)
  - English: 3,489 posts (82.9%)
  - French: 547 posts (13.0%)
  - Chinese: 173 posts (4.1%)
- **Images**: 338 posts with images (8.0%)
- **Locations**: 31 cities across 13+ countries
- **Timeline**: August 25 - December 30, 2024
- **File Size**: ~790 KB CSV

### Schema (17 Columns)

```sql
CREATE TABLE SOCIAL_MEDIA_NRNT (
    TIMESTAMP TIMESTAMP,          -- Post creation time
    PLATFORM VARCHAR,              -- Twitter, Reddit, LinkedIn, etc.
    AUTHOR_HANDLE VARCHAR,         -- Username/handle
    AUTHOR_TYPE VARCHAR,           -- Consumer, Investor, CEO, etc.
    COMPANY_AFFILIATION VARCHAR,   -- Company name or 'None'
    TEXT VARCHAR,                  -- Post content (en/zh/fr)
    SENTIMENT FLOAT,               -- 0.0-1.0 sentiment score
    LIKES INTEGER,                 -- Engagement metric
    RETWEETS INTEGER,              -- Shares (Twitter/Weibo)
    REPLIES INTEGER,               -- Comment count
    HASHTAGS VARCHAR,              -- Comma-separated hashtags
    LOCATION VARCHAR,              -- City/region name
    COUNTRY VARCHAR,               -- Country code
    LANGUAGE VARCHAR,              -- en, zh, fr
    LATITUDE FLOAT,                -- Decimal degrees
    LONGITUDE FLOAT,               -- Decimal degrees
    IMAGE_FILENAME VARCHAR         -- Linked image file (if any)
);
```

---

## Python Script Architecture

### File: `generate_social_media_posts_v2.py`

**Key Components**:

1. **Configuration Constants**
   - Post targets by language
   - Location lists with coordinates
   - Time period definitions
   - Platform distributions

2. **Template Systems**
   - Language-specific post templates (English, Chinese, French)
   - Crisis phase templates (early_hype, concerns, crisis, collapse, aftermath)
   - Viral story templates (Chinese mother narrative)

3. **Generation Functions**
   - `generate_english_post()` - Creates English posts
   - `generate_chinese_post()` - Creates Chinese posts
   - `generate_french_post()` - Creates French posts
   - `get_image_for_post()` - Assigns images based on content
   - `generate_handle()` - Creates platform-appropriate usernames

4. **Data Distribution**
   - Proportional distribution across time periods
   - Realistic sentiment curves
   - Viral content patterns (3-5% frequency for special stories)

### Script Structure Pattern

```python
# 1. CONSTANTS & CONFIG
TARGET_POSTS_ENGLISH = 3489
TARGET_POSTS_CHINESE = 175
TARGET_POSTS_FRENCH = 549
TOTAL_POSTS = 4213

# 2. LOCATIONS (city, country, language, lat, lon)
LOCATIONS_ENGLISH = [
    ("San Francisco, CA", "USA", "en", 37.7749, -122.4194),
    # ... more locations
]

# 3. TIME PERIODS with sentiment progression
PERIODS = {
    "early_hype": {
        "start": datetime(2024, 8, 25),
        "end": datetime(2024, 9, 10),
        "posts": 800,
        "avg_sentiment": 0.75
    },
    # ... more periods
}

# 4. TEMPLATES by language and period
CHINESE_TEMPLATES = {
    'early_hype': [...],
    'concerns_emerging': [...],
    # etc.
}

# 5. GENERATION FUNCTIONS
def generate_english_post(period_name, config):
    # Check for viral story injection (3-5% rate)
    if period_name in ['concerns_emerging', 'crisis_building']:
        if random.random() < 0.05:
            # Generate viral story variant
            pass
    
    # Standard post generation
    # Return dict with all 17 columns
    pass

# 6. MAIN EXECUTION
# - Generate posts by period
# - Distribute special stories
# - Sort by timestamp
# - Write to CSV
```

---

## Image Integration Strategy

### Available Images (7 files)

**Early Hype** (Aug-Sept 2024):
- `dev_team_icecream.png` - Teams using product
- `eating_icecream.png` - General consumption
- `icecream_brainfog_gone.png` - Success stories
- `neuro_icecream.png` - Product shots

**Crisis** (Sept-Nov 2024):
- `icecream_in_landfill_recall.png` - Waste/recall imagery
- `chinese_man_not_happy_angry_icecream.png` - Viral tragedy story

**Collapse** (Nov-Dec 2024):
- `ceo_neuro_nectar_leaving_office_gone_bust.png` - Executive departure

### Image Assignment Logic

```python
def get_image_for_post(text, period_name):
    """Smart image assignment based on content and timeline"""
    text_lower = text.lower()
    
    # EARLY HYPE: 30-40% get positive images
    if period_name == 'early_hype':
        if 'brain fog' in text_lower:
            return 'icecream_brainfog_gone.png'
        elif 'dev team' in text_lower or 'sprint' in text_lower:
            return 'dev_team_icecream.png'
        # ... keyword matching
    
    # CRISIS: Negative images emerge
    elif period_name in ['concerns_emerging', 'crisis_building']:
        # Viral story gets special image
        if 'chinese' in text_lower and 'mother' in text_lower:
            return 'chinese_man_not_happy_angry_icecream.png'
        # Health issues get recall image
        elif 'hospital' in text_lower or 'sick' in text_lower:
            return 'icecream_in_landfill_recall.png'
    
    # COLLAPSE: CEO departure images
    elif period_name == 'collapse':
        if 'ceo' in text_lower or 'bankrupt' in text_lower:
            return 'ceo_neuro_nectar_leaving_office_gone_bust.png'
    
    return None  # Most posts have no images
```

**Key Principles**:
- Images reflect narrative arc (positive → negative → collapse)
- Frequency decreases over time (hype → crisis → nothing)
- Keyword matching for relevance
- Viral stories get guaranteed image assignment

---

## Multi-Language Implementation

### Language Distribution Strategy

**Base Language**: English (82.9%)
- Primary market
- Most diverse author types
- Complete timeline coverage

**Additional 5%**: Chinese (4.1%)
- Posts from China (6 cities: Beijing, Shanghai, Shenzhen, etc.)
- Platform mix: WeChat, Weibo, Twitter, LinkedIn
- Simpler author types: Consumer, Investor, Industry_Analyst
- Templates include Chinese characters with English translations in comments

**Additional 15%**: French (13.0%)
- Posts from Francophone regions (12 cities)
- France, Canada (Montreal, Quebec), Belgium, Switzerland, Senegal, Algeria, etc.
- All major platforms
- Full author type diversity

### Translation Template Pattern

```python
FRENCH_TEMPLATES = {
    'crisis_building': [
        "ARRÊTEZ Neuro-Nectar! Effets secondaires graves.",  # STOP NRNT! Serious side effects
        # French text  # English translation comment
    ]
}
```

**Benefits**:
- Maintainable (translations visible in code)
- Authentic (native language expressions)
- AI-ready (can test AI_TRANSLATE accuracy)

---

## Geolocation Implementation

### Location Data Structure

```python
# Format: (city, country, language, latitude, longitude)
LOCATIONS_ENGLISH = [
    ("San Francisco, CA", "USA", "en", 37.7749, -122.4194),
    ("New York, NY", "USA", "en", 40.7128, -74.0060),
    # ... 13 total locations
]

LOCATIONS_FRENCH = [
    ("Paris", "France", "fr", 48.8566, 2.3522),
    ("Montreal", "Canada", "fr", 45.5017, -73.5673),
    # ... 12 total locations
]

LOCATIONS_CHINESE = [
    ("北京 (Beijing)", "China", "zh", 39.9042, 116.4074),
    # ... 6 total locations
]
```

**Usage in Snowflake**:
```sql
-- Create geographic points
SELECT 
    LOCATION,
    ST_MAKEPOINT(LONGITUDE, LATITUDE) AS geo_point
FROM SOCIAL_MEDIA_NRNT;

-- Distance-based queries
WHERE ST_DISTANCE(
    ST_MAKEPOINT(LONGITUDE, LATITUDE),
    ST_MAKEPOINT(-122.4194, 37.7749)  -- San Francisco
) <= 100000;  -- 100km
```

---

## Viral Story Implementation

### The Chinese Mother Story

**Narrative**: Chinese man bought NRNT ice cream for elderly mother (memory issues). She was hospitalized with brain damage + gastric problems. Son devastated and blaming himself.

**Implementation Strategy**:

```python
# 1. Define story templates (3 types)
CHINESE_MOTHER_STORY_TEMPLATES = {
    'original_post': [
        "BREAKING: Man bought Neuro-Nectar for his mom..."
    ],
    'reactions': [
        "That Chinese mother story is breaking my heart..."
    ],
    'sharing': [
        "Sharing this everywhere - Chinese mother severely injured..."
    ]
}

# 2. Inject into English posts (5% during crisis)
if period_name in ['concerns_emerging', 'crisis_building']:
    if random.random() < 0.05:
        # 20% original, 40% reactions, 40% shares
        text = random.choice(template_category)
        image_filename = 'chinese_man_not_happy_angry_icecream.png'
        sentiment = random.uniform(0.05, 0.25)  # Very low
        likes = int(random.lognormvariate(7, 2))  # High engagement

# 3. Also in Chinese language posts
CHINESE_TEMPLATES['concerns_emerging'].append(
    "我给妈妈买了神经花蜜治疗记忆力减退。现在她在医院里。脑损伤+胃问题。我的错。😢"
)
```

**Results**:
- 83 total text mentions
- 30 posts with associated image
- Viral engagement (high likes/retweets)
- Emotional impact (sentiment 0.08-0.24)
- Geographic spread (appeared in 8+ countries)

---

## Sentiment Progression Design

### Time Period Sentiment Curves

```python
PERIODS = {
    "early_hype": {
        "avg_sentiment": 0.75,  # High optimism
        "posts": 800
    },
    "concerns_emerging": {
        "avg_sentiment": 0.55,  # Slight worry
        "posts": 650
    },
    "crisis_building": {
        "avg_sentiment": 0.35,  # Fear/concern
        "posts": 900
    },
    "collapse": {
        "avg_sentiment": 0.15,  # Very negative
        "posts": 750
    },
    "aftermath": {
        "avg_sentiment": 0.25,  # Reflective
        "posts": 389
    }
}
```

**Sentiment Assignment**:
```python
sentiment = max(0.0, min(1.0, random.gauss(config['avg_sentiment'], 0.15)))
```
- Gaussian distribution around period average
- Standard deviation of 0.15 for variety
- Clamped to 0.0-1.0 range

**Special Cases**:
- Viral story: Force 0.05-0.25 (very negative)
- Company spokespeople: Slightly higher than average
- CEO posts: Often defensive (lower during crisis)

---

## Snowflake Deployment Pattern

### Stage Creation

```sql
CREATE OR REPLACE STAGE {DATABASE}.{SCHEMA}.SOCIAL_MEDIA_IMAGES
  DIRECTORY = (enable = true)
  ENCRYPTION = (type = 'snowflake_sse')
  COMMENT = 'Social media images - 7 PNG files showing complete NRNT narrative arc';

-- Upload all images
PUT file:///{CI_PROJECT_DIR}/dataops/event/social_media_images/*.* 
    @{DATABASE}.{SCHEMA}.SOCIAL_MEDIA_IMAGES/ 
    auto_compress = false 
    overwrite = true;

ALTER STAGE {DATABASE}.{SCHEMA}.SOCIAL_MEDIA_IMAGES REFRESH;
LIST @{DATABASE}.{SCHEMA}.SOCIAL_MEDIA_IMAGES;
```

### Table Loading

```sql
-- 1. Create temporary stage
CREATE TEMPORARY STAGE social_media_stage
  FILE_FORMAT = (
    TYPE = CSV
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    ESCAPE_UNENCLOSED_FIELD = NONE
    DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
    ENCODING = 'UTF8'
  );

-- 2. Upload CSV
PUT file:///{CI_PROJECT_DIR}/dataops/event/DATA/social_media_nrnt_collapse.csv 
    @social_media_stage 
    overwrite = true;

-- 3. Load into table
COPY INTO SOCIAL_MEDIA_NRNT
FROM @social_media_stage/social_media_nrnt_collapse.csv
FILE_FORMAT = (TYPE = CSV SKIP_HEADER = 1 
               FIELD_OPTIONALLY_ENCLOSED_BY = '"'
               ENCODING = 'UTF8');

-- 4. Verify
SELECT COUNT(*), 
       COUNT(DISTINCT LANGUAGE) as languages,
       COUNT(CASE WHEN IMAGE_FILENAME != '' THEN 1 END) as posts_with_images
FROM SOCIAL_MEDIA_NRNT;

-- 5. Cleanup
DROP STAGE social_media_stage;
```

---

## Key Design Patterns

### 1. Proportional Distribution

```python
# Distribute minority languages proportionally across periods
french_per_period = {
    period: int(TARGET_POSTS_FRENCH * (config['posts'] / TARGET_POSTS_ENGLISH))
    for period, config in PERIODS.items()
}
```

**Why**: Maintains timeline consistency across languages

### 2. Realistic Engagement Metrics

```python
'likes': int(random.lognormvariate(5, 2)),      # Long tail distribution
'retweets': int(random.lognormvariate(4, 1.5)), # Fewer shares than likes
'replies': int(random.lognormvariate(3, 1.5))   # Even fewer replies
```

**Why**: Mimics real social media engagement patterns (power law)

### 3. Platform-Specific Handles

```python
def generate_french_handle(platform):
    if platform == "Reddit":
        return f"u/{prefix}_{suffix}_{random.randint(100, 9999)}"
    elif platform == "LinkedIn":
        return "Directeur Innovation"  # Professional title
    else:
        return f"@{prefix}{suffix}{random.randint(10, 999)}"
```

**Why**: Authentic platform conventions (Reddit u/, Twitter @, LinkedIn titles)

### 4. Crisis Timeline Realism

**Image Frequency Over Time**:
- Early Hype: 30-40% have images (celebration phase)
- Concerns: 15-20% have images (some still posting)
- Crisis: 10-15% have images (mostly negative)
- Collapse: 5-10% have images (crisis imagery only)
- Aftermath: 0-5% have images (everything over)

**Post Volume Pattern**:
- Early: 800 posts (excitement)
- Concerns: 650 posts (reduced activity)
- Crisis: 900 posts (peak engagement during drama)
- Collapse: 750 posts (still high)
- Aftermath: 389 posts (dying down)

### 5. Viral Content Mechanics

```python
# Viral story appears in 5% of crisis period posts
if period_name in ['concerns_emerging', 'crisis_building']:
    if random.random() < 0.05:
        # 20% breaking news, 80% reactions/shares
        if random.random() < 0.2:
            text = original_story
        else:
            text = reaction_or_share
        
        # Viral engagement boost
        likes = int(random.lognormvariate(7, 2))    # Higher than normal
        retweets = int(random.lognormvariate(5, 1.8))
        sentiment = random.uniform(0.05, 0.25)      # Very negative
```

**Result**: 83 posts about one story = viral spread

---

## Multi-Modal Integration

### Image-to-Post Linking

**Approach**: Store only filename (not full path) in CSV

```csv
timestamp,platform,...,image_filename
2024-09-11 04:33:36,Instagram,...,chinese_man_not_happy_angry_icecream.png
```

**Snowflake Usage**:
```sql
-- Construct full path in queries
SELECT 
    TEXT,
    IMAGE_FILENAME,
    CONCAT('@SOCIAL_MEDIA_IMAGES/', IMAGE_FILENAME) AS full_stage_path
FROM SOCIAL_MEDIA_NRNT
WHERE IMAGE_FILENAME != '';
```

**Why**: 
- Flexibility (users can reference different stages)
- Clarity (filename alone is self-documenting)
- Portability (works across environments)

### Vision AI Integration

```sql
-- Filter images by visual content
WHERE SNOWFLAKE.CORTEX.AI_FILTER(
    TO_FILE('@DOCUMENT_AI.SOCIAL_MEDIA_IMAGES/' || IMAGE_FILENAME),
    'This image shows crisis or negative outcomes'
) = TRUE;

-- Classify images
SNOWFLAKE.CORTEX.AI_CLASSIFY(
    TO_FILE('@DOCUMENT_AI.SOCIAL_MEDIA_IMAGES/' || RELATIVE_PATH),
    ['Product Success', 'Crisis', 'Personal Tragedy', 'Executive']
)
```

---

## Testing & Validation Checklist

### Data Quality Checks

```bash
# 1. Row count matches target
wc -l social_media_nrnt_collapse.csv  # Should be 4210 (4209 + header)

# 2. Language distribution
awk -F',' '$14 != "" {langs[$14]++} END {for (l in langs) print l, langs[l]}' file.csv

# 3. Image assignment count
grep -E "(png|jpg)" file.csv | wc -l

# 4. Date range coverage
head -2 file.csv | tail -1  # First post
tail -1 file.csv            # Last post

# 5. Geolocation completeness
awk -F',' 'NR>1 && ($15 == "" || $16 == "") {print "Missing coords:", $1}' file.csv
```

### SQL Validation Queries

```sql
-- Verify load
SELECT 
    COUNT(*) AS total_posts,
    COUNT(DISTINCT LANGUAGE) AS languages,
    COUNT(DISTINCT COUNTRY) AS countries,
    COUNT(DISTINCT PLATFORM) AS platforms,
    COUNT(CASE WHEN IMAGE_FILENAME != '' THEN 1 END) AS posts_with_images,
    MIN(TIMESTAMP) AS first_post,
    MAX(TIMESTAMP) AS last_post
FROM SOCIAL_MEDIA_NRNT;

-- Check language distribution
SELECT 
    LANGUAGE,
    COUNT(*) AS posts,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS percentage
FROM SOCIAL_MEDIA_NRNT
GROUP BY LANGUAGE;

-- Verify viral story
SELECT COUNT(*) 
FROM SOCIAL_MEDIA_NRNT
WHERE LOWER(TEXT) LIKE '%chinese%mother%'
   OR IMAGE_FILENAME = 'chinese_man_not_happy_angry_icecream.png';
-- Should return ~83

-- Check sentiment progression
SELECT 
    DATE_TRUNC('week', TIMESTAMP) AS week,
    AVG(SENTIMENT) AS avg_sentiment
FROM SOCIAL_MEDIA_NRNT
GROUP BY week
ORDER BY week;
-- Should show clear decline over time
```

---

## Lessons Learned & Best Practices

### 1. Iterative Enhancement Works Best

**Evolution**:
1. Started with basic English posts
2. Added geolocation (LOCATION, COUNTRY)
3. Added coordinates (LATITUDE, LONGITUDE)
4. Added Chinese posts (5%)
5. Added French posts (15%)
6. Added images (IMAGE_FILENAME)
7. Added viral story narrative

**Lesson**: Build incrementally, test each addition

### 2. Template-Based Generation is Maintainable

**Bad**:
```python
text = f"Random text {random.choice(words)}"  # Hard to control quality
```

**Good**:
```python
templates = ["Template 1", "Template 2"]
text = random.choice(templates).format(var=value)
```

**Why**: Ensures quality, enables translation, maintains narrative coherence

### 3. Realistic Distribution Matters

**Don't**:
```python
sentiment = random.random()  # Uniform distribution (unrealistic)
```

**Do**:
```python
sentiment = max(0.0, min(1.0, random.gauss(avg, stddev)))  # Gaussian
likes = int(random.lognormvariate(5, 2))  # Power law
```

**Why**: Real social media follows power laws (few viral posts, many low-engagement)

### 4. CSV Encoding is Critical

```python
with open(file, 'w', newline='', encoding='utf-8') as f:
    writer = csv.DictWriter(f, fieldnames=fieldnames)
```

**Must-haves**:
- `encoding='utf-8'` for multi-language support
- `newline=''` prevents extra blank lines
- Field order matches SQL schema

### 5. Snowflake Stage Wildcards

```sql
-- Upload all files in directory
PUT file:///.../social_media_images/*.* 
    @STAGE/ 
    auto_compress = false;
```

**Why**: 
- Simpler than individual PUT commands
- Automatically includes new files
- `auto_compress = false` for images (already compressed)

---

## File Organization

```
dataops/event/
├── DATA/
│   ├── social_media_nrnt_collapse.csv          # Main dataset (4,209 posts)
│   └── generate_social_media_posts_v2.py       # Generation script
│
├── social_media_images/                         # Stage source files
│   ├── dev_team_icecream.png                   # Hype phase
│   ├── eating_icecream.png
│   ├── icecream_brainfog_gone.png
│   ├── neuro_icecream.png
│   ├── icecream_in_landfill_recall.png         # Crisis phase
│   ├── chinese_man_not_happy_angry_icecream.png # Viral story
│   └── ceo_neuro_nectar_leaving_office_gone_bust.png # Collapse
│
├── data_foundation.template.sql                 # Table creation
└── deploy_documentai.template.sql              # Stage deployment
```

---

## Reusability for Future Datasets

### Adapting the Script for Other Scenarios

**To create a new crisis/event dataset**:

1. **Update Constants**:
   ```python
   OUTPUT_FILE = "new_event.csv"
   TARGET_POSTS = 5000
   ```

2. **Define Time Periods**:
   ```python
   PERIODS = {
       "pre_event": {...},
       "event_occurs": {...},
       "aftermath": {...}
   }
   ```

3. **Create Templates**:
   ```python
   TEMPLATES = {
       'pre_event': ["Template text 1", "Template text 2"],
       # etc.
   }
   ```

4. **Adjust Sentiment Curve**:
   ```python
   # Match your event's emotional arc
   "event_occurs": {"avg_sentiment": 0.25}  # Negative event
   ```

5. **Define Locations** (if needed):
   ```python
   LOCATIONS = [("City", "Country", "lang", lat, lon), ...]
   ```

6. **Run Script**:
   ```bash
   python3 generate_script.py
   ```

### Universal Patterns

**Works for**:
- Product launches (positive → neutral)
- Company crises (neutral → negative)
- Mergers/acquisitions (mixed sentiment)
- Regulatory events (fear → adaptation)
- Competitive battles (polarized sentiment)

**Key**: Template-based approach is infinitely flexible

---

## Performance Optimization

### Large Dataset Generation

**For 10,000+ posts**:

```python
# 1. Generate in batches
BATCH_SIZE = 1000
for batch in range(0, TOTAL_POSTS, BATCH_SIZE):
    batch_posts = generate_batch(BATCH_SIZE)
    all_posts.extend(batch_posts)

# 2. Use generator expressions (memory efficient)
posts = (generate_post(i) for i in range(TOTAL_POSTS))

# 3. Write incrementally
with open(file, 'w') as f:
    writer = csv.DictWriter(f, fieldnames)
    writer.writeheader()
    for batch in batches:
        writer.writerows(batch)
```

### Snowflake Loading Optimization

```sql
-- Use COPY instead of INSERT for large datasets
COPY INTO table FROM @stage
FILE_FORMAT = (TYPE = CSV ...)
ON_ERROR = CONTINUE;  -- Don't fail entire load on one bad row

-- Create indexes after load
ALTER TABLE SOCIAL_MEDIA_NRNT 
ADD SEARCH OPTIMIZATION ON EQUALITY(LANGUAGE, COUNTRY);
```

---

## Advanced Analysis Patterns

### Multi-Modal Query Template

```sql
WITH 
-- Text analysis
text_insights AS (
    SELECT 
        DATE(TIMESTAMP) AS date,
        SNOWFLAKE.CORTEX.AI_SUMMARIZE_AGG(TEXT) AS daily_themes
    FROM SOCIAL_MEDIA_NRNT
    GROUP BY date
),
-- Image analysis
image_analysis AS (
    SELECT 
        DATE(s.TIMESTAMP) AS date,
        SNOWFLAKE.CORTEX.AI_CLASSIFY(
            TO_FILE('@SOCIAL_MEDIA_IMAGES/' || s.IMAGE_FILENAME),
            ['Positive', 'Negative', 'Neutral']
        ) AS visual_sentiment
    FROM SOCIAL_MEDIA_NRNT s
    WHERE s.IMAGE_FILENAME != ''
),
-- Geospatial analysis
geographic AS (
    SELECT 
        DATE(TIMESTAMP) AS date,
        COUNT(DISTINCT COUNTRY) AS countries_posting
    FROM SOCIAL_MEDIA_NRNT
    GROUP BY date
),
-- Translation analysis
translated AS (
    SELECT 
        DATE(TIMESTAMP) AS date,
        SNOWFLAKE.CORTEX.AI_AGG(
            SNOWFLAKE.CORTEX.AI_TRANSLATE(TEXT, LANGUAGE, 'en'),
            'Summarize sentiment across all languages'
        ) AS global_sentiment
    FROM SOCIAL_MEDIA_NRNT
    WHERE LANGUAGE != 'en'
    GROUP BY date
)
-- Combine all dimensions
SELECT 
    t.date,
    t.daily_themes,
    i.visual_sentiment,
    g.countries_posting,
    tr.global_sentiment
FROM text_insights t
LEFT JOIN image_analysis i ON t.date = i.date
LEFT JOIN geographic g ON t.date = g.date
LEFT JOIN translated tr ON t.date = tr.date
ORDER BY t.date;
```

---

## Common Pitfalls & Solutions

### Problem 1: Image Assignment Too High

**Symptom**: Every post has an image (unrealistic)

**Fix**: Use probability gates
```python
if period_name == 'early_hype' and random.random() < 0.3:
    return image_name
```

### Problem 2: Sentiment Too Uniform

**Symptom**: All posts have similar sentiment

**Fix**: Use Gaussian distribution + outliers
```python
sentiment = random.gauss(avg, 0.15)  # Natural variation
if random.random() < 0.05:
    sentiment = random.uniform(0, 1)  # 5% outliers
```

### Problem 3: CSV Encoding Errors

**Symptom**: Chinese/French characters corrupted

**Fix**: Always use UTF-8
```python
with open(file, 'w', encoding='utf-8') as f:
```

**Snowflake**:
```sql
FILE_FORMAT = (... ENCODING = 'UTF8')
```

### Problem 4: Timestamp Clustering

**Symptom**: Posts clumped at certain times

**Fix**: Random distribution within period
```python
time_delta = (config['end'] - config['start']).total_seconds()
random_seconds = random.randint(0, int(time_delta))
timestamp = config['start'] + timedelta(seconds=random_seconds)
```

### Problem 5: Stage File Access

**Symptom**: `TO_FILE()` errors in queries

**Fix**: Use proper stage path construction
```sql
TO_FILE('@SCHEMA.STAGE/' || RELATIVE_PATH)
-- NOT: TO_FILE(RELATIVE_PATH)
```

---

## Extension Ideas

### Adding New Data Types

**Video Posts**:
```python
'video_filename': assign_video(),  # New column
'video_duration': random.randint(5, 120),
'video_views': int(random.lognormvariate(8, 2))
```

**Polls/Surveys**:
```python
'poll_question': generate_poll(),
'poll_votes': int(random.lognormvariate(6, 1.5)),
'poll_results': generate_poll_distribution()
```

**Linked Articles**:
```python
'article_url': generate_url(),
'article_title': generate_headline(),
'article_source': random.choice(['Reuters', 'Bloomberg', 'TechCrunch'])
```

### Adding More Languages

```python
# Spanish (Latin America)
LOCATIONS_SPANISH = [
    ("Ciudad de México", "Mexico", "es", 19.4326, -99.1332),
    ("Buenos Aires", "Argentina", "es", -34.6037, -58.3816),
    # ...
]

SPANISH_TEMPLATES = {
    'crisis_building': [
        "¡Dejen de usar Neuro-Nectar! Efectos secundarios graves.",
        # ...
    ]
}
```

### Adding Competitor Responses

```python
AUTHOR_TYPES = {
    # ... existing types
    "Competitor_ICBG": 0.02,
    "Competitor_QRYQ": 0.02,
}

# Competitor templates during NRNT crisis
if author_type.startswith('Competitor'):
    if period_name in ['crisis_building', 'collapse']:
        text = random.choice([
            "Our cognitive platform is FDA-approved and safe. #ICBG",
            "Query performance AND user safety. That's the QRYQ difference.",
        ])
        sentiment = random.uniform(0.6, 0.85)  # Positive (competitive advantage)
```

---

## Documentation Standards

### Inline Comments

```python
# Good comment style:
TARGET_POSTS_CHINESE = 175  # 5% additional

# Location tuple: (city, country, language, latitude, longitude)
LOCATIONS_FRENCH = [
    ("Paris", "France", "fr", 48.8566, 2.3522),
]

# Template with translation
"我的错。😢",  # "My fault" (expressing guilt)
```

### SQL Documentation

```sql
-- =====================================================
-- SOCIAL MEDIA IMAGES STAGE
-- =====================================================
-- Purpose: Store product/user-generated images
-- Content: 7 PNG files showing crisis progression
-- Timeline:
--   EARLY HYPE: product success images
--   CRISIS: recall/waste imagery
--   COLLAPSE: CEO departure
-- =====================================================
```

### README Pattern

Every dataset should have:
1. **Purpose**: What story it tells
2. **Schema**: Column descriptions
3. **Source**: How it was generated
4. **Usage**: Query examples
5. **Limitations**: Known constraints

---

## Integration with AISQL

### Latest Function Syntax (2025)

All queries should use:

```sql
-- OLD (deprecated)
SNOWFLAKE.CORTEX.TRANSLATE(text, 'zh', 'en')
SNOWFLAKE.CORTEX.CLASSIFY_TEXT(text, categories)
SNOWFLAKE.CORTEX.EMBED_TEXT_1024('model', text)

-- NEW (current)
SNOWFLAKE.CORTEX.AI_TRANSLATE(text, 'zh', 'en')
SNOWFLAKE.CORTEX.AI_CLASSIFY(text, categories)
SNOWFLAKE.CORTEX.AI_EMBED('model', text)

-- NEW functions (2025)
SNOWFLAKE.CORTEX.AI_AGG(column, 'prompt')
SNOWFLAKE.CORTEX.AI_SIMILARITY(embedding1, embedding2)
SNOWFLAKE.CORTEX.AI_FILTER(input, 'condition')
SNOWFLAKE.CORTEX.AI_TRANSCRIBE(TO_FILE(path), options)
```

### Vision AI on Images

```sql
-- Image classification
SNOWFLAKE.CORTEX.AI_CLASSIFY(
    TO_FILE('@STAGE/' || image_file),
    ['Category1', 'Category2']
)

-- Image filtering
WHERE SNOWFLAKE.CORTEX.AI_FILTER(
    TO_FILE('@STAGE/' || image_file),
    'Contains product or people'
) = TRUE

-- Image embeddings
SNOWFLAKE.CORTEX.AI_EMBED(
    'clip-vit-base-patch32',  -- Vision model
    TO_FILE('@STAGE/' || image_file)
)
```

---

## Summary: Complete Dataset Features

✅ **4,209 social media posts**
✅ **3 languages** (en, zh, fr)
✅ **31 locations** across 13+ countries
✅ **Geolocation data** (lat/long for all posts)
✅ **7 images** linked to posts
✅ **Viral story tracking** (83 posts)
✅ **5-month timeline** (Aug-Dec 2024)
✅ **Sentiment progression** (0.75 → 0.15)
✅ **17 columns** (comprehensive schema)
✅ **Snowflake deployment** (table + stage)
✅ **AISQL ready** (latest 2025 syntax)
✅ **Multi-modal analysis** (text, images, geospatial, audio)

**Total Lines of Code**: ~620 lines Python
**Generation Time**: ~2 seconds
**Dataset Size**: 790 KB CSV
**Image Package**: 8.3 MB (7 PNG files)

---

## References

- **Snowflake AISQL Docs**: https://docs.snowflake.com/en/user-guide/snowflake-cortex/aisql
- **Script Location**: `dataops/event/DATA/generate_social_media_posts_v2.py`
- **CSV Output**: `dataops/event/DATA/social_media_nrnt_collapse.csv`
- **Images**: `dataops/event/social_media_images/`
- **SQL Table**: `data_foundation.template.sql` (line ~1715)
- **SQL Stage**: `deploy_documentai.template.sql` (line ~219)
- **Hackathon Guide**: `homepage/docs/More_Activities.md`

---

## Quick Reference: Generate New Dataset

```bash
# 1. Copy template
cp generate_social_media_posts_v2.py generate_new_event.py

# 2. Update constants
# TARGET_POSTS, PERIODS, LOCATIONS, TEMPLATES

# 3. Generate
python3 generate_new_event.py

# 4. Verify
wc -l output.csv
head -5 output.csv

# 5. Deploy to Snowflake
# Add to data_foundation.template.sql
# Add stage to deploy_documentai.template.sql (if images)
```

**Total time**: ~1 hour for new dataset (if following this pattern)

