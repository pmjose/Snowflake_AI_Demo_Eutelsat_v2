# Audio Script Organization & Templates

## Overview

This guide defines the file structure and templates for creating audio scripts that will be converted to MP3 files using ElevenLabs (or other TTS services) for use with Snowflake's `AI_TRANSCRIBE` function.

---

## Directory Structure

### Recommended Organization

```
dataops/event/
├── audio_scripts/                    # Master directory for all scripts
│   ├── interviews/                   # Interview-style audio
│   │   ├── NRNT_CEO_Interview.md
│   │   ├── Analyst_Debate.md
│   │   └── Customer_Testimonial.md
│   │
│   ├── news_reports/                 # News/narrator style
│   │   ├── Market_Update.md
│   │   └── Breaking_News.md
│   │
│   ├── earnings_calls/               # Earnings call simulations
│   │   ├── Q1_FY2025_Simulation.md
│   │   └── Q2_FY2025_Simulation.md
│   │
│   ├── debates/                      # Multi-party discussions
│   │   └── Platform_Comparison.md
│   │
│   └── templates/                    # Reusable templates
│       ├── TEMPLATE_Interview.md
│       ├── TEMPLATE_News_Report.md
│       ├── TEMPLATE_Debate.md
│       └── TEMPLATE_Earnings_Call.md
│
├── interviews/                       # Generated MP3 files (output)
│   ├── NRNT_CEO_Interview.mp3
│   ├── Analyst_Debate.mp3
│   └── (other audio files)
│
└── audio_metadata/                   # Tracking and metadata
    └── audio_catalog.json           # Index of all audio files
```

---

## File Naming Conventions

### Script Files (.md)

**Format**: `[Type]_[Subject]_[Descriptor].md`

**Examples**:
```
Good:
  Interview_NRNT_CEO_PostCollapse.md
  News_Market_Crash_Report.md
  Debate_SNOW_vs_ICBG_Comparison.md
  Earnings_Q3_FY2025_Simulation.md
  Testimonial_Customer_Success_Story.md

Bad:
  script1.md
  audio.md
  interview.md  (too generic)
```

### Generated Audio Files (.mp3)

**Format**: `[Type]_[Subject]_[Descriptor].mp3`

**Match script name** (remove .md, add .mp3):
```
Script:     Interview_NRNT_CEO_PostCollapse.md
Audio:      Interview_NRNT_CEO_PostCollapse.mp3
```

**Benefits**: Easy to trace audio back to script

---

## Script Template (Standard Format)

### Complete Template Structure

```markdown
# [Audio Title]

**Type**: Interview | News Report | Debate | Earnings Call | Testimonial
**Duration Target**: X minutes
**Speakers**: [Number] ([List speaker roles])
**Purpose**: [Why this audio exists - AI demo, training data, etc.]
**Generated Date**: YYYY-MM-DD
**Generator**: ElevenLabs | Google TTS | Manual Recording

---

## Metadata

**File Output**: filename.mp3
**Snowflake Stage**: @DATABASE.SCHEMA.STAGE_NAME
**Related Data**: [Links to related tables, reports, etc.]

---

## Voice Specifications

### Speaker 1: [ROLE NAME]

**Characteristics**:
- Age, gender
- Emotional state (happy, sad, neutral, angry, professional)
- Speaking style (fast, slow, deliberate, excited)
- Accent (American, British, neutral)
- Tone (authoritative, empathetic, defensive)

**ElevenLabs Voice**: [Recommended voice name]
**Voice Settings**:
- Stability: 0.X
- Similarity: 0.X  
- Style Exaggeration: 0.X

**Alternative Voices**: [Other options if primary not available]

### Speaker 2: [ROLE NAME]

[Same structure as Speaker 1]

---

## Story Arc

**Setup** (0-1 min):
- Brief description of what happens

**Rising Action** (1-3 min):
- Key developments

**Climax** (3-5 min):
- Emotional or informational peak

**Resolution** (5-7 min):
- Conclusions, lessons, next steps

---

## Complete Dialogue

### [00:00-00:XX] Section Name

**[SPEAKER]**: [emotional:tag if needed]

Actual dialogue here. [pause:2s] More dialogue.

**[SPEAKER2]**:

Response. [emotional:tag] Emotional part.

---

## Production Notes

**Audio Quality**:
- Target bitrate: 128kbps MP3
- Stereo or mono
- Sample rate: 44.1kHz

**Emotional Beats**:
- List key emotional moments and timestamps

**Key Phrases for AI_EXTRACT**:
- List important facts/data mentioned
- Makes it easy to test AI_EXTRACT later

**Multi-Modal Links**:
- Related tables in Snowflake
- Related documents (annual reports, etc.)
- Related social media posts

---

## AI_TRANSCRIBE Test Queries

[Include 3-5 example SQL queries to test after generation]

```sql
-- Basic transcription
SELECT AI_TRANSCRIBE(TO_FILE('@STAGE/filename.mp3'));

