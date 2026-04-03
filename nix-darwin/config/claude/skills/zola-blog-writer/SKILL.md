---
name: zola-blog-writer
description: Write blog posts, life entries, and project pages for a Zola-based blog with Papaya theme. Use when user wants to create, draft, or publish content for their blog, write a new post, add a project, or create life section entries. Handles frontmatter, multilingual (en/zh), taxonomies, image shortcodes, and summaries.
---

# Zola Blog Writer

Write content for nubiv's Zola blog (`/Users/nubiv/dev/blog`). See [REFERENCE.md](REFERENCE.md) for full details.

## Quick Start

1. Ask user: **section** (blog/life/project), **title**, **tags/categories**, **language** (en, zh, or both)
2. Create directory: `content/<section>/<slug>/`
3. Write `index.md` (and `index.zh.md` if bilingual)
4. Use proper frontmatter and content structure below

## Blog / Life Post

```markdown
+++
title = "Post Title"
date = YYYY-MM-DD

[taxonomies]
tags = ["tag1", "tag2"]
+++

Summary paragraph here — shown in listings and feeds.

<!-- more -->

Full content continues here...
```

## Project Page

```markdown
+++
title = "Project Name"
date = YYYY-MM-DD

[taxonomies]
categories = ["category-slug"]

[extra]
repo_path = "owner/repo"
+++

Project description.
```

## Key Rules

- **Slug**: lowercase, hyphenated directory name (`my-post-title/`)
- **Date**: `YYYY-MM-DD` format, required for blog/life posts
- **Summary**: Use `<!-- more -->` to split preview from full content
- **Images**: Use `{{ img(path="./image.jpg", alt="description") }}` shortcode
- **Bilingual**: English = `index.md`, Chinese = `index.zh.md` (same directory)
- **Featured image**: Add `[extra]` with `featured_image`, `featured_image_alt`, `featured_image_extended`
- **Sections use different templates**: blog.html, life.html, project.html
