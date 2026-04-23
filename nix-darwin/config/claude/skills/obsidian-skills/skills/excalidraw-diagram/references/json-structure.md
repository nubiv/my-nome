# JSON Structure Reference

## JSON Wrappers by Mode

### Obsidian Mode
```json
{
  "type": "excalidraw",
  "version": 2,
  "source": "https://github.com/zsviczian/obsidian-excalidraw-plugin",
  "elements": [...],
  "appState": { "gridSize": null, "viewBackgroundColor": "#ffffff" },
  "files": {}
}
```

### Standard / Animated Mode
```json
{
  "type": "excalidraw",
  "version": 2,
  "source": "https://excalidraw.com",
  "elements": [...],
  "appState": { "gridSize": null, "viewBackgroundColor": "#ffffff" },
  "files": {}
}
```

## Obsidian File Wrapper (`.md`)

**Output exactly this structure — do not modify:**

```markdown
---
excalidraw-plugin: parsed
tags: [excalidraw]
---
==⚠  Switch to EXCALIDRAW VIEW in the MORE OPTIONS menu of this document. ⚠== You can decompress Drawing data with the command palette: 'Decompress current Excalidraw file'. For more info check in plugin settings under 'Saving'

# Excalidraw Data

## Text Elements
%%
## Drawing
\`\`\`json
{full JSON data}
\`\`\`
%%
```

**Requirements:**
- Frontmatter must include `tags: [excalidraw]`
- Warning message must be complete and exact
- JSON must be wrapped by `%%` markers
- `## Text Elements` section must be **left empty** — the plugin auto-populates it from JSON
- Do not use any frontmatter settings other than `excalidraw-plugin: parsed`

## File Naming

| Mode | Format | Example |
|------|--------|---------|
| Obsidian | `[topic].[type].md` | `business-model.relationship.md` |
| Standard | `[topic].[type].excalidraw` | `business-model.relationship.excalidraw` |
| Animated | `[topic].[type].animate.excalidraw` | `business-model.relationship.animate.excalidraw` |
