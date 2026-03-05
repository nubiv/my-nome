---
description: Convert spec + plan into a test-first, one-file-per-task tasks list
argument-hint: "no args"
---

# Task breakdown → `.claude/tasks.md`

## Inputs
- Spec: `@.claude/spec.md`
- Plan: `@.claude/plan.md`

## Objective
Decompose the plan into an **atomic**, dependency-ordered, **test-first** task list suitable for strict TDD execution. 

## Global rules (must follow)
- **One task modifies exactly ONE file** (no exceptions).
- Tests-first pairing: odd tasks (`T001`, `T003`, …) add/extend a **failing test**; the immediately following even task (`T002`, `T004`, …) writes the **implementation** to make that test pass.
- Keep tasks atomic: each odd/even pair covers **one behavior** (or one small slice) from the spec’s acceptance criteria.
- Dependencies must be **complete and satisfiable**; never depend on a later task.
- No “setup” tasks unless they modify a single file and are strictly required to run the first test.
- Do not invent requirements; every task must trace to a plan milestone and spec `REQ-##` / `AC-##`.

## Output format (strict)
Write `.claude/tasks.md` in Markdown, but the **body must contain only task lines** (no prose, no headings, no blank lines):

`T### | file | description | depends-on`

## Task content requirements
- `file`: exact path of the **one** file changed by the task (tests and implementation must be different files, therefore different tasks).
- `description`:
  - Start with an action verb.
  - Include the specific behavior under test in the form **inputs → expected outcome**.
  - Reference the spec identifier(s) (e.g., `REQ-02`, `AC-07`) and the plan milestone (e.g., `M1`).
  - Avoid the word “and”; if you need “and”, split into separate task pairs.
- `depends-on`: comma-separated prerequisite task IDs (e.g., `T001,T002`) or empty.

## Ordering rules
1) Start with the thinnest vertical slice that delivers a **deployable milestone** from the plan (not “infrastructure first” unless the plan explicitly requires it).
2) Prefer contract tests at boundaries (API/interface) before deeper unit tests when that reduces rework.
3) For each API/interface, split into separate test/impl pairs as applicable:
- Validate request
- Handle success
- Handle error cases
- Handle auth/roles
- Handle pagination/filtering/sorting

## Quality bar
- Every odd task must be **capable of failing** before its paired implementation exists (don’t write “tests” that can’t fail).
- Tasks must be small enough that each pair is realistically completable without touching more than one file.

## Stop condition
If you cannot produce a valid task list because the spec/plan lacks stable identifiers (`REQ-##`, `AC-##`, milestone IDs) or is ambiguous, ask me **ONE** clarifying question and stop. 

## Generate now
Generate `.claude/tasks.md` following the rules above. Do not start executing the tasks for now!
