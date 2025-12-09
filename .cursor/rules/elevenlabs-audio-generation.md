# ElevenLabs Audio Generation for AI_TRANSCRIBE

## Overview

This guide documents the process of creating multi-speaker audio interviews using ElevenLabs for use with Snowflake's `AI_TRANSCRIBE` function. Based on the NRNT CEO interview creation.

---

## Why ElevenLabs?

**Purpose**: Generate realistic multi-speaker audio for AI_TRANSCRIBE demonstrations

**Benefits**:
- ✅ Multiple distinct AI voices (speaker diarization)
- ✅ Emotional control (sad, happy, angry, etc.)
- ✅ Natural pauses and pacing
- ✅ Professional broadcast quality
- ✅ Free tier available (10,000 characters/month)
- ✅ Export as MP3 (ready for Snowflake stages)

**Use Case**: Create realistic interview/conversation audio without hiring voice actors

---

## Quick Start Process

### 1. Sign Up (1 minute)

```
1. Visit: https://elevenlabs.io
2. Click "Get Started Free"
3. Sign up with email or Google
4. Verify email
5. Free tier: 10,000 characters/month
```

### 2. Choose Method

**Projects** (RECOMMENDED for multi-speaker):
- Best for conversations/interviews
- Easy speaker management
- Built-in speaker diarization
- Visual speaker assignment

**Speech Synthesis** (Simple but limited):
- One voice at a time
- Manual merging required
- Not recommended for conversations

### 3. Create Project (2 minutes)

```
1. Left sidebar → "Projects"
2. Click "+ Create Project"
3. Name: "Your Interview Name"
4. Click "Create"
```

### 4. Add Speakers (2 minutes per speaker)

**For each speaker**:

```
1. Click "+ Add Speaker"
2. Name: Speaker identifier (e.g., "Interviewer", "Dr Sterling", "Narrator")
3. Voice: Browse library and select
4. (Optional) Adjust settings:
   - Stability: 0.5-0.75 (higher = more consistent)
   - Similarity: 0.7-0.8
   - Style: 0.3-0.6 (higher = more emotional range)
5. Click "Add"
```

**Repeat for all speakers** (3 speakers for NRNT interview)

---

## Voice Selection Guide

### Professional Interviewer/Journalist

**Female Options**:
- **Rachel** - Professional, clear, American
- **Serena** - Authoritative, broadcast journalist
- **Bella** - Warm but professional

**Male Options**:
- **Josh** - Mature, professional
- **Sam** - Clear, neutral tone

**Recommended**: Rachel or Serena for interviewer

### Emotional/Defeated Character (CEO)

**Male Options**:
- **Adam** - Versatile, can sound tired/defeated
- **Antoni** - Good emotional range
- **Callum** - Can sound regretful

**Settings for defeated tone**:
- Stability: 0.4-0.5 (allows variation)
- Style: 0.5-0.7 (more emotional)

### News Narrator/Announcer

**Options**:
- **Serena** - Authoritative broadcast
- **Bella** - Professional news anchor
- **Josh** - Serious male narrator

---

## Writing Dialogue for ElevenLabs

### Key Principle: Tags Are Instructions

**CRITICAL**: `[square bracket tags]` are INSTRUCTIONS to ElevenLabs, NOT spoken text!

```
Bad: The AI will say "pause three s hello"
Good: The AI will pause 3 seconds, then say "hello"
```

### Tag Format

```
Speaker Name:
Actual spoken text here [pause:2s] more spoken text [emotional:sad] even more text.
```

**Tags are NOT spoken aloud** - they control HOW the text is delivered.

### Common Tags

**Pauses**:
```
[pause:1s]  - 1 second silence
[pause:2s]  - 2 seconds (good for thought)
[pause:3s]  - 3 seconds (dramatic)
[pause:5s]  - 5 seconds (very dramatic, scene transitions)
```

**Emotions**:
```
[emotional:sad]      - Regretful, remorseful tone
[emotional:happy]    - Upbeat, positive
[emotional:angry]    - Frustrated, defensive
[emotional:fearful]  - Anxious, worried
[emotional:neutral]  - Back to neutral
```

