# Excalidraw JSON Schema Reference

## Color Palette

### Text Colors (strokeColor for text elements)

| Purpose | Hex | Description |
|---------|-----|-------------|
| Title | `#1e40af` | Deep blue |
| Subtitle / connectors | `#3b82f6` | Bright blue |
| Body text | `#374151` | Dark gray |
| Emphasis | `#f59e0b` | Amber |
| Success | `#10b981` | Green |
| Warning | `#ef4444` | Red |

### Shape Fill Colors (backgroundColor)

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

### Zone Background Colors (opacity: 30)

| Hex | Semantic |
|-----|----------|
| `#dbe4ff` | Frontend / UI layer |
| `#e5dbff` | Logic / processing layer |
| `#d3f9d8` | Data / tooling layer |

## Element Types

### Rectangle
```json
{
  "type": "rectangle",
  "id": "unique-id",
  "x": 100,
  "y": 100,
  "width": 200,
  "height": 80,
  "angle": 0,
  "strokeColor": "#1e40af",
  "backgroundColor": "#a5d8ff",
  "fillStyle": "solid",
  "strokeWidth": 2,
  "strokeStyle": "solid",
  "roughness": 1,
  "opacity": 100,
  "groupIds": [],
  "roundness": { "type": 3 },
  "seed": 123456789,
  "version": 1,
  "isDeleted": false,
  "boundElements": null,
  "updated": 1,
  "link": null,
  "locked": false
}
```

### Text
```json
{
  "type": "text",
  "id": "unique-id",
  "x": 150,
  "y": 130,
  "width": 100,
  "height": 25,
  "angle": 0,
  "strokeColor": "#1e40af",
  "backgroundColor": "transparent",
  "fillStyle": "solid",
  "strokeWidth": 2,
  "strokeStyle": "solid",
  "roughness": 1,
  "opacity": 100,
  "groupIds": [],
  "roundness": null,
  "seed": 123456789,
  "version": 1,
  "isDeleted": false,
  "boundElements": null,
  "updated": 1,
  "link": null,
  "locked": false,
  "text": "Content here",
  "fontSize": 20,
  "fontFamily": 5,
  "textAlign": "center",
  "verticalAlign": "middle",
  "containerId": null,
  "originalText": "Content here",
  "autoResize": true,
  "lineHeight": 1.25
}
```

### Arrow
```json
{
  "type": "arrow",
  "id": "unique-id",
  "x": 300,
  "y": 140,
  "width": 100,
  "height": 0,
  "angle": 0,
  "strokeColor": "#374151",
  "backgroundColor": "transparent",
  "fillStyle": "solid",
  "strokeWidth": 2,
  "strokeStyle": "solid",
  "roughness": 1,
  "opacity": 100,
  "groupIds": [],
  "roundness": { "type": 2 },
  "seed": 123456789,
  "version": 1,
  "isDeleted": false,
  "boundElements": null,
  "updated": 1,
  "link": null,
  "locked": false,
  "points": [[0, 0], [100, 0]],
  "startArrowhead": null,
  "endArrowhead": "arrow"
}
```

### Ellipse
```json
{
  "type": "ellipse",
  "id": "unique-id",
  "x": 100,
  "y": 100,
  "width": 120,
  "height": 120,
  "angle": 0,
  "strokeColor": "#10b981",
  "backgroundColor": "#b2f2bb",
  "fillStyle": "solid",
  "strokeWidth": 2,
  "strokeStyle": "solid",
  "roughness": 1,
  "opacity": 100,
  "groupIds": [],
  "roundness": { "type": 2 },
  "seed": 123456789,
  "version": 1,
  "isDeleted": false,
  "boundElements": null,
  "updated": 1,
  "link": null,
  "locked": false
}
```

