---
name: assistant
description: "Personal assistant and thinking partner. Subcommands: open, context, close, ghost, challenge, emerge, drift, trace, connect, ideas, handoff, checkin. Use when the user invokes /assistant with a subcommand."
---

# Personal Assistant

Route based on the first word of `$ARGUMENTS`:

| Subcommand | Purpose |
|------------|---------|
| `open` | Morning planning — prioritized todo list |
| `context` | Load full life/work overview into session |
| `close` | Evening review — close the feedback loop |
| `ghost <question>` | Answer a question the way the user would |
| `challenge <topic>` | Pressure-test a belief using the user's own notes |
| `emerge` | Surface ideas the vault implies but never states |
| `drift` | Compare stated priorities vs actual time allocation |
| `trace <topic>` | Track how an idea evolved over time |
| `connect <A> and <B>` | Find hidden bridges between two domains |
| `ideas` | Deep vault scan to generate actionable ideas |
| `handoff <project>` | Write implementation-ready next items to the project's `.claude/handoffs/` dir |
| `checkin` | Write a session summary to `.claude/checkins/` in the current repo |

Parse the subcommand, then execute the matching section below. If no subcommand is provided, show the routing table and ask the user to pick one.

## Vault paths

Read `ndian/MY_DESK/SCHEMA.md` for full conventions. Key paths:

- Daily notes: `ndian/MY_DESK/Daily/YYYY-MM-DD.md`
- Projects: `ndian/MY_DESK/Projects/<name>/<name>.md` (main note matches folder name)
- MY_WIKI: `ndian/MY_WIKI/wiki/` (read-only for this skill)

---

## open

Morning planning. Prioritized todo list with carry-forward.

### 1. Gather context

- Read today's daily note if it exists.
- Walk back up to **14 calendar days**. For each date, attempt to read `Daily/YYYY-MM-DD.md` — skip missing dates silently. Collect unchecked tasks from every note that exists.
- **Project notes** (two-pass):
  1. Read every main project note (`.md` matching parent folder name).
  2. For other `.md` files under `Projects/`, grep for task patterns (`- [ ]`, `TODO`, `FIXME`, `ACTION`, `NEXT`, `due:`, `deadline:`). Only read files with matches.
- **Pending checkins**: Read `.claude/local.md` — for each entry under `repos:`, check `{mapped_path}/.claude/checkins/` for any unread checkin files (i.e., files not already referenced in any daily note). Read them and extract carry-forward items.

### 2. Extract tasks

| Pattern | Example |
|---------|---------|
| Unchecked checkbox | `- [ ] Review PR` |
| Deadline / due date | `due: 2026-04-25`, `deadline: Friday` |
| Inline task keyword | `TODO`, `FIXME`, `ACTION`, `NEXT` |
| Callout task | `> [!todo]` or `> [!action]` blocks |
| Scheduled event | Lines with a time (`10:00`, `2pm`) or date reference |

Ignore completed checkboxes (`- [x]`).

### 3. Classify priority

| Tier | Criteria |
|------|----------|
| **P0 — Urgent** | Overdue, due today, or marked `#urgent` / `#p0` |
| **P1 — Important** | Due within 3 days, or tied to an active project milestone |
| **P2 — Normal** | Has a due date further out, or open checkbox with no date |
| **P3 — Backlog** | Carried over from 3+ days ago with no recent mention |

### 4. Present

```
## Today's Todos

### P0 — Urgent
- [ ] Item ([[Daily/2026-04-23]])

### P1 — Important
- [ ] Item ([[Projects/quantx/architecture]])
...
```

Omit empty tiers. After the list, add **Suggested focus**: pick 1–3 items and say why.

If any pending checkin files were found, append a **From repo sessions** section listing each checkin's carry-forward items with the project and date. Do not merge these into the priority tiers — keep them separate for the user to decide what to promote.

### 5. Carry forward

If today's daily note exists but has no carried-over section:

1. Take unchecked tasks from daily notes **older than yesterday**.
2. Add to today's note under `## Carried Over`, annotated with original date.
3. Do **not** modify original notes.

### 6. Offer next steps

Ask:
- Want me to update any of these items?
- Should I create today's daily note? (if it doesn't exist)

---

## context

Load full context in one shot. Read-only.

1. Read top-level context files: `CLAUDE.md`, `SCHEMA.md`, `ndian/MY_DESK/SCHEMA.md`.
2. Read every main project note under `Projects/`.
3. Read the last 7 daily notes (walk back from today, skip gaps).
4. Read `MY_WIKI/wiki/Home.md` for research context.

Present a structured briefing:

