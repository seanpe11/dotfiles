# Claude Code config (canonical copies)

Symlinked into `~/.claude`. Restore on a new machine:

```sh
DF=~/Documents/projects/dotfiles/claude
mkdir -p ~/.claude/agents ~/.claude/skills ~/.claude/handoffs
ln -sf $DF/CLAUDE.md                ~/.claude/CLAUDE.md
ln -sf $DF/agents/scribe.md         ~/.claude/agents/scribe.md
ln -sf $DF/agents/edge-hunter.md    ~/.claude/agents/edge-hunter.md
ln -sf $DF/agents/sim-coach.md      ~/.claude/agents/sim-coach.md
ln -sfn $DF/skills/pepevault        ~/.claude/skills/pepevault
ln -sfn $DF/skills/handoff          ~/.claude/skills/handoff
ln -sfn $DF/skills/simcoach         ~/.claude/skills/simcoach
```

- `scribe` — vault scribe subagent; only runs on explicit hand-off.
- `handoff` — working-session skill: writes the brief, delegates to scribe.
- `pepevault` — vault read procedure + agentic-log format.
- `edge-hunter` — strategy/edge research subagent.
- `sim-coach` — iRacing coach subagent; runs the active goal through a 3-block PEAK week.
- `simcoach` — the coaching protocol, templates and vault write-back paths.
