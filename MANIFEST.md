# What lives here, and where it belongs on a machine

| Repo path | Deploy to | Notes |
| :--- | :--- | :--- |
| `claude/` | `~/.claude/` | Agents, skills, CLAUDE.md. Symlinked, not copied. `settings.json` is deliberately NOT tracked — it holds machine-specific policy. |
| `nvim/` | `~/.config/nvim/` | LazyVim + obsidian.nvim + obsidian-query.nvim |
| `tmuxp/` | `~/.tmuxp/` | Session definitions. `services` is load-bearing: cloudflared + ttyd. |
| `systemd/user/` | `~/.config/systemd/user/` | `tmux-services.service` starts the `services` session at boot. Needs `loginctl enable-linger`. |
| `bin/` | `~/.local/bin/` | `ttyd-nerd` (patched ttyd launcher), `start-services-session` (idempotent tmuxp wrapper) |
| `.tmux.conf` | `~/.tmux.conf` | tpm + resurrect + continuum |
| `config/`, `alacritty/`, `rofi/`, … | `~/.config/…` | Older desktop config, pre-2025 |

## Not tracked, on purpose

- `~/.claude/settings.json` — machine policy, autoMode rules, environment detail
- The patched `ttyd` binary (2 MB) — rebuild from source; `bin/ttyd-nerd` expects it at `~/.local/bin/ttyd`
- `~/.local/share/venv-tmuxp/` — recreate with `python3 -m venv` + `pip install tmuxp`
