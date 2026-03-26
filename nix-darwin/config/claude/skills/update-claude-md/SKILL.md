---
name: update-claude-md
description: Scan a repository and update its CLAUDE.md to reflect current structure, build commands, conventions, and dependencies. Use when user asks to update CLAUDE.md, refresh project instructions, or sync repo docs after significant changes.
---

# Update CLAUDE.md

## Quick start

1. Identify target repo (current directory or user-specified path)
2. Scan repo state
3. Diff against existing CLAUDE.md
4. Apply updates preserving user-written sections

## Workflow

### Phase 1: Scan repo state

- [ ] Read existing CLAUDE.md (if any)
- [ ] Detect language/framework from config files (Cargo.toml, pyproject.toml, package.json, go.mod, pom.xml, etc.)
- [ ] Map directory structure (top-level + one level deep into src/)
- [ ] Extract build/test/lint commands from config, Makefile, justfile, package.json scripts, or CI files
- [ ] Identify key entry points (main.rs, main.py, index.ts, cmd/, etc.)
- [ ] Count crates/packages/modules

### Phase 2: Detect changes

- [ ] Compare scanned state against existing CLAUDE.md sections
- [ ] Flag stale build commands (e.g., missing package, renamed binary)
- [ ] Flag new modules/crates/packages not mentioned in CLAUDE.md
- [ ] Flag removed modules still referenced in CLAUDE.md
- [ ] Check if dependency versions have shifted significantly

### Phase 3: Update CLAUDE.md

Preserve these user-written sections verbatim (do not overwrite):
- Custom conventions or style rules
- Architecture notes written by the user
- Any section marked with `<!-- manual -->`

Update or generate these sections:
- **Project overview** (language, purpose, one-liner)
- **Directory structure** (tree of key paths)
- **Build & test commands** (verified against config files)
- **Key modules** (table of module → purpose)
- **Dependencies** (major external deps)
- **Conventions** (naming, error handling, patterns)

### Phase 4: Verify

- [ ] CLAUDE.md is under 300 lines (split to REFERENCE.md if needed)
- [ ] All listed build commands actually work (run them)
- [ ] No stale file paths referenced
- [ ] Present diff summary to user before writing

## Section template

```markdown
# Project Name

One-line description.

## Build & test
\`\`\`bash
command1   # what it does
command2   # what it does
\`\`\`

## Structure
- `src/module/` — purpose
- `src/other/` — purpose

## Key modules
| Module | Purpose |
|--------|---------|
| name   | desc    |

## Conventions
- Rule 1
- Rule 2
```

## Anti-patterns

- **Never** delete user-written convention sections
- **Never** add speculative "TODO" sections
- **Never** include file contents — only paths and summaries
- **Never** exceed 300 lines in CLAUDE.md
