# Zola Blog Writer — Reference

## Directory Structure

```
content/
├── blog/
│   ├── _index.md              # Section config (don't edit)
│   ├── _index.zh.md
│   └── <post-slug>/
│       ├── index.md           # English post
│       ├── index.zh.md        # Chinese post (optional)
│       └── image.jpg          # Co-located assets
├── life/
│   ├── _index.md
│   ├── _index.zh.md
│   └── <post-slug>/
│       ├── index.md
│       └── index.zh.md
├── project/
│   ├── _index.md
│   ├── _index.zh.md
│   ├── categories.json        # {"Display Name": "slug"}
│   ├── categories.zh.json
│   └── <project-slug>/
│       ├── index.md
│       └── index.zh.md
└── about/
    ├── index.md
    └── index.zh.md
```

## Frontmatter — Complete Field Reference

### Blog / Life Post (all fields)

```toml
+++
title = "Post Title"
date = 2026-04-03
description = "Optional meta description for SEO/feeds"

[taxonomies]
tags = ["tag1", "tag2"]
categories = ["optional-category"]

[extra]
featured_image = "banner.jpg"
featured_image_alt = "Alt text for accessibility"
featured_image_extended = true    # Full viewport width
+++
```

### Project Page (all fields)

```toml
+++
title = "Project Name"
date = 2026-04-03
description = "Short project description"

[taxonomies]
categories = ["software"]
tags = ["rust", "cli"]

[extra]
repo_path = "owner/repo-name"    # Shows GitHub stars/forks
featured_image = "screenshot.png"
featured_image_alt = "Screenshot of the project"
+++
```

## Image Shortcode

```markdown
{{ img(path="./photo.jpg", alt="Description") }}
```

All parameters:

| Parameter | Required | Description |
|-----------|----------|-------------|
| `path` | Yes | `./relative`, `/absolute-from-content`, or full URL |
| `alt` | Yes | Accessibility text |
| `caption` | No | Caption below image (supports HTML) |
| `class` | No | CSS classes |
| `extended_width_pct` | No | Width multiplier (0.0-1.0) or -1 for doc width |
| `quality` | No | JPEG/WebP quality, default 90 |

## Multilingual Content

- Default language: English (`en`)
- Supported: Chinese (`zh`)
- English file: `index.md`
- Chinese file: `index.zh.md`
- Both files live in the same directory
- Chinese content should be a proper translation, not a machine copy
- Section configs (`_index.md` / `_index.zh.md`) already exist — don't recreate

## Content Formatting

### Summary / Read More

Place `<!-- more -->` after the first 1-3 paragraphs. Text before it appears in listings.

### Code Blocks

Fenced code blocks with language identifier for syntax highlighting:

````markdown
```rust
fn main() {
    println!("Hello");
}
```
````

### Supported Markdown

- Headings (H2-H6 in content; H1 is the title)
- Ordered/unordered/nested lists
- Tables (pipe syntax)
- Blockquotes
- Inline code, bold, italic, strikethrough
- Links, footnotes
- HTML elements: `<abbr>`, `<sub>`, `<sup>`, `<kbd>`, `<mark>`

### Anchor Links

Blog and life sections have `insert_anchor_links = "right"` — headings auto-get anchor links.

## Project Categories

To add a new project category, update both JSON files:

**categories.json:**
```json
{
  "Software": "software",
  "Films": "film"
}
```

**categories.zh.json:**
```json
{
  "软件": "software",
  "电影": "film"
}
```

The key is the display name, the value is the slug used in frontmatter `categories = ["software"]`.

## Config Context

- **Base URL**: `https://nubiv.me`
- **Theme**: Papaya
- **Color mode**: auto (light/dark based on OS)
- **Feeds**: Atom enabled, per-taxonomy feeds enabled
- **Homepage**: Shows 3 recent items from blog, project, life sections
- **Date format (en)**: `%B %e, %Y` (April 3, 2026)
- **Date format (zh)**: `%Y 年 %m 月 %d 日` (2026 年 04 月 03 日)
- **Reading time**: Auto-calculated, displayed on posts

## Checklist Before Publishing

- [ ] Frontmatter has `title` and `date`
- [ ] Tags/categories are lowercase, hyphenated
- [ ] `<!-- more -->` separates summary from full content
- [ ] Images use `{{ img() }}` shortcode with `alt` text
- [ ] Co-located images are in the post directory
- [ ] Chinese version created if bilingual
- [ ] No H1 in content body (title comes from frontmatter)
- [ ] Code blocks have language identifiers
