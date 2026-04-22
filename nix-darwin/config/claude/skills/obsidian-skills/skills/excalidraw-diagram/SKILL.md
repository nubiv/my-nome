---
name: excalidraw-diagram
description: Generate Excalidraw diagrams from text content. Supports three output modes - Obsidian (.md), Standard (.excalidraw), and Animated (.excalidraw with animation order). Use when user mentions "Excalidraw", "diagram", "flowchart", "mind map", "visualize", "standard excalidraw", "animated diagram", or "animate".
metadata:
  version: 1.2.1
---

# Excalidraw Diagram Generator

Create Excalidraw diagrams from text content with multiple output formats.

## Output Modes

Select output mode based on the user's trigger words:

| Trigger Words | Output Mode | File Format | Use Case |
|---------------|-------------|-------------|----------|
| `Excalidraw`, `diagram`, `flowchart`, `mind map`, `visualize` | **Obsidian** (default) | `.md` | Open directly in Obsidian |
| `standard excalidraw` | **Standard** | `.excalidraw` | Open/edit/share on excalidraw.com |
| `animated diagram`, `animate` | **Animated** | `.excalidraw` | Drag to excalidraw-animate to create animation |

## Workflow

1. **Detect output mode** from trigger words (see Output Modes table above)
2. Analyze content — identify concepts, relationships, hierarchy
3. Choose diagram type (see Diagram Types below)
4. Generate Excalidraw JSON (add animation order if Animated mode)
5. Output in correct format based on mode
6. **Automatically save to current working directory**
7. Notify user with file path and usage instructions

## Output Formats

### Mode 1: Obsidian Format (Default)

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

**Key requirements:**
- Frontmatter must include `tags: [excalidraw]`
- Warning message must be complete and exact
- JSON must be wrapped by `%%` markers
- Do not use any frontmatter settings other than `excalidraw-plugin: parsed`
- **File extension**: `.md`

### Mode 2: Standard Excalidraw Format

Output a pure JSON file, openable on excalidraw.com:

```json
{
  "type": "excalidraw",
  "version": 2,
  "source": "https://excalidraw.com",
  "elements": [...],
  "appState": {
    "gridSize": null,
    "viewBackgroundColor": "#ffffff"
  },
  "files": {}
}
```

**Key requirements:**
- `source` uses `https://excalidraw.com` (not Obsidian plugin)
- Pure JSON, no Markdown wrapper
- **File extension**: `.excalidraw`

### Mode 3: Animated Excalidraw Format

Same as Standard format, but add `customData.animate` to each element to control animation order:

```json
{
  "id": "element-1",
  "type": "rectangle",
  "customData": {
    "animate": {
      "order": 1,
      "duration": 500
    }
  },
  ...other standard fields
}
```

**Animation order rules:**
- `order`: Playback order (1, 2, 3...) — lower numbers appear first
- `duration`: Drawing duration for this element (milliseconds), default 500
- Elements with the same `order` appear simultaneously
- Recommended sequence: title → main frames → connectors → detail labels

**How to use:**
1. Generate the `.excalidraw` file
2. Drag it to https://dai-shi.github.io/excalidraw-animate/
3. Click Animate to preview, then export as SVG or WebM

**File extension**: `.excalidraw`

---

## Diagram Types & Selection Guide

Choose the diagram form that best enhances comprehension and visual appeal.

| Type | Use Cases | Approach |
|------|-----------|----------|
| **Flowchart** | Step-by-step instructions, workflows, task execution order | Connect steps with arrows to show process flow |
| **Mind Map** | Concept expansion, topic classification, idea capture | Radiate outward from a central core |
| **Hierarchy** | Org structures, content levels, system decomposition | Build layered nodes top-down or left-to-right |
| **Relationship** | Influence, dependencies, interactions between elements | Connect shapes with labeled arrows |
| **Comparison** | Analyzing two or more options or perspectives | Two columns or table layout with comparison dimensions |
| **Timeline** | Event history, project progress, model evolution | Time axis with key events marked |
| **Matrix** | Dual-dimension classification, task priority, positioning | X and Y dimensions on a coordinate plane |
| **Freeform** | Scattered content, brainstorming, initial info gathering | No structural constraints — freely place shapes and arrows |

