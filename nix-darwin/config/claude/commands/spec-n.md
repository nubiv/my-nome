---
description: Interview me to produce a purely functional feature spec
argument-hint: "[feature description]"
---

# Spec interview → `.claude/spec.md`

## Input
I want to build: **$ARGUMENTS**

## Your job
Use **interview mode** to extract requirements, acceptance criteria, and edge cases (purely functional — no implementation details).

### Hard constraints
- Ask **one question at a time**, then wait for my answer before asking the next.
- Do **not** assume missing details; ask.
- Prioritize non-obvious areas: failure modes, empty states, boundary inputs, permissions/roles, UX expectations, and degraded scenarios.
- Keep going until requirements are unambiguous and testable/measurable (pass/fail).
- **No implementation details**: no tech stack, no architecture, no code, no databases, no APIs, no file paths except the output file name below.
- If something is uncertain, capture it explicitly as an **open decision** inside the relevant section (don’t invent an answer).

## Interview flow (one question at a time)
1. First, ask me to restate the feature in one sentence using one of these forms:
   - “A user can…”
   - “The system should…”
2. Then proceed with one question at a time, choosing the next question based on what most affects correctness/testing:
   - Users & roles (who can do what)
   - In-scope vs out-of-scope (explicit boundaries)
   - Primary user journeys (happy paths)
   - Inputs/outputs (what data the user provides/sees; validation rules)
   - Permissions, privacy, and visibility rules
   - State changes and lifecycle (create/update/delete; statuses)
   - Notifications/confirmations (what the user must observe)
   - Constraints (timing, volume limits, latency expectations if relevant)
   - Error handling and recovery (what happens when things go wrong)
   - Empty states and boundary conditions
3. Stop interviewing only when you can produce a complete spec with measurable acceptance criteria.

## Output (after the interview)
Generate **only** `.claude/spec.md` in proper Markdown with exactly these sections:

### 1) Requirements
- Include **In scope** and **Out of scope**.
- List requirements as `REQ-01`, `REQ-02`, … (purely functional statements).
- For each requirement, include (as applicable):
  - Actors/roles involved
  - Preconditions
  - Trigger/action
  - Expected observable outcome
  - Any open decisions (clearly labeled)

### 2) Acceptance criteria
- List acceptance criteria as `AC-01`, `AC-02`, … and reference the related requirement IDs.
- Each criterion must be **testable/measurable** with clear pass/fail conditions.
- Prefer a structured format such as:
  - **Given** [initial state / role / data]
  - **When** [user/system action]
  - **Then** [observable result, including exact rules/thresholds where relevant]

### 3) Edge cases & constraints
Cover at minimum:
- Failure modes (timeouts, permission denied, invalid input, partial completion, retries)
- Empty states (no data, first-time user, missing optional data)
- Boundary inputs (min/max lengths, large counts, unusual characters, time ranges, duplicates)
- Degraded scenarios (offline/slow network, third-party unavailable, concurrency/race conditions)
- Any explicit constraints (limits, policies, compliance/privacy expectations) and open decisions

## Important
Do not write `.claude/spec.md` until the interview is complete.
Start now with the first question.
