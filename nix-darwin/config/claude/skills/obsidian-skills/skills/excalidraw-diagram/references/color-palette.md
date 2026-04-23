# Color Palette Reference

## Text Colors (`strokeColor` for text elements)

| Purpose | Hex | Description |
|---------|-----|-------------|
| Title | `#1e40af` | Deep blue |
| Subtitle / connectors | `#3b82f6` | Bright blue |
| Body text | `#374151` | Dark gray |
| Emphasis / highlights | `#f59e0b` | Amber |
| Success | `#10b981` | Green |
| Warning | `#ef4444` | Red |

## Shape Fill Colors (`backgroundColor`, `fillStyle: "solid"`)

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

## Zone Background Colors (large rectangle + `opacity: 30`)

| Hex | Semantic |
|-----|----------|
| `#dbe4ff` | Frontend / UI layer |
| `#e5dbff` | Logic / processing layer |
| `#d3f9d8` | Data / tooling layer |

## Contrast Rules

- On white backgrounds, text must not be lighter than `#757575`
- On light-colored fills, use dark text variants (e.g., on light green use `#15803d`, not `#22c55e`)
- Avoid light gray text (`#b0b0b0`, `#999`) on white backgrounds
