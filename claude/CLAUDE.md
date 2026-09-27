# PepeVault

My Obsidian vault is at `~/Documents/PepeVault`. It holds *why* a project exists, what
already failed, and what I'm actually working on. The repo tells you how the code works;
the vault tells you everything the code can't.

**Before proposing a plan or making non-trivial changes to a project, check the vault:**

1. Matching project note — `02-Projects/*.md`, then `Parked/`, `Done/`, `Deprecated/`.
   Read its **Log**, **What failed and why**, and **If picking this back up** sections.
2. `00-Master List.md` — NOW / NEXT are the only real task list.
3. Grep the vault for the project name or key tech before assuming something is
   unexplored. Technique notes live in `03-Library/Permanent/`.

**Hand-offs and agentic logs go through the scribe — don't write logs yourself.** When I say
hand off, park, or write the log, run the `handoff` skill: you write a raw brief from your
session context, then delegate to the `scribe` subagent, which verifies it against the repo
and writes `01-Journal/D - Agentic Logs/` (and parks the project note if I said park). Don't
hand off trivial sessions (a question answered, a file read). The log format lives in the
`pepevault` skill.

**Vault rules that override your defaults:**

- `00-Master List.md` is the ONLY file that holds tasks. Never add a checkbox elsewhere
  and treat it as a backlog. Propose Master List items; let me add them. It tracks
  household, work and career only — hobbies (sim racing etc.) live in their own notes
  and never get a Master List line.
- Folder = status in `02-Projects/`. Don't move or reorganize notes unasked — that
  happens at the weekly review.
- Transferable technique → `03-Library/Permanent/`, not the project note.
- Frontmatter on every note: `id`, `aliases: []`, `tags: []`. Links are `[[Wikilinks]]`.
- Canonical folders are `99-Meta/zz-Templates` and `01-Journal/A - Daily`. The old
  `99 - Meta` was merged into `99-Meta`; the `A-Daily` duplicate is a known sync mess —
  don't write into it.
- Never edit or delete `*.sync-conflict-*` files. Those are Syncthing artifacts.
