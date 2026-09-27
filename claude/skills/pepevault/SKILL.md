---
name: pepevault
description: Read and write Sean's Obsidian vault at ~/Documents/PepeVault. Use at the START of project work to pull context (project note, Master List, prior dead ends) and defines the agentic-log format that the scribe subagent writes. Triggers - "check my vault", "what does my vault say about X", or starting real work in a repo. For hand-offs and logs use the handoff skill instead.
---

# PepeVault

Vault root: `~/Documents/PepeVault` (Obsidian, PARA-ish, synced by Syncthing).

```
00-Master List.md          the ONLY file that holds tasks (NOW max 3, NEXT max 7)
01-Journal/A - Daily/      YYYY-MM-DD.md dailies
01-Journal/C - Logs/       human-written event logs
01-Journal/D - Agentic Logs/   <- you write here
02-Projects/               active | Parked/ | Done/ | Deprecated/  (folder = status)
03-Library/Permanent/      transferable technique notes
99-Meta/zz-Templates/      ProjectTemplate.md, DailyJournal.md
```

## Mode 1 — Pull context (start of work)

Run before planning or non-trivial changes. Cheap; do it in one Bash call.

```bash
V=~/Documents/PepeVault
ls "$V/02-Projects" "$V/02-Projects/Parked" "$V/02-Projects/Done"
grep -ril '<project-or-repo-name>' --include='*.md' "$V" | head
sed -n '18,60p' "$V/00-Master List.md"          # NOW / NEXT
ls -t "$V/01-Journal/D - Agentic Logs" | head -5
```

Then read, in order: the project note (Log, *What failed and why*, *If picking this back
up*), the most recent agentic log for this repo, any hit in `03-Library/Permanent/`.

Say what you found in one or two lines — "vault says X failed in June because Y" — rather
than dumping the note. If there's no project note and the work is more than a one-off,
mention that a note using `99-Meta/zz-Templates/ProjectTemplate.md` would be worth it;
don't create one unprompted.

## Mode 2 — Write the log (end of work)

> **The `scribe` subagent writes these logs**, via the `handoff` skill. Working agents should
> not write them directly. This section is the format the scribe follows.

**One file per repo per day**, appended to across sessions:

`01-Journal/D - Agentic Logs/YYYY-MM-DD <repo-name>.md`

If the file exists, append a new `##` section — never rewrite what's there. Get the real
date and time from `date +%F` / `date +%H:%M`, and the commit from `git rev-parse --short HEAD`.

New file:

```markdown
---
id: YYYY-MM-DD <repo-name>
aliases: []
tags: [agentic-log]
---
# YYYY-MM-DD — <repo-name>

**Repo:** `<path>` @ `<sha>` (<branch>)
**Project note:** [[Project Name]]   <!-- omit the line if there isn't one -->

## HH:MM — <one line: what this session actually was>

**Did**
- <change, with the file path>

**Decided** — <the choice and the *why*. Skip the heading if nothing was decided.>

**What failed, and why**

| Attempt | Result | Why it failed |
| :--- | :--- | :--- |
| | | |

**Left open** — <what the next session walks into>
```

Rules:

- **Write the mechanism, not the narrative.** "CNPG rejected the bootstrap because the
  secret key must be `password`, not `pass`" is worth keeping. "Worked on the database"
  is not. If a session yields nothing re-derivable, log two lines or skip it.
- **Never write a checkbox.** Tasks live only in `00-Master List.md`. If something belongs
  there, end your reply with a proposed one-line NOW/NEXT item and let Sean add it —
  NOW is capped at 3, so adding one means demoting one.
- **Drop empty sections.** No blank *What failed* table if nothing failed.
- **Don't touch the project note** unless asked. When a phase genuinely completed, offer
  to collapse it into one dated line in that note's Log.
- If the technique generalizes past this project, say so and offer a
  `03-Library/Permanent/` note — that's where it stays findable.
- Never edit `*.sync-conflict-*` files.
