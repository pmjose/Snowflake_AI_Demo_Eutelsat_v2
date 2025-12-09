# Snowflake Notebooks - Terminology Guide

## Important: Always Use "Snowflake Notebooks"

**CORRECT**: Snowflake notebooks  
**INCORRECT**: Jupyter notebooks, Jupyter Notebook, JupyterLab

---

## What Are Snowflake Notebooks?

Snowflake Notebooks are **native notebook environments** built directly into Snowflake. They are NOT Jupyter notebooks running outside Snowflake.

### Key Differences

| Feature | Snowflake Notebooks | Jupyter Notebooks |
|---------|---------------------|-------------------|
| **Location** | Inside Snowflake UI | External server/local |
| **Authentication** | Snowflake SSO | Separate auth |
| **Data Access** | Direct (no connection setup) | Requires connectors |
| **Compute** | Snowflake warehouses | Separate compute |
| **Sharing** | Native Snowflake sharing | Manual export/import |
| **Version Control** | Snowflake-managed | Git/manual |
| **Packages** | Pre-installed Snowpark ML | Manual pip install |

---

## Correct Terminology in Documentation

### ✅ DO Say:

- "Snowflake notebooks"
- "The 4 Snowflake notebooks contain..."
- "Open the Snowflake notebook in the UI"
- "Navigate to AI & ML Studio → Notebooks"
- "Snowflake notebook environment"
- "Native Snowflake notebooks"

### ❌ DON'T Say:

- "Jupyter notebooks"
- "JupyterLab"
- "Jupyter Notebook interface"
- "Upload to Jupyter"
- "Jupyter kernel"

### ⚠️ Exception:

Only mention Jupyter when:
- Explaining migration from Jupyter to Snowflake
- Comparing technologies
- Historical context (e.g., "Previously used Jupyter, now using Snowflake notebooks")

---

## Navigation Paths

### How to Access Snowflake Notebooks

**In Snowflake UI**:
1. Click **AI & ML Studio** (left navigation)
2. Click **Notebooks**
3. Select a notebook to open

**Or**:
1. Click **Projects** → **Notebooks**
2. Browse available notebooks
3. Click to open

### Notebook Names in This Project

1. **1_EXTRACT_DATA_FROM_DOCUMENTS** - Document AI extraction
2. **2_AUDIO_TRANSCRIPTION_SENTIMENT** - Audio transcription and sentiment analysis
3. **3_ML_MODEL_TRAINING** - ML model training and evaluation
4. **4_CREATE_SEARCH_SERVICES** - Search service creation

---

## Technical Details

### What Snowflake Notebooks Support

**Languages**:
- Python (Snowpark Python)
- SQL
- Markdown

**Key Libraries**:
- `snowflake.snowpark` - Pre-installed
- `snowflake.ml` - Pre-installed
- `snowflake.cortex` - Pre-installed
- Standard ML libraries (pandas, numpy, scikit-learn)

**Cortex AI Access**:
```python
from snowflake.cortex import complete, summarize, sentiment, translate

# Direct access to AISQL functions
result = complete("claude-3-5-sonnet", "What is AI?")
```

**Snowpark Integration**:
```python
from snowflake.snowpark import Session
from snowflake.snowpark.functions import col

# Session is automatically created in Snowflake notebooks
df = session.table("MY_TABLE")
df = df.select(col("COLUMN_NAME"))
```

---

## File Formats

### Snowflake Notebook Files

**Format**: `.ipynb` (same as Jupyter, but deployed differently)

**Deployment**:
```yaml
# In snowflake.yml
notebooks:
  - name: my_notebook
    src: notebooks/my_notebook.ipynb
    stage: notebook_stage
```

**NOT**:
```bash
jupyter notebook  # Wrong - don't run locally
```

**Instead**:
- Develop in Snowflake UI
- Or develop locally and deploy via SnowCLI
- Use `snow notebook` commands

---

## Common Use Cases in This Project

### 1. Document AI Processing

**Notebook**: `1_EXTRACT_DATA_FROM_DOCUMENTS.ipynb`

```python
# Run inside Snowflake notebook (not Jupyter)
from snowflake.cortex import ai_extract

# Direct access to stages
docs = session.sql("LIST @DOCUMENT_AI.ANNUAL_REPORTS")

# Process documents
results = []
for doc in docs:
    extracted = ai_extract(
        f"@DOCUMENT_AI.ANNUAL_REPORTS/{doc.name}",
        "Extract revenue and growth metrics"
    )
    results.append(extracted)
```

### 2. Audio Transcription

**Notebook**: `2_AUDIO_TRANSCRIPTION_SENTIMENT.ipynb`

```python
# AI_TRANSCRIBE available natively
from snowflake.cortex import ai_transcribe

# Transcribe audio from stage
transcript = ai_transcribe(
    "@DOCUMENT_AI.INTERVIEWS/interview.mp3",
    {"LANGUAGE": "en"}
)
```

### 3. ML Model Training

**Notebook**: `3_ML_MODEL_TRAINING.ipynb`

