---
description: Strict TDD executor (Red→Green) for a tasks range
argument-hint: "[task range]"
---

# Execute Tasks (TDD)

Inputs: `@.claude/tasks.md`, range **$ARGUMENTS**

## Command

```
@.claude/tasks.md

Execute tasks in range in strict TDD order:

  1. Write the test (it MUST fail first — red)
  2. Write the implementation (make it pass — green)
  3. Refactor if needed
  4. Update .claude/tasks.md status as you go
  5. Update any other Markdown docs if relevant

Do NOT skip the failing-test step.
```

## Output

- Source files for each task
- `.claude/tasks.md` updated with task statuses

## Rules

- Claude must **run the test and confirm it fails** before writing implementation
- Each task pair (`T001`/`T002`, `T003`/`T004`, …) is a complete Red → Green cycle
- Status values in `tasks.md`: `pending` → `in-progress` → `done`
- If a test cannot be made to pass, Claude must **stop and report** before continuing

If `$ARGUMENTS` missing, ask: “What range (e.g., T001-T006 or t1-6)?”