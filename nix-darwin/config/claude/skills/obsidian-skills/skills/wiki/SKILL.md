---
name: wiki
description: Run MY_WIKI operations (ingest, query, research, lint). Use when the user wants to add sources to the wiki, ask questions against it, research new topics from the web, or audit its quality.
---

# MY_WIKI Operations

Route wiki research requests to the procedures defined in `ndian/MY_WIKI/SCHEMA.md`.

## Usage

```
/wiki ingest <source name or path in raw/sources/>
/wiki query <question>
/wiki research <topic>
/wiki lint
```

## Procedure

1. Read `ndian/MY_WIKI/SCHEMA.md` — this is the single source of truth for all wiki operations.
2. Parse the operation from the user's input:
   - **ingest** — follow the "Ingest" section (steps 1-7)
   - **query** — follow the "Query" section (steps 1-5)
   - **research** — follow the "Research" section (steps 1-6)
   - **lint** — follow the "Lint" section
3. Execute the operation exactly as the schema specifies.

## Rules

- Always read `MY_WIKI/SCHEMA.md` before starting — do not work from memory of its contents.
- Respect the boundary: `raw/` is read-only, `wiki/` is agent-maintained. Exception: `research` writes new sources to `raw/sources/`.
- Never delete `wiki/Home.md`, `wiki/index.md`, or `wiki/log.md`.
- Follow the frontmatter, citation, and note format rules in the schema.
- Apply the `obsidian-markdown` skill for all `.md` files written.
