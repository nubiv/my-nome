---
name: assistant
description: Personal assistant that reviews the user's schedule and tasks in MY_DESK. Use when the user invokes /assistant or asks about their todos, schedule, or what to work on next.
---

# Personal Assistant

Scan the user's MY_DESK workspace, compile open tasks, and present a prioritized todo list.

## Procedure

### 1. Gather context

- **Today's date**: use the current date
- **Daily note**: read `ndian/MY_DESK/Daily/YYYY-MM-DD.md` (today's date)
- **Recent daily notes**: walk back up to **14 calendar days**. For each date, attempt to read `Daily/YYYY-MM-DD.md` — skip missing dates silently (weekends, gaps, days without notes). Collect unchecked tasks from every note that exists in the window.
- **Project notes** (two-pass):
  1. Read every **main project note** — the `.md` file whose name matches its parent folder (e.g. `Projects/apricot/apricot.md`, `Projects/jw_derive/jw_derive.md`). These provide project context, status, and scope.
  2. For all other `.md` files under `Projects/`, grep for task patterns (`- \[ \]`, `TODO`, `FIXME`, `ACTION`, `NEXT`, `due:`, `deadline:`). Only read files that have matches.

If a file does not exist, skip it silently.

### 2. Extract tasks

Scan every note for actionable items. Recognise these patterns:

| Pattern | Example |
|---------|---------|
| Unchecked checkbox | `- [ ] Review PR` |
| Deadline / due date | `due: 2026-04-25`, `deadline: Friday` |
| Inline task keyword | Lines starting with `TODO`, `FIXME`, `ACTION`, `NEXT` |
| Callout task | `> [!todo]` or `> [!action]` blocks |
| Scheduled event | Lines containing a time (`10:00`, `2pm`) or date reference |

Ignore completed checkboxes (`- [x]`).

### 3. Classify priority

Assign each item a priority tier:

| Tier | Criteria |
|------|----------|
| **P0 — Urgent** | Overdue, or due today, or marked `#urgent` / `#p0` |
| **P1 — Important** | Due within 3 days, or tied to an active project milestone |
| **P2 — Normal** | Has a due date further out, or is an open checkbox with no date |
| **P3 — Backlog** | Carried over from 3+ days ago with no recent mention |

### 4. Present output

Format as a single prioritised list grouped by tier:

```
## Today's Todos

### P0 — Urgent
- [ ] Item (source: Daily/2026-04-23)

### P1 — Important
- [ ] Item (source: Projects/quantx/architecture_overview)

### P2 — Normal
...

### P3 — Backlog
...
```

- Show the source note as a wikilink: `([[Daily/2026-04-23]])`
- If no items exist for a tier, omit that section
- After the list, add a short **Suggested focus** section: pick the top 1-3 items to work on and briefly say why

### 5. Carry forward

When creating today's daily note (or if it already exists but has no carried-over section):

1. Take all unchecked tasks from daily notes **older than yesterday** that were found in step 1
2. Add them to today's note under a `## Carried Over` section, each annotated with its original date:
   ```
   ## Carried Over
   - [ ] Task description (from [[Daily/2026-04-18]])
   ```
3. Do **not** modify or remove the tasks from their original notes — they stay as historical record

This ensures no task silently vanishes due to gaps or age.

### 6. Offer next steps

After presenting, ask:
- Want me to update any of these items?
- Should I create today's daily note? (if it doesn't exist)

## Extensibility

Additional data sources (e.g., Google Calendar, Linear) can be added as new steps in the "Gather context" phase. Each source should produce the same `(task, priority, source)` tuples that feed into step 3.
