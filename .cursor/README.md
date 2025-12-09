# Cursor Rules Organization

This folder contains organized rule files for the FSI Cortex Assistant project.

## Structure

```
.cursor/
├── README.md (this file)
└── rules/
    ├── company-narratives.md  - Detailed info on all 8 core companies
    ├── timeline.md            - Critical dates and event sequence
    ├── data-files.md          - Data file locations and structure
    └── content-guidelines.md  - Rules for maintaining consistency
```

## Main Rules File

The main `.cursorrules` file in the project root references these detailed rule files.

## Adding New Rules

To add new rules:

1. Create a new `.md` file in `.cursor/rules/`
2. Update `.cursorrules` to reference the new file
3. Keep rules focused and organized by topic

## Current Rule Categories

- **Company Narratives** - Core company stories, relationships, and positioning
- **Timeline** - Critical dates and event sequence
- **Data Files** - Location and structure of datasets
- **Content Guidelines** - Rules for generating consistent content

---

This organization allows for:
- ✅ Better organization of rules
- ✅ Easier updates to specific categories
- ✅ Main `.cursorrules` stays concise
- ✅ Detailed context available in separate files

