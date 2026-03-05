---
description: Generate a technical plan (.claude/plan.md) from the spec
argument-hint: "[tech stack description]"
---

# Plan generation → `.claude/plan.md`

## Inputs
- Spec: `@.claude/spec.md`
- Tech stack constraint (must follow exactly): **$ARGUMENTS**

## Objective
Translate the spec into a concrete technical blueprint: architecture, data models, interfaces, and delivery phases (deployable milestones), without changing product intent. 

## Pre-flight (must do before writing the plan)
1) If **$ARGUMENTS** is missing or ambiguous, ask me **ONE** clarifying question to confirm the exact stack, then stop.   
2) If any spec requirement is ambiguous or conflicts with another, ask me **ONE** clarifying question at a time until it is unambiguous, then continue.   
3) Do **not** add new product requirements; only translate what’s in the spec, and carry forward any open decisions explicitly. 

## Output
Generate **only** `.claude/plan.md` in proper Markdown using exactly these headings (in this order):

## 1) Scope mapping
- Map each `REQ-##` → planned component(s) and interface(s) that satisfy it.
- Copy explicit “Out of scope” items from the spec.
- List carried-forward open decisions (if any) and where they impact the plan.

## 2) ASCII architecture diagram
- Show major components, external actors/systems, and data-flow arrows.
- Label each data flow with a payload type name (e.g., `CreateItemRequest`, `ItemRecord`, `AuditEvent`).
- Keep names consistent with models and interfaces below.

## 3) Directory structure
- Provide a concrete directory/module layout consistent with the chosen stack.
- Each directory/module includes a one-line responsibility statement.
- Use consistent naming conventions throughout.

## 4) Core data models
For each model/entity:
- Fields: name + type
- Constraints: required/optional, uniqueness, ranges/limits, default behaviors
- Relationships: cardinality and ownership
- Lifecycle/state machine (if applicable)
- Invariants/validation rules derived from the spec

## 5) API / interface definitions
For each interface (endpoint/event/command/query/UI boundary as appropriate to the stack):
- Name and purpose
- Inputs (schema/shape, required vs optional, validation rules)
- Outputs (schema/shape)
- Error cases (with conditions and error semantics)
- Auth/roles/permissions behavior
- Idempotency expectations (if applicable)
- Pagination/filtering/sorting rules (if applicable)

Definitions must be precise enough to generate implementation tasks without guessing.

## 6) Delivery phases (deployable milestones)
Break work into phases where each phase ends in a deployable, testable milestone.
For each phase include:
- Milestone goal (what is demonstrably shippable)
- Deliverables (mapped back to `REQ-##` / `AC-##`)
- Dependencies
- Rollout/migration notes (if any)
- Test plan outline (unit/integration/e2e) tied to spec acceptance criteria

## 7) Risks & open decisions
- Key technical risks (what could go wrong and why)
- Open decisions inherited from the spec (or discovered during translation)
- For each open decision: the exact question needed to resolve it, and the decision owner (“Need user answer” vs “Engineering decision”)

## Hard rules
- Do not restate the full spec; reference `REQ-##` / `AC-##` whenever possible.
- Avoid “TBD” unless paired with an explicit question and decision owner.
- Be internally consistent: names used in the diagram, models, and interfaces must match exactly. 