-- Extract specific information
SELECT AI_EXTRACT(transcript, 'What are the key lessons?');

-- Sentiment analysis
SELECT AI_SENTIMENT(transcript);
```

---

## Change Log

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| YYYY-MM-DD | 1.0 | Initial script | Name |
| YYYY-MM-DD | 1.1 | Added narrator intro | Name |
```

---

## Template Types

### 1. Interview Template

**File**: `TEMPLATE_Interview.md`

**Use for**:
- CEO interviews
- Expert conversations
- Post-mortem discussions
- Product launch interviews
- Customer testimonials

**Structure**:
- 2-3 speakers (Interviewer + 1-2 guests)
- Optional narrator for intro/outro
- Q&A format
- 5-10 minutes typical length

### 2. News Report Template

**File**: `TEMPLATE_News_Report.md`

**Use for**:
- Breaking news announcements
- Market updates
- Investigation reports
- Documentary narration

**Structure**:
- 1 speaker (narrator)
- Broadcast journalism style
- Fact-heavy, professional tone
- 2-5 minutes typical length

### 3. Debate Template

**File**: `TEMPLATE_Debate.md`

**Use for**:
- Competitive comparisons
- Pro/con discussions
- Panel discussions
- Contrasting viewpoints

**Structure**:
- 2-4 speakers
- Optional moderator
- Back-and-forth dialogue
- Varied emotional tones
- 7-15 minutes typical length

### 4. Earnings Call Template

**File**: `TEMPLATE_Earnings_Call.md`

**Use for**:
- Quarterly earnings simulations
- Financial presentations
- Analyst Q&A sessions

**Structure**:
- 3-5 speakers (CEO, CFO, 2-3 analysts)
- Formal, professional tone
- Data-heavy dialogue
- 10-20 minutes typical length

### 5. Customer Testimonial Template

**File**: `TEMPLATE_Testimonial.md`

**Use for**:
- Product reviews
- Success stories
- Complaint narratives
- User experiences

**Structure**:
- 1 speaker (customer)
- Personal, emotional tone
- Story-based format
- 1-3 minutes typical length

---

## Metadata Catalog System

### audio_catalog.json Structure

