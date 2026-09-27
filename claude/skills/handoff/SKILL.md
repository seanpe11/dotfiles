---
name: handoff
description: Hand the current project session off to the scribe subagent. Use when Sean says "/handoff", "hand off", "time to hand off", "park this", "park <project>", or "write the log". Writes a raw brief from THIS session's context, then delegates verification, the agentic log, and (if parking) the project note to the scribe.
---

# Handoff

You are the working agent. You hold the one thing nobody else can recover: *why* things
happened in this session. Your job is to get that out of your context and into a brief,
then let the `scribe` subagent verify it and write the vault record. **Do not write the
vault log yourself.**

## 1. Write the brief

Path: `~/.claude/handoffs/$(date +%F-%H%M) <repo-name>.md`

Write it **from your memory of this session**, not by re-reading files to reconstruct it.
Raw is fine; the scribe formats. Sections:

```markdown
# Handoff brief — <repo-name>
Mode: log | park
Repo: <absolute path>   Branch: <branch>   HEAD: <short sha>
Project note: [[<name>]] or "none"
Session span: <start> → <end>

## What this session was
<one line>

## Did
- <change> — `<file path>`

## Decided
- <choice> — because <why>

## Dead ends
| Attempt | Result | Mechanism / verbatim error |
| :--- | :--- | :--- |

## Claims to verify
- <anything you believe but did not check this session: "pushed", "tests pass", "units running", "data complete">

## Uncommitted state
<what's uncommitted and how it should be grouped into commits>

## Running infrastructure
<units, timers, cron, daemons — what they write; should they keep running while parked?>

## Artifacts to review
- `<file>` — <why Sean should open it>

## Left open
- <what the next session walks into>

## If picking this back up
1. <first thing to read or run>
```

Rules:
- **Verbatim error text** in *Dead ends* — the exact message, not a paraphrase.
- Anything you didn't verify goes under *Claims to verify*, not *Did*.
- Measured numbers keep their units and sample sizes.

## 2. Delegate to the scribe

Invoke the `scribe` subagent with:
- the brief path
- the repo path
- the mode (`park` only if Sean said park)

## 3. Relay

Report the scribe's discrepancies first, then what it wrote, then the decisions Sean needs
to make and the proposed Master List line. Don't add a Master List item yourself.