## Design Rules

### Text & Format
- **All text elements must use** `fontFamily: 5` (Excalifont handwritten font)
- **Double-quote replacement**: Replace `"` with `『』` inside text strings
- **Parenthesis replacement**: Replace `()` with `「」` inside text strings
- **Font size rules** (hard minimums — below these values text is unreadable at normal zoom):
  - Title: 20–28px (minimum 20px)
  - Subtitle: 18–20px
  - Body / labels: 16–18px (minimum 16px)
  - Secondary annotations: 14px (use sparingly for unimportant notes only)
  - **Absolutely prohibited below 14px**
- **Line height**: Use `lineHeight: 1.25` for all text
- **Manual text centering**: Standalone text elements have no auto-centering — calculate x manually:
  - Estimate text width: `estimatedWidth = text.length * fontSize * 0.5` (CJK characters use `* 1.0`)
  - Centering formula: `x = centerX - estimatedWidth / 2`
  - Example: "Hello" (5 chars, fontSize 20) centered at x=300 → `estimatedWidth = 5 * 20 * 0.5 = 50` → `x = 300 - 25 = 275`

### Layout & Design
- **Canvas bounds**: Keep all elements within 0–1200 x 0–800
- **Minimum shape size**: Rectangles/ellipses with text must be at least 120×60px
- **Element spacing**: Minimum 20–30px gap between elements to prevent overlap
- **Visual hierarchy**: Use different colors and shapes to distinguish information levels
- **Shape elements**: Use rectangles, circles, arrows, etc. to organize information
- **No emoji**: Do not use emoji in diagram text — use simple shapes (circles, squares, arrows) or color for visual markers instead

### Color Palette

**Text colors (`strokeColor` for text elements):**

| Purpose | Hex | Description |
|---------|-----|-------------|
| Title | `#1e40af` | Deep blue |
| Subtitle / connectors | `#3b82f6` | Bright blue |
| Body text | `#374151` | Dark gray (on white background, never lighter than `#757575`) |
| Emphasis / highlights | `#f59e0b` | Amber |

**Shape fill colors (`backgroundColor`, `fillStyle: "solid"`):**

| Hex | Semantic | Use Cases |
|-----|----------|-----------|
| `#a5d8ff` | Light blue | Input, data sources, primary nodes |
| `#b2f2bb` | Light green | Success, output, completed |
| `#ffd8a8` | Light orange | Warning, pending, external dependencies |
| `#d0bfff` | Light purple | Processing, middleware, special items |
| `#ffc9c9` | Light red | Error, critical, alerts |
| `#fff3bf` | Light yellow | Notes, decisions, planning |
| `#c3fae8` | Light teal | Storage, data, cache |
| `#eebefa` | Light pink | Analytics, metrics, statistics |

**Zone background colors (large rectangle + `opacity: 30`, for layered diagrams):**

| Hex | Semantic |
|-----|----------|
| `#dbe4ff` | Frontend / UI layer |
| `#e5dbff` | Logic / processing layer |
| `#d3f9d8` | Data / tooling layer |

**Contrast rules:**
- On white backgrounds, text must not be lighter than `#757575`
- On light-colored fills, use dark text variants (e.g., on light green use `#15803d`, not `#22c55e`)
- Avoid light gray text (`#b0b0b0`, `#999`) on white backgrounds

See [references/excalidraw-schema.md](references/excalidraw-schema.md) for full schema reference.

## JSON Structure

**Obsidian mode:**
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

**Standard / Animated mode:**
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

## Element Template

Each element requires these fields (do NOT add extra fields like `frameId`, `index`, `versionNonce`, `rawText` — they may cause issues on excalidraw.com. `boundElements` must be `null` not `[]`, `updated` must be `1` not timestamps):

```json
{
  "id": "unique-id",
  "type": "rectangle",
  "x": 100, "y": 100,
  "width": 200, "height": 50,
  "angle": 0,
  "strokeColor": "#1e1e1e",
  "backgroundColor": "transparent",
  "fillStyle": "solid",
  "strokeWidth": 2,
  "strokeStyle": "solid",
  "roughness": 1,
  "opacity": 100,
  "groupIds": [],
  "roundness": {"type": 3},
  "seed": 123456789,
  "version": 1,
  "isDeleted": false,
  "boundElements": null,
  "updated": 1,
  "link": null,
  "locked": false
}
```