```json
{
  "audio_files": [
    {
      "id": "nrnt_ceo_001",
      "title": "The Fall of Neuro-Nectar",
      "type": "interview",
      "script_file": "audio_scripts/interviews/NRNT_CEO_Interview.md",
      "audio_file": "interviews/NRNT_CEO_Interview.mp3",
      "duration_minutes": 7.5,
      "speakers": [
        {"name": "Narrator", "voice": "Serena", "gender": "F"},
        {"name": "Sarah Jenkins", "role": "Interviewer", "voice": "Rachel", "gender": "F"},
        {"name": "Dr. Marcus Sterling", "role": "CEO", "voice": "Adam", "gender": "M"}
      ],
      "created_date": "2024-10-31",
      "generator": "ElevenLabs Projects",
      "character_count": 3500,
      "cost_estimate": "$0 (free tier)",
      "snowflake_stage": "@DOCUMENT_AI.INTERVIEWS",
      "purpose": "AI_TRANSCRIBE demo, crisis post-mortem",
      "emotional_arc": "defeated → defensive → regretful → resigned",
      "key_topics": [
        "unit economics failure",
        "FDA warning",
        "customer harm",
        "CFO warnings ignored",
        "lessons learned"
      ],
      "related_data": {
        "social_media": "SOCIAL_MEDIA_NRNT table (4,209 posts)",
        "annual_reports": "NRNT_Annual_Report_FY2024.pdf, FY2025.pdf",
        "stock_data": "STOCK_PRICES table (NRNT ticker)",
        "executive_bio": "executive_bios/NRNT_Executive_Team.pdf"
      },
      "ai_transcribe_tested": true,
      "transcription_quality": "excellent",
      "speaker_diarization": "successful (3 speakers detected)",
      "example_queries": [
        "What lessons does Dr. Sterling mention?",
        "What was the biggest mistake?",
        "What happened to the stock price?"
      ]
    }
  ]
}
```

---

## Interview Script Template (Complete)

**File**: `audio_scripts/templates/TEMPLATE_Interview.md`

```markdown
# [Interview Title]

**Type**: Interview
**Duration Target**: 5-7 minutes
**Speakers**: 3 (Narrator, Interviewer, Subject)
**Purpose**: [AI_TRANSCRIBE demo | Training data | Crisis analysis]
**Generated Date**: YYYY-MM-DD

---

## Metadata

**File Output**: [filename].mp3
**Snowflake Stage**: @[DATABASE].[SCHEMA].[STAGE]
**Related Data**: [Related tables, documents]

---

## Voice Specifications

### Narrator (Optional Opening)

**Characteristics**:
- Professional broadcast journalist
- Female or male
- Neutral, authoritative tone
- Clear enunciation

**ElevenLabs Voice**: Serena (F) or Josh (M)
**Settings**: Stability 0.75, Similarity 0.8, Style 0.3

---

### Interviewer

**Characteristics**:
- Professional journalist
- Empathetic but probing
- Female or male
- Measured pace

**ElevenLabs Voice**: Rachel (F) or Josh (M)
**Settings**: Stability 0.7, Similarity 0.75, Style 0.4

---

### Subject/Guest

**Characteristics**:
- [Describe emotional state: defeated, confident, defensive]
- [Age range]
- [Speaking style: hesitant, confident, etc.]

**ElevenLabs Voice**: [Voice name]
**Settings**: Stability 0.5-0.6, Similarity 0.7, Style 0.5-0.7

---

## Story Arc

**Opening** (0-1 min): Set up context and introduce subject  
**Background** (1-2 min): Establish history and what led to this moment  
**Core Discussion** (2-5 min): Main topic, emotional peak  
**Lessons/Reflection** (5-7 min): Takeaways, what's next  
**Closing** (7-8 min): Final thoughts  

---

## Complete Dialogue

### [00:00-00:45] Opening (Narrator - Optional)

**Narrator**:
[speed:0.95] [Opening line that sets up the story]

[pause:2s]

[Context and background in 2-3 sentences]

[pause:3s]

---

### [00:45-01:00] Introduction

**Interviewer**:
[Guest name], thank you for joining us. [pause:1s] How are you doing?

**Guest**:
[emotional:sad/happy/neutral] [Response here]

---

### [01:00-02:00] Section 1: [Topic Name]

**Interviewer**:
[Question about topic]

**Guest**:
[Answer with emotional tags and pauses]

---

### [02:00-03:00] Section 2: [Topic Name]

[Continue pattern...]

---

### [Final Section] Closing

**Interviewer**:
Final question?

**Guest**:
[emotional:tag] Final reflective answer. [pause:3s]

**Interviewer** (Optional):
Thank you for sharing your story.

---

## Production Notes

**Key Emotional Moments**:
- [Time]: [What happens emotionally]

**Important Facts Mentioned**:
- [List data points, metrics, dates for AI_EXTRACT testing]

**Related Data in Snowflake**:
- Table: [table_name]
- Stage: [stage_name]
- Other audio: [related files]

---

## AI_TRANSCRIBE Test Queries

```sql
-- Basic transcription
SELECT AI_TRANSCRIBE(TO_FILE('@STAGE/filename.mp3'));