### Diamond
```json
{
  "type": "diamond",
  "id": "unique-id",
  "x": 100,
  "y": 100,
  "width": 150,
  "height": 100,
  "angle": 0,
  "strokeColor": "#f59e0b",
  "backgroundColor": "#fff3bf",
  "fillStyle": "solid",
  "strokeWidth": 2,
  "strokeStyle": "solid",
  "roughness": 1,
  "opacity": 100,
  "groupIds": [],
  "roundness": { "type": 2 },
  "seed": 123456789,
  "version": 1,
  "isDeleted": false,
  "boundElements": null,
  "updated": 1,
  "link": null,
  "locked": false
}
```

### Line
```json
{
  "type": "line",
  "id": "unique-id",
  "x": 100,
  "y": 100,
  "width": 200,
  "height": 100,
  "angle": 0,
  "strokeColor": "#374151",
  "backgroundColor": "transparent",
  "fillStyle": "solid",
  "strokeWidth": 2,
  "strokeStyle": "solid",
  "roughness": 1,
  "opacity": 100,
  "groupIds": [],
  "roundness": { "type": 2 },
  "seed": 123456789,
  "version": 1,
  "isDeleted": false,
  "boundElements": null,
  "updated": 1,
  "link": null,
  "locked": false,
  "points": [[0, 0], [200, 100]],
  "startArrowhead": null,
  "endArrowhead": null
}
```

## Full JSON Structure

### Obsidian Mode
```json
{
  "type": "excalidraw",
  "version": 2,
  "source": "https://github.com/zsviczian/obsidian-excalidraw-plugin",
  "elements": [],
  "appState": {
    "gridSize": null,
    "viewBackgroundColor": "#ffffff"
  },
  "files": {}
}
```

### Standard / Animated Mode
```json
{
  "type": "excalidraw",
  "version": 2,
  "source": "https://excalidraw.com",
  "elements": [],
  "appState": {
    "gridSize": null,
    "viewBackgroundColor": "#ffffff"
  },
  "files": {}
}
```

## Font Family Values

| Value | Font Name | Notes |
|-------|-----------|-------|
| 1 | Virgil | Hand-drawn style |
| 2 | Helvetica | Sans-serif |
| 3 | Cascadia | Monospace |
| 4 | Assistant | Clean sans-serif |
| 5 | Excalifont | **Recommended** — handwritten |

## Fill Styles

- `solid` — Solid fill
- `hachure` — Hatched lines
- `cross-hatch` — Cross-hatched
- `dots` — Dotted pattern

## Stroke Styles

- `solid` — Default solid line
- `dashed` — For optional paths, async flows, weak associations
- `dotted` — For loose or background connections

## Roundness Types

- `{ "type": 1 }` — Sharp corners
- `{ "type": 2 }` — Slight rounding (for arrows, lines, ellipses, diamonds)
- `{ "type": 3 }` — Full rounding (recommended for rectangles)

## Element Binding (Text inside Container)

```json
{
  "type": "rectangle",
  "id": "container-id",
  "boundElements": [{ "id": "text-id", "type": "text" }]
}
```

```json
{
  "type": "text",
  "id": "text-id",
  "containerId": "container-id"
}
```

## Arrow Binding (Connecting Arrows to Shapes)

```json
{
  "type": "arrow",
  "startBinding": {
    "elementId": "source-shape-id",
    "focus": 0,
    "gap": 5
  },
  "endBinding": {
    "elementId": "target-shape-id",
    "focus": 0,
    "gap": 5
  }
}
```

## Animated Mode — customData

Add to every element when generating animated diagrams:

```json
{
  "customData": {
    "animate": {
      "order": 1,
      "duration": 500
    }
  }
}
```

- `order`: Integer starting from 1; lower = appears earlier
- `duration`: Milliseconds for this element's draw animation (default 500)
- Elements with the same `order` appear simultaneously
- Recommended sequence: title (1) → background zones (2) → main shapes (3–N) → connectors (N+1–M) → labels (M+1–Z)
