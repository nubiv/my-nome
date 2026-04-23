---
name: excalidraw-diagram
description: Generate Excalidraw diagrams from text content. Supports three output modes - Obsidian (.md), Standard (.excalidraw), and Animated (.excalidraw with animation order). Use when user mentions "Excalidraw", "diagram", "flowchart", "mind map", "visualize", "standard excalidraw", "animated diagram", or "animate".
metadata:
  version: 1.3.0
---

# Excalidraw Diagram Generator

Create Excalidraw diagrams from text content with multiple output formats.

## Output Modes

| Trigger Words | Output Mode | File Format | Use Case |
|---------------|-------------|-------------|----------|
| `Excalidraw`, `diagram`, `flowchart`, `mind map`, `visualize` | **Obsidian** (default) | `.md` | Open directly in Obsidian |
| `standard excalidraw` | **Standard** | `.excalidraw` | Open/edit/share on excalidraw.com |
| `animated diagram`, `animate` | **Animated** | `.excalidraw` | Drag to excalidraw-animate to create animation |

## Workflow

1. **Detect output mode** from trigger words (see Output Modes table above)
2. **Choose diagram type** — see [references/diagram-types.md](references/diagram-types.md)
3. **Plan layout** — apply rules from [references/design-rules.md](references/design-rules.md) and [references/color-palette.md](references/color-palette.md)
4. **Generate JSON** — use templates from [references/element-types.md](references/element-types.md); add `customData.animate` if Animated mode
5. **Wrap output** in correct format — see [references/json-structure.md](references/json-structure.md)
6. **Save file** to current working directory using the Write tool
7. **Notify user** with file path, how to open, and design choices made

## Auto-save Steps

1. Choose diagram type → [references/diagram-types.md](references/diagram-types.md)
2. Generate file name → [references/json-structure.md](references/json-structure.md) (File Naming section)
3. Save with Write tool to `{current_directory}/[filename]`
4. Verify JSON validity: unique element IDs, correct `appState`, `files: {}`

## Example Output Messages

**Obsidian mode:**
```
Excalidraw diagram generated!

Saved to: business-model.relationship.md

How to open:
1. Open this file in Obsidian
2. Click MORE OPTIONS in the top-right menu
3. Select "Switch to EXCALIDRAW VIEW"
```

**Standard mode:**
```
Excalidraw diagram generated!

Saved to: business-model.relationship.excalidraw

How to open:
1. Go to https://excalidraw.com
2. Click the top-left menu → Open → select this file
3. Or drag and drop the file onto the excalidraw.com page
```

**Animated mode:**
```
Animated Excalidraw diagram generated!

Saved to: business-model.relationship.animate.excalidraw

Animation order: title (1) → main frames (2-4) → connectors (5-7) → detail labels (8-10)

To generate animation:
1. Go to https://dai-shi.github.io/excalidraw-animate/
2. Click "Load File" and select this file
3. Preview the animation
4. Click "Export" to save as SVG or WebM
```

## References

| File | Contents |
|------|----------|
| [color-palette.md](references/color-palette.md) | Text colors, shape fills, zone backgrounds, contrast rules |
| [design-rules.md](references/design-rules.md) | Text/format rules, layout rules, common mistakes |
| [diagram-types.md](references/diagram-types.md) | Diagram type selection guide |
| [element-types.md](references/element-types.md) | Element templates, font family, fill/stroke/roundness, binding, animated customData |
| [json-structure.md](references/json-structure.md) | JSON wrappers, Obsidian file format, file naming |