**Speed**:
```
[speed:0.8]  - Slower (thoughtful, careful)
[speed:1.2]  - Faster (excited, nervous)
[speed:1.0]  - Normal speed
```

**Important**: Not all tags work with all voices. Test first!

---

## Dialogue Format Template

### Basic Format

```
Speaker1:
First thing they say. [pause:1s] Second thing they say.

Speaker2:
Their response here. [emotional:sad] This part sounds sad.

Speaker1:
Reply to that. [pause:2s] After a thoughtful pause.
```

### Advanced Format (NRNT Example)

```
Narrator:
[speed:0.95] From market darling to complete collapse in sixty-two days. 
[pause:2s]

Neuro-Nectar Corporation: A three-point-seven billion dollar startup 
that promised to revolutionize human intelligence through AI-powered ice cream.

Interviewer:
Dr. Sterling, thank you for speaking with us. [pause:1s] How are you doing?

Dr Sterling:
[emotional:sad] [pause:2s] I've been better, Sarah. [pause:1s] 
It's been... [pause:1s] difficult.
```

### Multi-Paragraph Dialogue

Each speaker can have multiple paragraphs - separate with blank lines:

```
Dr Sterling:
[emotional:sad] I take full responsibility. [pause:2s]

I should have listened to warnings about unit economics. [pause:1s] 
My CFO told me... [pause:2s] repeatedly... that we were losing money 
on every customer.

[pause:3s] I didn't want to hear it. [emotional:angry] I was convinced 
the science would speak for itself.
```

---

## Step-by-Step: Creating the NRNT Interview

### Step 1: Create Project
```
Projects → + Create Project
Name: "NRNT CEO Interview"
```

### Step 2: Add 3 Speakers

```
Speaker 1:
  Name: Narrator
  Voice: Serena (professional broadcast)
  
Speaker 2:
  Name: Interviewer
  Voice: Rachel (journalist)
  
Speaker 3:
  Name: Dr Sterling
  Voice: Adam (defeated CEO)
  Settings: Stability 0.5, Style 0.6
```

### Step 3: Copy Dialogue

**From**: `NRNT_Interview_Audio_Script.md`

**Format**: Already prepared with speaker names and tags

**Copy sections**:
1. COLD OPEN - News Headlines (Narrator)
2. Introduction (Interviewer)
3. Full conversation (Interviewer ↔ Dr Sterling)

### Step 4: Generate

```
1. Click "Generate" button
2. Wait 30-60 seconds (processes all speakers)
3. Listen to preview
4. Adjust if needed:
   - Change emotional tags
   - Adjust pause lengths
   - Modify speaker settings
5. Click "Download" → MP3 format
```

### Step 5: Deploy to Snowflake

```
1. Save as: interviews/ElevenLabs_Audio_Interview_The_Fall_of....mp3
2. Add to stage in deploy_documentai.template.sql:

CREATE STAGE INTERVIEWS ...;
PUT file:///.../interviews/*.mp3 @INTERVIEWS/;
```

---

## Best Practices for Interview Audio

### 1. Speaker Naming Convention

**Good**:
```
Narrator:      # Clear role
Interviewer:   # Clear role
Dr Sterling:   # Character name
```

**Avoid**:
```
Speaker1:      # Unclear who this is
Person:        # Too generic
S1:            # Confusing
```

### 2. Pause Placement

**Strategic pauses**:
```
- After difficult questions: [pause:2s]
- Before emotional responses: [pause:2s]
- During difficult admissions: [pause:1s]
- Between topics/sections: [pause:3s]
- Scene transitions: [pause:5s]
```

**Example**:
```
Interviewer:
Why didn't you pull the product when the first complaints came in? [pause:2s]

Dr Sterling:
[pause:3s] [emotional:sad] That's... that's the question that haunts me.
```

### 3. Emotional Tags Placement

**Place before the emotional text**:
```
Good: [emotional:sad] I've failed everyone.
Bad:  I've failed everyone. [emotional:sad]  (tag too late)
```