- **Active projects**: name, status, current focus
- **Recent momentum**: what was worked on this week
- **Open threads**: unresolved questions, pending decisions, things said would be done
- **Research context**: active wiki topics (from Home.md)
- **Connections**: cross-project dependencies or themes noticed

Do not create or modify any files.

---

## close

End-of-day review. Read-only.

1. Read today's daily note.
2. Read any notes modified today (check `jj diff --summary` for today's changes).
3. Read the morning plan if `open` was run earlier (check today's note for carried-over section or task list).
4. **Checkins**: Read `.claude/local.md` — for each entry under `repos:`, check `{mapped_path}/.claude/checkins/` for any checkin files dated today. Read them.

Present:

- **What got done**: completed tasks and progress
- **What shifted**: anything planned this morning that didn't happen (and why, if notes suggest a reason)
- **Open loops**: tasks or questions carrying into tomorrow
- **Observations**: recurring theme, contradiction, or new idea that appeared today
- **Tomorrow seed**: 1–2 specific things to start with tomorrow

If today's checkin files exist, append a **Repo session summaries** section with each checkin's done/decisions/carry-forward content.

Do not create or modify any files.

---

## ghost

Answer a question the way the user would. Read-only.

The question is everything after `ghost` in `$ARGUMENTS`.

1. Read 10–15 of the most substantial notes (project notes, reflections, analyses — not task lists).
2. Build a model of how the user thinks: vocabulary, reasoning patterns, what they emphasize, what they dismiss, frameworks they use.
3. Answer the question in their voice. Match:
   - Certainty vs hedging level
   - Brevity or elaboration tendency
   - Specific terminology
   - Reasoning style (first-principles, analogies, experience-based)

If there isn't enough writing on the topic, say so.

Do not create or modify any files.

---

## challenge

Pressure-test a belief or position. Read-only.

The topic is everything after `challenge` in `$ARGUMENTS`.

1. Search the vault for everything written about this topic — daily notes, project notes, reflections, passing mentions.
2. Identify the stated position: what does the user seem to believe?
3. Challenge it:
   - **Contradictions**: places where notes conflict with this belief (with quotes)
   - **Blind spots**: important considerations never mentioned
   - **Staleness**: beliefs based on old context that may no longer apply
   - **Counter-argument**: strongest case against the position, from the user's own writing

Present as:

- **Your stated position**
- **Evidence for it**
- **Contradictions found** (with note quotes)
- **Blind spots**
- **Steel-manned counter**

Be direct. Do not soften the challenge. Do not create or modify any files.

---

## emerge

Surface implicit ideas. Read-only.

1. Read broadly — project notes, daily notes, analyses, wiki Home.
2. Look for:
   - **Implicit beliefs**: things consistently acted on but never articulated
   - **Convergence points**: unrelated notes pointing to the same unstated conclusion
   - **Latent questions**: questions the notes circle around without asking
   - **Hidden priorities**: what writing patterns reveal about actual values
   - **Emerging frameworks**: mental models being built piece by piece without naming

For each emergence:
- The idea in one sentence
- 2–4 notes that imply it (with brief quotes)
- Why it probably hasn't been stated yet

Aim for 3–5. Prioritize surprising over obvious.
Do not create or modify any files.

---

## drift

Priority drift detection. Read-only.

1. **Find stated priorities**: read project notes, planning entries, any place that says "I want to focus on X" or "this matters most."
2. **Measure actual allocation**: read all daily notes from the last 30–60 days. Categorize what was actually worked on per day.
3. **Compare**:

Present as:

- **Stated priorities**
- **Actual allocation** (rough breakdown by project/theme, with note counts)
- **Alignment**: where stated and actual match
- **Drift**: what gets more attention than declared, what gets less
- **Interpretation**: what the drift might mean (priority shift? avoidance? new interest?)

Be honest. Do not create or modify any files.

---

## trace

Track idea evolution. Read-only.

The topic is everything after `trace` in `$ARGUMENTS`.

1. Search the entire vault for all mentions — explicit references, related concepts, adjacent ideas.
2. Sort chronologically.
3. Map the evolution:

- **First appearance**: when and where first mentioned
- **Early framing**: how it was initially thought about
- **Turning points**: moments thinking shifted — new info, changed opinion, deeper understanding
- **Current state**: what most recent notes say
- **Trajectory**: where thinking seems to be heading

Present as a chronological narrative with quotes at each stage. Show the arc, not just snapshots.
Do not create or modify any files.

---

## connect

Find hidden bridges between two domains. Read-only.

The domains are everything after `connect` in `$ARGUMENTS` (expect format like "A and B" or "A, B").

1. Read notes related to each domain separately.
2. Identify structural similarities:
   - Shared mental models or frameworks applied to both
   - Similar problems in both domains
   - People, tools, or resources appearing in both
   - Analogies that transfer
   - Skills from one that solve problems in the other
3. Look for connections already hinted at but never developed.
4. Generate novel connections not yet made.

Present:

- **Existing bridges** (with note quotes)
- **Latent bridges** (implied but unstated)
- **Novel bridges** (new, based on patterns)
- For each: one concrete action or experiment

Prioritize surprising and actionable.
Do not create or modify any files.

---

## ideas

Deep idea generation. Read-only.

1. Read recent notes (last 30 days) plus all project notes and wiki Home.
2. Identify:
   - Problems mentioned but unsolved
   - Tools or systems wished for
   - Recurring interests not acted on
   - Skills building that could combine
   - People mentioned for connection
   - Content reacted strongly to

3. Generate ideas in categories:
   - **Build**: tools, projects, systems to create
   - **Connect**: people to reach out to, communities, collaborations
   - **Learn**: skills or domains to explore based on trajectory
   - **Write**: content ideas from unique intersection of interests
   - **Experiment**: small bets to run in the next 1–2 weeks

For each: one sentence, why it fits specifically (cite notes), and a concrete first step.
Aim for 10–15 ideas. Prioritize novel over obvious.
Do not create or modify any files.

---

## handoff

Bridge vault project context into a date-stamped handoff file in the repo's `.claude/handoffs/` directory.

The project name is everything after `handoff` in `$ARGUMENTS`.

### 1. Resolve repo path

1. Read `.claude/local.md` in the vault root — look up `<project>` under `repos:`.
2. Full path = the mapped value. If the project isn't listed, tell the user to add it to `.claude/local.md` and stop.

### 2. Gather implementation-ready items

Read the project's main note and today's daily note. Also check `{repo_path}/.claude/checkins/` — read the most recent checkin file (by date in filename) and pull any **Carry-forward** items not already in the vault note. Extract only items that are:
- Concrete and immediately actionable (a specific thing to run, write, or fix)
- Not planning, scoping, or decision tasks — those stay in the vault

Sources to check (in priority order):
- `### Next` section of the project note
- **Carry-forward** section of the most recent checkin in `{repo_path}/.claude/checkins/`
- Unchecked `- [ ]` tasks in today's daily note tagged to this project
- Any `TODO` / `FIXME` in supporting project notes (e.g. architecture, phases)

### 3. Write handoff file

Target path: `{repo_path}/.claude/handoffs/<project>-YYYY-MM-DD.md` (today's date).

If that file already exists, increment a numeric suffix until the path is free: `<project>-YYYY-MM-DD-2.md`, `<project>-YYYY-MM-DD-3.md`, etc. Never overwrite an existing file.

```markdown
---
project: <project>
date: YYYY-MM-DD
---

## Next

- <item 1>
- <item 2>
...
```

Keep items terse and specific. One action per line. No planning prose.

### 4. Confirm

Report the file path written and the full repo path used.

---

## checkin

Write a session summary for the current repo. Run this at the end of a coding session. No arguments needed.

### 1. Determine paths

1. Project name = current working directory name.
2. Checkin file path: `.claude/checkins/<project>-YYYY-MM-DD.md` (today's date, relative to repo root).

### 2. Gather session content

Check `{repo_root}/.claude/handoffs/` for the most recent handoff file (by date in filename) and read it. Use its **Next** items as the baseline of what was planned going into this session — items completed from it belong in **Done**, items not started belong in **Carry-forward** (unless obsolete).

Then collect from the current session context:
- **Done**: completed tasks, fixes, implementations — specific and concrete. Cross-reference against the handoff's Next items: prefix with `(handoff)` if it was planned there.
- **Decisions**: architectural or design choices made, with brief rationale
- **Carry-forward**: items started but not finished, or next concrete steps surfaced. Include unstarted handoff items that are still relevant.
- **Questions**: unresolved questions that need vault-side planning or user decision

Only include items with substance. Skip boilerplate, tooling noise, and process steps.

### 3. Write checkin file

Target path: `{repo_root}/.claude/checkins/<project>-YYYY-MM-DD.md` (today's date).

If that file already exists, increment a numeric suffix until the path is free: `<project>-YYYY-MM-DD-2.md`, `<project>-YYYY-MM-DD-3.md`, etc. Never overwrite an existing file.

```markdown
---
project: <project>
date: YYYY-MM-DD
---

## Done
- <item>

## Decisions
- <decision> — <rationale>

## Carry-forward
- <item>

## Questions
- <question>
```

Omit empty sections. Keep items terse — one line each.

### 4. Confirm

Report the file path written and a count of items in each section.