-- Extract key information
SELECT AI_EXTRACT(transcript, '[your question here]');

-- Sentiment analysis
SELECT AI_SENTIMENT(transcript);
```

---

## ElevenLabs Generation Checklist

- [ ] Script complete and proofread
- [ ] Speaker names clearly defined
- [ ] Emotional tags placed correctly
- [ ] Pauses strategically placed
- [ ] Character count estimated: [X chars]
- [ ] Fits within monthly limit
- [ ] Voices selected in ElevenLabs
- [ ] Project created
- [ ] Dialogue pasted
- [ ] Generated and previewed
- [ ] Downloaded as MP3
- [ ] Saved to interviews/ directory
- [ ] Uploaded to Snowflake stage
- [ ] AI_TRANSCRIBE tested

---

## Change Log

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| YYYY-MM-DD | 1.0 | Initial script | [Name] |
```

---

## News Report Template (Complete)

**File**: `audio_scripts/templates/TEMPLATE_News_Report.md`

```markdown
# [News Report Title]

**Type**: News Report
**Duration Target**: 2-5 minutes
**Speakers**: 1 (Narrator)
**Purpose**: Breaking news | Market update | Investigation report
**Generated Date**: YYYY-MM-DD

---

## Voice Specifications

### Narrator

**Characteristics**:
- Professional broadcast journalist
- Authoritative, neutral tone
- Clear enunciation
- Controlled pacing

**ElevenLabs Voice**: Serena (F) or Josh (M)
**Settings**: Stability 0.8, Similarity 0.8, Style 0.3

---

## Complete Script

**Narrator**:
[speed:0.95] [Opening headline - punchy, attention-grabbing]

[pause:2s]

[Context paragraph - who, what, when, where, why]

[pause:1s]

[Details paragraph - key facts and figures]

[pause:2s]

[Impact paragraph - what this means]

[pause:1s]

[Closing paragraph - what's next, final thought]

[pause:3s]

[Optional tagline or station ID]

---

## Production Notes

**Pacing**: Slower than normal speech (0.9-0.95 speed)
**Pauses**: Frequent (1-2s between major points)
**Tone**: Serious, professional, no emotion unless reporting emotional content

**Key Facts Mentioned**:
- [List for AI_EXTRACT testing]

---

## AI_TRANSCRIBE Test Queries

```sql
SELECT AI_EXTRACT(transcript, 'What are the key facts reported?');
SELECT AI_CLASSIFY(transcript, ['Breaking News', 'Analysis', 'Update', 'Investigation']);
```
```

---

## Debate Template (Complete)

**File**: `audio_scripts/templates/TEMPLATE_Debate.md`

