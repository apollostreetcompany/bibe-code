---
name: plan-create
description: Create reference-first Bible reading plans for a user's goal without exposing licensed Bible text to AI prompts.
---

# Plan Create

Use this skill when the user asks for a Bible reading plan, topical plan, memory verse plan, or spaced repetition review plan.

Plan generation policy:
- Generate plans from user goals, canonical references, themes/tags, schedule preferences, and progress history.
- Do not include licensed (non-WEB/KJV) Scripture text, cached licensed passage HTML, copyright fields, or FUMS tokens in prompts.
- Fetch display text only after the reference-first plan exists.
- Prefer deterministic, auditable plan structures over opaque prose.
- If the goal names a Bible book or explicit range, use the deterministic compiler first. For example, "Read Genesis" becomes Genesis 1 through Genesis 50; long chapters are split into parts.
- If the goal is ambiguous or topical, the active LLM may draft a reference-only plan, but it must show the proposed title, cadence, and references to the user for confirmation before saving or building it.
- If the host can save plans (the `bible-coder` command or the local `bible-coder-mcp` server), save confirmed agent-authored plans with explicit references, not generated Scripture text.

If Bibe Code MCP tools are available:
- `build_reading_plan` turns a goal, or confirmed references, into a day-by-day plan. It takes `days` (spread the goal across that many days) and `versesPerReading` (the most verses in one reading, 1-100). `get_next_reading` gives what comes next and needs the same `versesPerReading`.
- These tools save nothing: show the plan, and suggest the user note their last reading so they can continue later.
- With the local `bible-coder-mcp` server, use `goal_update`, `goal_status` and `plan_create`, which do save.

If the `bible-coder` command is available:
- `bible-coder goal` and `bible-coder goal update --goal <goal>` (add `--reference <ref>` for confirmed topical references)
- `bible-coder plan create --goal <goal> [--days <n>] [--reference <ref>...]`
- `bible-coder plans [--all] [--json]`, `bible-coder plan use <number|title|id>`
- `bible-coder plan pause|resume|archive|restore [number|title|id]`
- `bible-coder skip` / `bible-coder undo`
- `bible-coder progress`, `bible-coder review`

For plan maintenance with the CLI, list plans first and identify the user's intended plan by number or title. Paused/archived plans do not drive readings under answers. Resume/restore select a plan when none is followed; otherwise use `plan use`. Skip advances without read credit. Undo reverses the chosen plan's latest read/skip locally; it does not retract progress on other synced devices.

Agent workflow:
1. Restate the user's goal and classify it as explicit, deterministic, or ambiguous.
2. For explicit/deterministic goals, call the CLI or MCP plan tool and show the resulting reference list summary.
3. For ambiguous goals, propose canonical references only, ask for confirmation, then save or build the plan from the confirmed references.
4. Never pass licensed Bible text into an LLM prompt while creating the plan.