```python
from snowflake.ml.modeling.linear_model import LogisticRegression

# Train on Snowflake data
model = LogisticRegression()
model.fit(train_df)
```

### 4. Search Service Creation

**Notebook**: `4_CREATE_SEARCH_SERVICES.ipynb`

```python
# Create Cortex Search service
session.sql("""
    CREATE CORTEX SEARCH SERVICE my_search
    ON text_column
    WAREHOUSE = my_wh
    TARGET_LAG = '1 hour'
    AS SELECT * FROM my_table
""").collect()
```

---

## Documentation Guidelines

### In README Files

```markdown
# ✅ CORRECT
This project includes 4 Snowflake notebooks for data processing.

Navigate to AI & ML Studio → Notebooks to access them.

# ❌ INCORRECT
This project includes 4 Jupyter notebooks for data processing.

Run `jupyter notebook` to access them.
```

### In Code Comments

```python
# ✅ CORRECT
"""
This script is designed to run in a Snowflake notebook.
Access via AI & ML Studio → Notebooks in the Snowflake UI.
"""

# ❌ INCORRECT
"""
This script is designed to run in a Jupyter notebook.
Run `jupyter notebook` to start.
"""
```

### In User Instructions

```markdown
# ✅ CORRECT
**Step 1**: Navigate to AI & ML Studio → Notebooks
**Step 2**: Click on the notebook name to open it
**Step 3**: Click "Run All" to execute

# ❌ INCORRECT
**Step 1**: Start Jupyter server
**Step 2**: Navigate to localhost:8888
**Step 3**: Open .ipynb file
```

---

## Migration from Jupyter

### If You Have Existing Jupyter Notebooks

**To deploy to Snowflake**:

1. **Clean up imports**:
   ```python
   # Remove
   import snowflake.connector
   
   # Add (if needed)
   from snowflake.snowpark import Session
   # Note: Session already exists as 'session' in Snowflake notebooks
   ```

2. **Remove connection code**:
   ```python
   # DELETE THIS (not needed in Snowflake notebooks)
   conn = snowflake.connector.connect(
       user='...',
       password='...',
       account='...'
   )
   ```

3. **Use Snowpark instead of connectors**:
   ```python
   # OLD (Jupyter with connector)
   cursor.execute("SELECT * FROM table")
   df = cursor.fetch_pandas_all()
   
   # NEW (Snowflake notebook)
   df = session.table("table").to_pandas()
   ```

4. **Deploy via SnowCLI**:
   ```bash
   snow notebook deploy -c my_connection
   ```

---

## Best Practices

### 1. Leverage Native Integration

**Good** (uses Snowflake notebook features):
```python
# Session is automatically available
df = session.sql("SELECT * FROM MY_TABLE")

# Cortex functions available
from snowflake.cortex import ai_complete
result = ai_complete("claude-3-5-sonnet", prompt)
```

**Avoid** (unnecessary in Snowflake notebooks):
```python
# Don't create new sessions
session = Session.builder.configs(connection_params).create()
```

### 2. Use Native File Access

**Good**:
```python
# Access stages directly
session.file.get("@MY_STAGE/file.csv", "/tmp/")
```

**Avoid**:
```python
# Don't download locally first
import requests
r = requests.get("http://somewhere.com/file.csv")
```

### 3. Take Advantage of Compute

**Good**:
```python
# Process in Snowflake (distributed)
df = session.table("LARGE_TABLE")
result = df.filter(col("VALUE") > 100).group_by("CATEGORY").count()
```

**Avoid**:
```python
# Don't pull to pandas for basic operations
df_pandas = session.table("LARGE_TABLE").to_pandas()
filtered = df_pandas[df_pandas['VALUE'] > 100]  # Slow for large data
```

---

## Quick Reference

### Opening Snowflake Notebooks

**UI Path**: AI & ML Studio → Notebooks

**Features**:
- ✅ Auto-save
- ✅ Version history
- ✅ Sharing (via Snowflake permissions)
- ✅ Execution history
- ✅ Native Snowpark/Cortex integration

### Running Cells

- **Single cell**: Click ▶️ or `Shift+Enter`
- **All cells**: Click "Run All" button
- **Stop execution**: Click ⏹️ stop button

### Supported Cell Types

1. **Code** (Python/SQL)
2. **Markdown** (documentation)
3. **SQL** (direct SQL execution)

---

## Always Remember

🎯 **This project uses Snowflake notebooks exclusively**

✅ All `.ipynb` files are deployed to Snowflake  
✅ All execution happens inside Snowflake  
✅ No external Jupyter server needed  
✅ No connection configuration needed  
✅ Direct access to all Snowflake data and features  

**When documenting or discussing**: Always say **"Snowflake notebooks"**, never "Jupyter notebooks"

---

## References

- **Snowflake Notebooks Documentation**: https://docs.snowflake.com/en/user-guide/ui-snowsight/notebooks
- **Snowpark Python**: https://docs.snowflake.com/en/developer-guide/snowpark/python/index
- **Cortex in Notebooks**: https://docs.snowflake.com/en/user-guide/snowflake-cortex/overview
- **This Project**: `dataops/event/notebooks/` directory