```markdown
# [Debate Title]

**Type**: Debate
**Duration Target**: 10-15 minutes
**Speakers**: 3-4 (Moderator + 2-3 debaters)
**Purpose**: Competitive comparison | Policy discussion
**Generated Date**: YYYY-MM-DD

---

## Voice Specifications

### Moderator

**Characteristics**: Neutral, professional, controls flow
**ElevenLabs Voice**: Rachel (F) or Josh (M)
**Settings**: Stability 0.75, Style 0.3

### Debater 1 (Pro Position)

**Characteristics**: Confident, assertive
**ElevenLabs Voice**: [Name]
**Settings**: Stability 0.6, Style 0.5

### Debater 2 (Con Position)

**Characteristics**: Analytical, critical
**ElevenLabs Voice**: [Name]
**Settings**: Stability 0.6, Style 0.5

---

## Debate Structure

**Opening** (0-1 min): Moderator introduces topic and speakers  
**Opening Statements** (1-3 min): Each speaker presents position  
**Rebuttals** (3-7 min): Back-and-forth exchange  
**Q&A** (7-12 min): Moderator asks questions  
**Closing Statements** (12-15 min): Final words from each  

---

## Complete Dialogue

### Opening

**Moderator**:
Welcome to today's debate. [pause:1s] The question: [debate topic]

[pause:1s]

Joining us: [Speaker 1] representing [position], and [Speaker 2] representing [opposing position].

[pause:1s]

Let's begin with opening statements. [Speaker 1]?

### Opening Statements

**Debater1**:
[emotional:confident] Thank you. [pause:1s] 

[Opening argument - 30-45 seconds]

**Moderator**:
[Speaker 2], your opening?

**Debater2**:
[emotional:skeptical] [Contrasting opening - 30-45 seconds]

### Rebuttals

**Moderator**:
[Speaker 1], response to that?

**Debater1**:
[emotional:defensive] That's not accurate. [pause:1s] [Rebuttal]

[Continue pattern...]

---

## Production Notes

**Conflict Points**: [List where speakers disagree for emotional variety]
**Data Points**: [Facts mentioned for AI_EXTRACT]
**Emotional Range**: Confident → Defensive → Assertive → Resigned
```

---

## Earnings Call Template (Complete)

**File**: `audio_scripts/templates/TEMPLATE_Earnings_Call.md`

```markdown
# [Company] [Quarter] [Fiscal Year] Earnings Call

**Type**: Earnings Call Simulation
**Duration Target**: 15-20 minutes
**Speakers**: 4 (Operator, CEO, CFO, 2 Analysts)
**Purpose**: Financial data extraction demo
**Generated Date**: YYYY-MM-DD

---

## Voice Specifications

### Operator (Call Host)

**Characteristics**: Professional, neutral
**ElevenLabs Voice**: Rachel (F)

### CEO

**Characteristics**: Confident, upbeat (or tired if bad quarter)
**ElevenLabs Voice**: Adam (M)

### CFO

**Characteristics**: Detail-oriented, measured
**ElevenLabs Voice**: Antoni (M)

### Analyst 1

**Characteristics**: Inquisitive, professional
**ElevenLabs Voice**: Serena (F)

### Analyst 2

**Characteristics**: Skeptical, probing
**ElevenLabs Voice**: Josh (M)

---

## Call Structure

**Operator Intro** (0-1 min): Call details, forward-looking statements  
**CEO Opening** (1-5 min): Quarterly highlights, strategy  
**CFO Financials** (5-10 min): Revenue, margins, guidance  
**Q&A** (10-20 min): Analyst questions and management responses  

---

## Complete Dialogue

### Operator Introduction

**Operator**:
Good afternoon, and welcome to [Company] [Quarter] [Year] Earnings Conference Call.

[pause:1s]

I'm pleased to introduce [CEO name], Chief Executive Officer, and [CFO name], Chief Financial Officer.

[pause:1s]

Before we begin, please note that this call may contain forward-looking statements.

[pause:1s]

[CEO name], please go ahead.

### CEO Opening

**CEO**:
[emotional:confident] Thank you, and good afternoon everyone.

[pause:1s]

[Quarter] was a strong quarter for [Company]. [Key metrics]

[pause:1s]

[Continue with highlights...]

### CFO Financial Details

**CFO**:
Thank you, [CEO name]. Let me walk through the financials.

[pause:1s]

Revenue for [Quarter] was [amount], representing [growth]% year-over-year growth.

[Continue with financial data...]

### Q&A Section

**Operator**:
We'll now begin the question-and-answer session. [pause:1s]

Our first question comes from [Analyst name] at [Firm].

**Analyst1**:
Thanks for taking my question. [pause:1s] Can you talk about [specific topic]?

**CEO**:
[Response]

[Continue pattern...]
```

