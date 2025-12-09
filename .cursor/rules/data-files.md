# Data Files Location

## Primary Data Sources

- **Company Stories**: `DATA/companies.csv` (ticker, name, category, description, **story**)
- **Earnings Calls**: `DATA/unique_transcripts.csv` (92 companies, JSON transcripts)
- **Stock Prices**: `DATA/fsi_data.csv` (52,695 records, 30 companies, 2018-2025)
- **Analyst Reports**: `document_ai/svg_files/*.html` (36 HTML reports)
- **Documentation**: `DATA/COMPANIES_STORIES_SUMMARY.md`, `DATA_SUMMARY.md`

## Reading Company Stories

To get detailed company narratives:

```python
import csv
with open('DATA/companies.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        if row['category'] == 'core':
            print(f"{row['ticker']}: {row['story']}")
```

The 'story' field contains 500-700 character narratives with:
- Key financial metrics
- Earnings call dates and highlights
- Competitive positioning
- Partnership relationships
- Stock price movements
- CEO quotes and messaging