**Reset to neutral after emotional moments**:
```
Dr Sterling:
[emotional:sad] I destroyed lives. [pause:2s] 
[emotional:neutral] Looking back now, the warning signs were everywhere.
```

### 4. Natural Conversation Flow

**Include**:
- Interruptions (mid-sentence pauses)
- Hesitations ("I... I don't know")
- Filler words occasionally ("um", "ah")
- Sentence fragments (for realism)

**Example**:
```
Dr Sterling:
I thought... [pause:1s] I believed that... [pause:2s] 
[emotional:sad] I was wrong.
```

### 5. Narrator for Context

**Use narrator for**:
- Scene setting
- Transitions
- Providing context
- News-style introductions

**Separate narrator clearly**:
```
Narrator:
[speed:0.95] From market darling to complete collapse in sixty-two days.
[pause:3s]

Interviewer:
Dr. Sterling, thank you for joining us.
```

---

## Common Issues & Solutions

### Issue: Tags Appear in Audio

**Problem**: ElevenLabs is saying "pause two s" aloud

**Fix**: 
- Check tag format: Must be `[tag:value]`
- No spaces: `[pause: 2s]` is wrong
- Correct: `[pause:2s]`

### Issue: Wrong Speaker

**Problem**: Interviewer voice for CEO response

**Fix**:
- Check speaker name exactly matches
- No extra spaces: "Interviewer: " vs "Interviewer:"
- Case-sensitive on some versions

### Issue: Emotions Don't Work

**Problem**: `[emotional:sad]` has no effect

**Reasons**:
- Not all voices support all emotions
- Try different voice (Adam, Antoni work well)
- Increase Style Exaggeration in settings (0.5-0.7)

### Issue: Pauses Too Short

**Problem**: `[pause:2s]` feels shorter

**Fix**:
- ElevenLabs sometimes compresses pauses
- Use longer: `[pause:3s]` if you want 2 seconds
- Or add multiple: `[pause:1s] [pause:1s]`

### Issue: Export Quality

**Problem**: MP3 sounds compressed

**Fix**:
- Use highest quality setting in export
- Pro tier has better quality
- For free tier, quality is usually sufficient for AI_TRANSCRIBE

---

## ElevenLabs Projects Features

### Speaker Management

**View**: See all speakers in left panel  
**Edit**: Click speaker to adjust voice/settings  
**Preview**: Test individual speaker before full generation  
**Delete**: Remove speakers you don't need  

### Dialogue Editor

**Format**: Plain text with speaker names  
**Syntax highlighting**: Shows speaker names  
**Line breaks**: Use blank lines between speakers  
**Preview sections**: Generate small parts first to test  

### Generation Options

**Quality**: 
- Standard (free tier)
- High (pro tier)

**Format**: 
- MP3 (recommended for Snowflake)
- WAV (higher quality, larger file)

**Processing**: 
- Typical: 30-60 seconds for 5-minute audio
- Long scripts: 2-3 minutes

---

## AI_TRANSCRIBE Integration

### After Generating Audio

**1. Download from ElevenLabs**:
```
Format: MP3
Quality: Highest available
Filename: descriptive_name.mp3
```

**2. Place in Project**:
```
dataops/event/interviews/
├── ElevenLabs_Audio_Interview_The_Fall_of....mp3
└── (other interview files)
```

**3. Upload to Snowflake Stage**:
```sql
CREATE STAGE INTERVIEWS
  DIRECTORY = (enable = true)
  ENCRYPTION = (type = 'snowflake_sse');

PUT file:///.../interviews/*.mp3 @INTERVIEWS/;
```

**4. Transcribe with AI_TRANSCRIBE**:
```sql
SELECT 
    SNOWFLAKE.CORTEX.AI_TRANSCRIBE(
        TO_FILE('@DOCUMENT_AI.INTERVIEWS/your_audio.mp3'),
        {'LANGUAGE': 'en', 'INCLUDE_TIMESTAMPS': TRUE}
    ) AS transcript
FROM DIRECTORY(@DOCUMENT_AI.INTERVIEWS);
```