---

## Customer Testimonial Template

**File**: `audio_scripts/templates/TEMPLATE_Testimonial.md`

```markdown
# Customer Testimonial: [Product/Company]

**Type**: Testimonial
**Duration Target**: 1-3 minutes
**Speakers**: 1 (Customer)
**Purpose**: User experience | Success story | Complaint
**Generated Date**: YYYY-MM-DD

---

## Voice Specifications

### Customer

**Characteristics**:
- [Demographics: age, gender]
- [Emotional state: excited, frustrated, grateful, angry]
- [Speaking style: casual, professional]

**ElevenLabs Voice**: [Name]
**Settings**: 
- Stability: 0.5-0.6 (allow natural emotion)
- Style: 0.6-0.7 (more expressive)

---

## Story Structure

**Hook** (0-15s): Attention-grabbing opening  
**Background** (15-45s): Who they are, their problem  
**Solution/Product** (45-90s): Their experience  
**Result** (90-120s): Outcome (positive or negative)  
**Closing** (120-180s): Final thoughts, recommendation

---

## Complete Testimonial

**Customer**:
[emotional:happy/frustrated] [Opening hook]

[pause:2s]

[Background story - who you are, what problem you had]

[pause:1s]

[How you found/used the product]

[pause:2s]

[What happened - positive or negative outcome]

[pause:1s]

[emotional:tag] [Emotional conclusion]

[pause:2s]

[Final recommendation or warning]

---

## Production Notes

**Authenticity**: Should sound like real person, not scripted
**Pauses**: More natural, less formal than interview
**Emotion**: Should be genuine (excitement or frustration)

**Key Points for AI_EXTRACT**:
- Product name
- Specific problem/solution
- Measurable results (if any)
- Recommendation
```

---

## Workflow: Creating New Audio Script

### Step 1: Choose Template

```bash
cd audio_scripts/templates/
ls  # See available templates

# Copy template to new file
cp TEMPLATE_Interview.md ../interviews/New_Interview.md
```

### Step 2: Fill Out Metadata

```markdown
# [Your Title]

**Type**: [Interview | News | Debate | Earnings | Testimonial]
**Duration Target**: X minutes
**Speakers**: [Number and roles]
**Purpose**: [Why creating this]
**Generated Date**: 2024-11-01
```

### Step 3: Define Voices

```markdown
### Speaker 1: [ROLE]

**Characteristics**: [Describe]
**ElevenLabs Voice**: [Select from library]
**Settings**: Stability X, Style X
```

### Step 4: Write Dialogue

```markdown
### [00:00-01:00] Section Name

**Speaker1**:
Dialogue here. [pause:2s] More dialogue.

**Speaker2**:
[emotional:tag] Response.
```

### Step 5: Add Production Notes

```markdown
## Production Notes

**Key Facts**: [For AI_EXTRACT]
**Emotional Beats**: [For realistic delivery]
**Related Data**: [Snowflake tables/stages]
```

### Step 6: Save and Track

```bash
# Save script
vim audio_scripts/interviews/Your_Script.md

# Add to catalog
# Edit audio_metadata/audio_catalog.json
```

---

## Quality Control Checklist

### Before Generation

- [ ] Script complete with all sections
- [ ] Speaker names consistent throughout
- [ ] Emotional tags placed BEFORE emotional text
- [ ] Pauses strategically placed
- [ ] No typos (will be spoken!)
- [ ] Reads naturally when spoken aloud
- [ ] Character count estimated and within limits
- [ ] All speakers defined with voices selected
- [ ] Purpose and use case documented
- [ ] Related Snowflake data identified

### After Generation

- [ ] Audio downloaded and saved
- [ ] Filename matches script name
- [ ] Placed in correct directory
- [ ] Added to Snowflake stage
- [ ] AI_TRANSCRIBE tested successfully
- [ ] Speaker diarization works
- [ ] Key facts transcribed correctly
- [ ] AI_EXTRACT queries work
- [ ] Added to audio_catalog.json
- [ ] Script marked as "Generated" in metadata