`strokeStyle` values: `"solid"` (default) | `"dashed"` (optional paths, async flows, weak associations) | `"dotted"`

Text elements add:
```json
{
  "text": "Display text",
  "fontSize": 20,
  "fontFamily": 5,
  "textAlign": "center",
  "verticalAlign": "middle",
  "containerId": null,
  "originalText": "Display text",
  "autoResize": true,
  "lineHeight": 1.25
}
```

**Animated mode additionally requires** `customData` on each element:
```json
{
  "id": "title-1",
  "type": "text",
  "customData": {
    "animate": {
      "order": 1,
      "duration": 500
    }
  },
  ...other fields
}
```

See [references/excalidraw-schema.md](references/excalidraw-schema.md) for all element types.

---

## Additional Technical Requirements

### Text Elements
- The `## Text Elements` section in Markdown **must be left empty** — use only the `%%` markers as separators
- The Obsidian Excalidraw plugin **auto-populates text elements** from the JSON data
- Do not manually list text content there

### Coordinates & Layout
- **Coordinate system**: Origin (0,0) is top-left
- **Recommended bounds**: All elements within 0–1200 x 0–800 pixels
- **Element IDs**: Each element needs a unique `id` (strings like `"title"`, `"box1"` are fine)

### Required Fields for All Elements

**IMPORTANT**: Do NOT include `frameId`, `index`, `versionNonce`, or `rawText` fields. Use `boundElements: null` (not `[]`), and `updated: 1` (not timestamps).

### appState
```json
"appState": {
  "gridSize": null,
  "viewBackgroundColor": "#ffffff"
}
```

### files field
```json
"files": {}
```

## Common Mistakes to Avoid

- **Text offset** — A standalone `text` element's `x` is its left edge, not center. Use the centering formula or text will be misaligned
- **Element overlap** — Elements with similar y-coordinates will stack. Check for at least 20px clearance before placing new elements
- **Insufficient canvas padding** — Don't place content at the canvas edge. Leave 50–80px padding on all sides
- **Title not centered over diagram** — Title should be centered over the full width of the diagram below it, not fixed at x=0
- **Arrow label overflow** — Long labels (e.g., "ATP + NADPH") overflow short arrows. Keep labels brief or increase arrow length
- **Poor contrast** — Light text on white is nearly invisible. Text color must be no lighter than `#757575`; use dark variants for colored text
- **Font too small** — Below 14px is unreadable at normal zoom; body text minimum is 16px

## Auto-save & File Generation Workflow

When generating an Excalidraw diagram, **always execute these steps automatically**:

#### 1. Choose the right diagram type
- Based on the nature of the user's content, refer to the Diagram Types & Selection Guide table above
- Analyze the core intent of the content and choose the most appropriate visual form

#### 2. Generate a meaningful file name

Choose extension based on output mode:

| Mode | Filename format | Example |
|------|----------------|---------|
| Obsidian | `[topic].[type].md` | `business-model.relationship.md` |
| Standard | `[topic].[type].excalidraw` | `business-model.relationship.excalidraw` |
| Animated | `[topic].[type].animate.excalidraw` | `business-model.relationship.animate.excalidraw` |

#### 3. Auto-save using the Write tool
- **Save location**: Current working directory
- **Full path**: `{current_directory}/[filename]`

#### 4. Ensure Markdown structure is exactly correct
**Must follow this format exactly (no modifications):**

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
{complete JSON data}
\`\`\`
%%
```

#### 5. JSON data requirements
- Complete Excalidraw JSON structure
- All text elements use `fontFamily: 5`
- Replace `"` with `『』` in text strings
- Replace `()` with `「」` in text strings
- Valid JSON syntax
- All elements have unique `id`s
- Includes `appState` and `files: {}` fields

#### 6. User feedback
Report to the user:
- Diagram has been generated
- Exact save location
- How to open it (Obsidian or excalidraw.com)
- Design choices made (diagram type and rationale)
- Whether adjustments are needed

### Example Output Messages

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