**5. Analyze Transcript**:
```sql
WITH interview AS (
    SELECT AI_TRANSCRIBE(TO_FILE('@INTERVIEWS/audio.mp3')) AS transcript
)
SELECT 
    transcript,
    SNOWFLAKE.CORTEX.AI_SENTIMENT(transcript) AS sentiment,
    SNOWFLAKE.CORTEX.AI_EXTRACT(
        transcript,
        'What are the key lessons mentioned?'
    ) AS lessons,
    SNOWFLAKE.CORTEX.SUMMARIZE(transcript) AS summary
FROM interview;
```

---

## NRNT Interview Specifications

### Created Audio Details

**File**: `ElevenLabs_Audio_Interview_The_Fall_of....mp3`  
**Duration**: ~5-6 minutes  
**Speakers**: 3 voices
- Narrator (Female - Serena/Bella): News intro
- Interviewer (Female - Rachel): Sarah Jenkins, journalist
- Dr Sterling (Male - Adam): Former NRNT CEO

**Content Structure**:
1. **Cold Open** (45s): Narrator sets up story
2. **Introduction** (30s): Interviewer welcomes guest
3. **The Rise** (1m): Discussion of early success
4. **Warning Signs** (1m): When problems emerged
5. **The Collapse** (1.5m): How it fell apart
6. **Lessons Learned** (1.5m): Reflections and takeaways
7. **Closing** (30s): Final thoughts

**Emotional Arc**:
- Narrator: Professional, neutral (broadcast news)
- Interviewer: Empathetic but probing
- Dr Sterling: Progresses from defeated → defensive → remorseful → resigned

### Key Dialogue Moments

**Opening shock**:
```
Narrator:
From market darling to complete collapse in sixty-two days. [pause:2s]
```

**Emotional admission**:
```
Dr Sterling:
[emotional:sad] [pause:2s] I've failed thousands of people. [pause:3s]
The Chinese mother whose son bought our product for her memory issues... 
[pause:2s] she's in the ICU because of me.
```

**Defensive moment**:
```
Dr Sterling:
[emotional:angry] We had the science! [pause:1s] Our clinical trials 
showed twenty-eight percent cognitive improvement.
```

**Resigned acceptance**:
```
Dr Sterling:
[emotional:sad] [pause:2s] I destroyed... [pause:1s] 
I destroyed everything I built. And worse, I hurt people.
```

---

## Template for Future Interviews

### Script Structure

```markdown
# Interview Title

**Speakers**: [List all speakers]
**Duration Target**: X minutes
**Format**: Interview/Conversation/Debate

---

## Voice Specifications

### Speaker 1: [NAME] ([ROLE])

**Characteristics**:
- Age, gender
- Emotional state
- Speaking style
- Accent/pace

**ElevenLabs Voice**: Recommended voice name

---

## Complete Dialogue

### [00:00-00:XX] Section 1 Name

**[SPEAKER]**: [emotional tag if needed]

Actual dialogue here. [pause:2s] More dialogue.

**[SPEAKER2]**:

Response dialogue. [emotional:tag] Emotional part.
```

### Minimal Example

```
Interviewer:
Thank you for joining us today. [pause:1s] How are you feeling?

Guest:
[emotional:sad] It's been difficult. [pause:2s] 
Very difficult.

Interviewer:
Can you tell us what happened?

Guest:
[pause:3s] [emotional:sad] Where do I even begin? [pause:1s]
Everything fell apart so quickly.
```

---

## Quality Checklist

Before generating final audio:

- [ ] All speakers added and tested
- [ ] Speaker names match exactly in dialogue
- [ ] Emotional tags placed BEFORE emotional text
- [ ] Pauses strategically placed for realism
- [ ] No typos (they'll be spoken!)
- [ ] Dialogue flows naturally when read aloud
- [ ] Total length matches target (character count ≈ 150-200 chars/min speaking)
- [ ] Scene transitions marked with longer pauses
- [ ] Tags use correct syntax: `[tag:value]` not `[tag: value]`

---

## Advanced Techniques

### Creating Emotional Arcs

**Progression example** (defeated → defensive → acceptance):

```
Dr Sterling:
[emotional:sad] I failed. [pause:2s]

[emotional:neutral] But I want to be clear - we had the science. 
[emotional:angry] The clinical trials showed results!

[pause:3s] [emotional:sad] But that doesn't matter now. [pause:1s]
People got hurt. That's on me.
```

### Realistic Hesitations

**Use pauses mid-sentence**:

```
I thought... [pause:1s] I believed that... [pause:2s] 
[emotional:sad] I was wrong.
```

**Use sentence fragments**:

```
The warnings... the return rates... [pause:2s] I ignored them all.
```

### Scene Transitions

**Between major sections**:

```
[pause:5s]

*[Scene transition implied by long pause]*

Interviewer:
Let's talk about the collapse itself. [pause:1s] October twenty-fourth...
```

### Narrator for Context

**Use narrator to**:
- Set up scenes
- Provide background
- Create documentary feel
- Transition between topics

```
Narrator:
[speed:0.95] Three weeks after the FDA warning, Neuro-Nectar stock 
had lost seventy percent of its value. [pause:2s]

By November first, the company filed for bankruptcy.
[pause:3s]

Interviewer:
Dr. Sterling, walk us through that day. November first.
```

---

## Export and Deployment

### ElevenLabs Export

**Steps**:
1. Generate full audio
2. Click **"Download"** button
3. Select **MP3** format
4. Save with descriptive name

**Naming convention**:
```
Good: CEO_Interview_Post_Collapse.mp3
Good: NRNT_Investigation_Interview.mp3
Bad:  audio.mp3
Bad:  file1.mp3
```

### File Placement

```bash
# Project structure
dataops/event/
└── interviews/
    ├── ElevenLabs_Audio_Interview_The_Fall_of....mp3
    └── (other interviews)
```

### Snowflake Stage Deployment

**In deploy_documentai.template.sql**:

```sql
-- =====================================================
-- INTERVIEWS STAGE
-- =====================================================

CREATE OR REPLACE STAGE {{ env.EVENT_DATABASE }}.{{ env.DOCUMENT_AI_SCHEMA }}.INTERVIEWS
  DIRECTORY = (enable = true)
  ENCRYPTION = (type = 'snowflake_sse')
  COMMENT = 'Executive interviews and investigative journalism audio files';

-- Upload all MP3 files
PUT file:///{{ env.CI_PROJECT_DIR }}/dataops/event/interviews/*.mp3 
    @{{ env.EVENT_DATABASE }}.{{ env.DOCUMENT_AI_SCHEMA }}.INTERVIEWS/ 
    auto_compress = false 
    overwrite = true;

ALTER STAGE {{ env.EVENT_DATABASE }}.{{ env.DOCUMENT_AI_SCHEMA }}.INTERVIEWS REFRESH;
LIST @{{ env.EVENT_DATABASE }}.{{ env.DOCUMENT_AI_SCHEMA }}.INTERVIEWS;
```

---

## Usage Examples in Snowflake

### Basic Transcription

```sql
SELECT 
    RELATIVE_PATH,
    SNOWFLAKE.CORTEX.AI_TRANSCRIBE(
        TO_FILE('@DOCUMENT_AI.INTERVIEWS/' || RELATIVE_PATH)
    ) AS transcript
FROM DIRECTORY(@DOCUMENT_AI.INTERVIEWS);
```

### Transcription with Timestamps

```sql
SELECT 
    SNOWFLAKE.CORTEX.AI_TRANSCRIBE(
        TO_FILE('@DOCUMENT_AI.INTERVIEWS/interview.mp3'),
        {'LANGUAGE': 'en', 'INCLUDE_TIMESTAMPS': TRUE}
    ) AS transcript_with_timestamps;
```

### Extract Insights from Transcript

```sql
WITH interview AS (
    SELECT AI_TRANSCRIBE(TO_FILE('@INTERVIEWS/ceo_interview.mp3')) AS text
)
SELECT 
    -- Extract specific information
    SNOWFLAKE.CORTEX.AI_EXTRACT(
        text,
        'What lessons does the CEO mention learning from the failure?'
    ) AS lessons,
    
    -- Get overall sentiment
    SNOWFLAKE.CORTEX.AI_SENTIMENT(text) AS sentiment,
    
    -- Summarize key points
    SNOWFLAKE.CORTEX.SUMMARIZE(text) AS summary,
    
    -- Classify interview tone
    SNOWFLAKE.CORTEX.AI_CLASSIFY(
        text,
        ['Apologetic', 'Defensive', 'Educational', 'Resigned']
    ) AS tone
FROM interview;
```

### Compare Interview vs Social Media Sentiment

```sql
-- CEO's sentiment in interview
WITH ceo_sentiment AS (
    SELECT 
        SNOWFLAKE.CORTEX.AI_SENTIMENT(
            AI_TRANSCRIBE(TO_FILE('@INTERVIEWS/ceo_interview.mp3'))
        ) AS ceo_sentiment
),
-- Public sentiment from social media
public_sentiment AS (
    SELECT AVG(SENTIMENT) AS public_sentiment
    FROM SOCIAL_MEDIA_NRNT
    WHERE TIMESTAMP >= '2024-11-01'
)
SELECT 
    ceo_sentiment,
    public_sentiment,
    (ceo_sentiment - public_sentiment) AS sentiment_gap
FROM ceo_sentiment, public_sentiment;
```

---

## Reusable Patterns

### Interview Template

**Format**: 3-speaker interview (narrator, interviewer, subject)

**Use for**:
- Post-mortem analysis (like NRNT)
- Product launch announcements
- Earnings call simulations
- Crisis management scenarios
- Investigative journalism pieces

**Adapt by**:
- Changing subject (CEO, analyst, customer, etc.)
- Adjusting emotional arc
- Modifying content focus
- Varying interview style (friendly vs confrontational)

### Debate Template

**Format**: 2-3 speakers with opposing views

```
Moderator:
Welcome to our debate. [pause:1s] Our topic today...

Speaker1:
[emotional:confident] I firmly believe that...

Speaker2:
[emotional:angry] That's completely wrong. [pause:1s] The data shows...
```

### News Report Template

**Format**: Single narrator with dramatic pacing

```
Narrator:
[speed:0.9] Breaking news. [pause:2s]

A major development in the financial sector. [pause:1s]

[speed:1.0] Sources close to the company report...
```

---

## Character Count Estimation

### Free Tier Limits

**ElevenLabs Free**: 10,000 characters/month

**Estimation**:
- 1 minute of speech ≈ 150-200 characters
- 5-minute interview ≈ 750-1,000 characters
- NRNT interview: ~3,500 characters

**You can generate**:
- ~2-3 full interviews per month (free tier)
- Or 50 minutes of total audio

### Counting Characters

**Before generating**:

```python
# Count your script
script = """Your full dialogue here..."""
print(f"Characters: {len(script)}")
print(f"Estimated minutes: {len(script) / 175}")
```

**Or use online counter**: paste dialogue, count characters

---

## Tips for AI_TRANSCRIBE Success

### 1. Audio Quality Matters

**Good**:
- ElevenLabs default quality (sufficient)
- Clear voice separation
- Distinct speakers (male/female, different tones)
- Minimal background noise

**Avoid**:
- Heavily compressed audio
- Similar-sounding voices (harder for diarization)
- Background music (interferes with transcription)

### 2. Speaker Diarization Works Best When

- ✅ Voices are clearly different (gender, accent, tone)
- ✅ Natural pauses between speakers
- ✅ One speaker at a time (no overlapping)
- ✅ Clear pronunciation

### 3. Content Structure

**Good for AI analysis**:
- Clear topic transitions
- Structured Q&A format
- Key phrases repeated
- Specific data points mentioned

**Example**:
```
Interviewer:
What was your biggest mistake?

Dr Sterling:
The biggest mistake was ignoring unit economics. [pause:1s]
We were losing forty-two dollars on every customer.
```
*(AI_EXTRACT can easily find "biggest mistake" and "unit economics")*

---

## Cost Optimization

### Maximize Free Tier

**10,000 chars/month strategies**:

1. **Write tight dialogue**: Remove unnecessary words
   ```
   Wordy: "Well, you know, I think that, um, the issue was..."
   Tight:  "The issue was..."
   ```

2. **Combine speakers**: Use narrator for both sides if testing
   ```
   Instead of 3 speakers, use 1-2 for drafts
   ```

3. **Generate sections**: Test small parts first
   ```
   Generate intro → verify → generate middle → verify → etc.
   ```

4. **Test voices separately**: Use Speech Synthesis for voice testing
   ```
   Find right voice with small samples
   Then create full project
   ```

### Pro Tier Benefits

**If upgrading** ($5-11/month):
- 100,000 characters
- Higher quality
- More voices
- Voice cloning
- Commercial license

---

## Success Metrics

### Good Audio for AI_TRANSCRIBE

**Check**:
- [ ] AI_TRANSCRIBE successfully extracts text
- [ ] Speaker attribution is mostly correct
- [ ] Timestamps are accurate
- [ ] Key phrases are transcribed correctly
- [ ] No major hallucinations in transcript
- [ ] Emotional tone preserved in text

**Example success**:
```
Input audio: "I failed [sad tone] everyone"
Transcript: "I failed everyone"
AI_SENTIMENT: 0.15 (correctly detected sadness)
```

### Multi-Modal Analysis Success

**Check**:
- [ ] Can extract specific facts from transcript
- [ ] Can compare with other data sources
- [ ] Can analyze sentiment progression
- [ ] Can classify interview sections
- [ ] Can aggregate with other narratives

---

## Quick Reference Commands

### ElevenLabs Workflow

```
1. Sign up: elevenlabs.io
2. Projects → Create New
3. Add Speakers (one per character)
4. Paste dialogue with tags
5. Generate → Download MP3
```

### Deployment Workflow

```bash
# 1. Save file
mv ~/Downloads/audio.mp3 dataops/event/interviews/

# 2. Update SQL (if not using wildcard)
# Edit deploy_documentai.template.sql

# 3. Deploy (will upload on next deployment)
# File will be uploaded via PUT command
```

### Testing Workflow

```sql
-- 1. List files
LIST @DOCUMENT_AI.INTERVIEWS;

-- 2. Transcribe
SELECT AI_TRANSCRIBE(TO_FILE('@INTERVIEWS/file.mp3'));

-- 3. Analyze
SELECT 
    AI_SENTIMENT(transcript),
    AI_EXTRACT(transcript, 'key question'),
    SUMMARIZE(transcript);
```

---

## Common Use Cases

### 1. Crisis Management Training

**Create interviews with**:
- Failed CEO explaining what went wrong
- Investigative journalist asking tough questions
- Customers sharing impact stories

**Use for**: Training AI to detect crisis signals, analyze post-mortems

### 2. Earnings Call Simulations

**Create calls with**:
- CEO presenting results
- CFO explaining financials
- Analysts asking questions

**Use for**: Testing AI_EXTRACT on financial data, sentiment analysis

### 3. Customer Testimonials

**Create reviews with**:
- Happy customers (early period)
- Concerned customers (middle)
- Angry customers (crisis)

**Use for**: Sentiment tracking, complaint analysis

### 4. Competitive Analysis

**Create debates with**:
- Two CEOs comparing products
- Analysts discussing market position
- Sales teams presenting advantages

**Use for**: AI_CLASSIFY positioning, AI_EXTRACT differentiators

---

## File Organization

### Recommended Structure

```
interviews/
├── crisis_management/
│   ├── nrnt_ceo_postmortem.mp3
│   └── customer_impact_story.mp3
├── earnings_calls/
│   ├── q1_fy2025_simulation.mp3
│   └── q2_fy2025_simulation.mp3
└── testimonials/
    ├── happy_customer.mp3
    └── complaint_customer.mp3
```

### Metadata File (Optional)

Create `interviews_metadata.json`:

```json
{
  "nrnt_ceo_postmortem.mp3": {
    "title": "The Fall of Neuro-Nectar",
    "speakers": 3,
    "duration_minutes": 5.5,
    "created_date": "2024-10-31",
    "generator": "ElevenLabs Projects",
    "purpose": "AI_TRANSCRIBE demonstration",
    "emotional_arc": "defeated → defensive → resigned",
    "key_topics": ["unit economics", "FDA warning", "lessons learned"]
  }
}
```

---

## Troubleshooting

### ElevenLabs Generation Issues

**Problem**: Audio sounds robotic

**Fix**:
- Increase Stability (0.6-0.8)
- Reduce Speed variations
- Choose more natural voice (Adam, Rachel work well)

**Problem**: Emotions don't come through

**Fix**:
- Increase Style Exaggeration (0.5-0.7)
- Add more emotional tags
- Choose voice with better emotional range (Antoni, Adam)
- Use descriptive text ("I failed" vs "That's unfortunate")

**Problem**: Pauses are wrong

**Fix**:
- Check tag syntax: `[pause:2s]` not `[pause: 2s]`
- Increase duration: `[pause:3s]` if you want 2s
- Place pause BEFORE the delayed text

### Snowflake Integration Issues

**Problem**: AI_TRANSCRIBE fails

**Fix**:
```sql
-- Check file exists
LIST @INTERVIEWS;

-- Check file is accessible
SELECT GET_PRESIGNED_URL(@INTERVIEWS, 'file.mp3', 3600);

-- Try with explicit options
SELECT AI_TRANSCRIBE(
    TO_FILE('@INTERVIEWS/file.mp3'),
    {'LANGUAGE': 'en'}  -- Specify language explicitly
);
```

**Problem**: Speaker attribution wrong

**Fix**:
- Use more distinct voices (male/female)
- Add longer pauses between speakers
- Ensure one speaker at a time
- Consider re-generating with different voices

**Problem**: Transcript has errors

**Fix**:
- Check for unusual words (ElevenLabs might mispronounce)
- Simplify complex technical terms
- Use common pronunciations
- Add phonetic spelling if needed: "N-R-N-T" vs "Neuro-Nectar"

---

## Resources

### ElevenLabs

- **Website**: https://elevenlabs.io
- **Pricing**: https://elevenlabs.io/pricing
- **Voice Library**: Browse in app after signup
- **Projects Guide**: In-app help section

### Snowflake

- **AI_TRANSCRIBE Docs**: https://docs.snowflake.com/en/sql-reference/functions/ai_transcribe
- **Cortex AISQL**: https://docs.snowflake.com/en/user-guide/snowflake-cortex/aisql

### Project Files

- **Script Template**: `NRNT_Interview_Audio_Script.md` (complete example)
- **Generated Audio**: `interviews/ElevenLabs_Audio_Interview_The_Fall_of....mp3`
- **Deployment SQL**: `deploy_documentai.template.sql` (INTERVIEWS stage)

---

## Summary: ElevenLabs → AI_TRANSCRIBE Workflow

```
1. SCRIPT: Write dialogue with speaker names and tags
   ↓
2. ELEVENLABS: Create project, add speakers, paste dialogue
   ↓
3. GENERATE: ElevenLabs creates multi-speaker MP3
   ↓
4. DOWNLOAD: Save MP3 file
   ↓
5. DEPLOY: Upload to Snowflake stage
   ↓
6. TRANSCRIBE: Use AI_TRANSCRIBE to extract text
   ↓
7. ANALYZE: Use AI_EXTRACT, AI_SENTIMENT, AI_CLASSIFY
   ↓
8. INSIGHTS: Multi-modal analysis (audio + text + social media + documents)
```

**Total time**: 15-30 minutes per interview

**Cost**: Free (10k chars/month) or $5-11/month for more

**Result**: Professional multi-speaker audio ready for Snowflake AI analysis!