---

## File Lifecycle

### 1. Script Creation

```
Status: Draft
Location: audio_scripts/[type]/scriptname.md
Ready: No
```

### 2. ElevenLabs Generation

```
Status: Generating
ElevenLabs: Project created, speakers added
Ready: Pending
```

### 3. Audio Downloaded

```
Status: Generated
Location: interviews/scriptname.mp3
Ready: For upload
```

### 4. Snowflake Deployment

```
Status: Deployed
Stage: @DATABASE.SCHEMA.STAGE/scriptname.mp3
Ready: For transcription
```

### 5. Transcription & Testing

```
Status: Tested
Transcription: Successful
AI_EXTRACT: Tested
Ready: For demo/production
```

---

## Integration with Snowflake

### Stage Organization

```sql
-- Organize by audio type
@DOCUMENT_AI.INTERVIEWS/
  ├── ceo_interviews/
  │   └── NRNT_CEO_Interview.mp3
  ├── debates/
  │   └── Platform_Debate.mp3
  └── testimonials/
      └── Customer_Story.mp3

-- Or flat structure
@DOCUMENT_AI.INTERVIEWS/
  ├── NRNT_CEO_Interview.mp3
  ├── Platform_Debate.mp3
  └── Customer_Story.mp3
```

### Metadata Table (Optional)

```sql
CREATE TABLE AUDIO_SCRIPTS_METADATA (
    AUDIO_ID VARCHAR,
    TITLE VARCHAR,
    TYPE VARCHAR,  -- Interview, News, Debate, etc.
    SCRIPT_PATH VARCHAR,
    AUDIO_FILE VARCHAR,
    DURATION_MINUTES FLOAT,
    SPEAKERS NUMBER,
    SPEAKER_NAMES VARIANT,  -- JSON array
    CREATED_DATE DATE,
    GENERATOR VARCHAR,  -- ElevenLabs, Google TTS, etc.
    PURPOSE VARCHAR,
    EMOTIONAL_ARC VARCHAR,
    KEY_TOPICS VARIANT,  -- JSON array
    RELATED_TABLES VARIANT,  -- JSON array
    TRANSCRIBED BOOLEAN,
    TRANSCRIPTION_QUALITY VARCHAR,
    STAGE_PATH VARCHAR
);

-- Insert metadata
INSERT INTO AUDIO_SCRIPTS_METADATA
SELECT PARSE_JSON(metadata_json)
FROM audio_catalog_stage;
```

---

## Quick Reference

### Common Commands

```bash
# Create new script from template
cp audio_scripts/templates/TEMPLATE_Interview.md \
   audio_scripts/interviews/My_Interview.md

# Edit script
code audio_scripts/interviews/My_Interview.md

# Generate via ElevenLabs (web UI)
# Then save to:
mv ~/Downloads/audio.mp3 interviews/My_Interview.mp3

# List all scripts
find audio_scripts -name "*.md" -type f

# List all generated audio
find interviews -name "*.mp3" -type f
```

### Character Count

```bash
# Count characters in script (exclude markdown formatting)
grep -v "^#\|^-\|^\*\*\|^$" script.md | wc -m
```

### Verify Audio

```bash
# Check MP3 details
ffprobe -i interviews/file.mp3

# Expected: MP3, 44.1kHz, stereo, 128kbps
```

---

## Best Practices

### 1. Consistent Naming

**Scripts and audio should match**:
```
Script:  audio_scripts/interviews/NRNT_CEO.md
Audio:   interviews/NRNT_CEO.mp3
Stage:   @INTERVIEWS/NRNT_CEO.mp3
```

### 2. Detailed Metadata

**Always include**:
- Purpose (why this audio exists)
- Related Snowflake data
- Key facts (for AI_EXTRACT testing)
- Emotional arc (for AI_SENTIMENT testing)

