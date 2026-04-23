# Design Rules Reference

## Text & Format

- **Font**: All text elements must use `fontFamily: 5` (Excalifont handwritten font)
- **Double-quote replacement**: Replace `"` with `『』` inside text strings
- **Parenthesis replacement**: Replace `()` with `「」` inside text strings
- **Line height**: Use `lineHeight: 1.25` for all text
- **Font size rules** (hard minimums — below these values text is unreadable at normal zoom):
  - Title: 20–28px (minimum 20px)
  - Subtitle: 18–20px
  - Body / labels: 16–18px (minimum 16px)
  - Secondary annotations: 14px (use sparingly for unimportant notes only)
  - **Absolutely prohibited below 14px**
- **Manual text centering**: Standalone text elements have no auto-centering — calculate x manually:
  - Estimate text width: `estimatedWidth = text.length * fontSize * 0.5` (CJK characters use `* 1.0`)
  - Centering formula: `x = centerX - estimatedWidth / 2`
  - Example: "Hello" (5 chars, fontSize 20) centered at x=300 → `estimatedWidth = 5 * 20 * 0.5 = 50` → `x = 300 - 25 = 275`

## Layout & Design

- **Canvas bounds**: Keep all elements within 0–1200 x 0–800
- **Coordinate system**: Origin (0,0) is top-left
- **Minimum shape size**: Rectangles/ellipses with text must be at least 120×60px
- **Element spacing**: Minimum 20–30px gap between elements to prevent overlap
- **Canvas padding**: Leave 50–80px padding on all sides — do not place content at the canvas edge
- **Visual hierarchy**: Use different colors and shapes to distinguish information levels
- **No emoji**: Do not use emoji in diagram text — use simple shapes (circles, squares, arrows) or color for visual markers instead

## Common Mistakes to Avoid

- **Text offset** — A standalone `text` element's `x` is its left edge, not center. Use the centering formula or text will be misaligned
- **Element overlap** — Elements with similar y-coordinates will stack. Check for at least 20px clearance before placing new elements
- **Title not centered** — Title should be centered over the full width of the diagram, not fixed at x=0
- **Arrow label overflow** — Long labels (e.g., "ATP + NADPH") overflow short arrows. Keep labels brief or increase arrow length
- **Poor contrast** — Light text on white is nearly invisible. Text color must be no lighter than `#757575`; use dark variants for colored text
- **Font too small** — Below 14px is unreadable at normal zoom; body text minimum is 16px