### 3. Reusable Templates

**Create templates for common scenarios**:
- Post-mortem interviews (like NRNT)
- Product launches
- Crisis responses
- Competitive debates
- Customer feedback

### 4. Version Control

**Track changes**:
```markdown
## Change Log

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| 2024-10-31 | 1.0 | Initial script | BO |
| 2024-11-01 | 1.1 | Added narrator intro | BO |
| 2024-11-02 | 2.0 | Major rewrite - more emotion | BO |
```

### 5. Test Before Full Generation

**ElevenLabs workflow**:
1. Generate first 30 seconds only
2. Verify voices sound right
3. Check emotional tags work
4. Then generate full audio
5. Saves character count if you need to redo

---

## Examples of File Organization

### Example 1: Crisis Management Series

```
audio_scripts/crisis_management/
├── NRNT_CEO_Interview.md
├── Customer_Impact_Story.md
├── CFO_Resignation_Speech.md
└── Investigative_Report.md

interviews/crisis_management/
├── NRNT_CEO_Interview.mp3
├── Customer_Impact_Story.mp3
├── CFO_Resignation_Speech.mp3
└── Investigative_Report.mp3
```

### Example 2: Product Launch Series

```
audio_scripts/product_launches/
├── SNOW_Cortex_Announcement.md
├── Customer_First_Impressions.md
└── Analyst_Reactions.md

interviews/product_launches/
├── SNOW_Cortex_Announcement.mp3
├── Customer_First_Impressions.mp3
└── Analyst_Reactions.mp3
```

### Example 3: Quarterly Earnings Series

```
audio_scripts/earnings_calls/
├── Q1_FY2025_SNOW.md
├── Q2_FY2025_SNOW.md
├── Q3_FY2025_SNOW.md
└── Q4_FY2025_SNOW.md

interviews/earnings_calls/
├── Q1_FY2025_SNOW.mp3
├── Q2_FY2025_SNOW.mp3
├── Q3_FY2025_SNOW.mp3
└── Q4_FY2025_SNOW.mp3
```

---

## Summary: Complete Audio Script System

### File Structure

```
audio_scripts/           # Source scripts (.md)
  ├── interviews/
  ├── news_reports/
  ├── debates/
  ├── earnings_calls/
  └── templates/         # Reusable templates

interviews/              # Generated audio (.mp3)
  ├── (organized same as scripts)
  └── (or flat structure)

audio_metadata/          # Tracking
  └── audio_catalog.json
```

### Workflow

```
1. Copy template → Fill metadata → Write dialogue
2. Generate in ElevenLabs → Download MP3
3. Save to interviews/ → Upload to Snowflake
4. Test AI_TRANSCRIBE → Document in catalog
```

### Benefits

✅ **Organized**: Easy to find scripts and audio  
✅ **Reusable**: Templates for quick creation  
✅ **Trackable**: Catalog system for metadata  
✅ **Scalable**: Add new types easily  
✅ **Maintainable**: Clear naming and structure  
✅ **AI-Ready**: Designed for AI_TRANSCRIBE integration  

---

## Current Implementation

**Existing Files**:
- Script: `NRNT_Interview_Audio_Script.md` (current location: dataops/event/)
- Audio: `ElevenLabs_Audio_Interview_The_Fall_of....mp3` (interviews/)

**Next Steps for Organization**:

```bash
# Create structure
mkdir -p audio_scripts/{interviews,news_reports,debates,earnings_calls,templates}
mkdir -p audio_metadata

# Move existing script
mv NRNT_Interview_Audio_Script.md \
   audio_scripts/interviews/NRNT_CEO_Interview.md

# Create catalog
echo '{"audio_files": []}' > audio_metadata/audio_catalog.json
```

**Then add NRNT interview metadata to catalog**

---

This structure scales from 1 audio file to 100+, maintains organization, and integrates seamlessly with Snowflake AI_TRANSCRIBE workflows!

