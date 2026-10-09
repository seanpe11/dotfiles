# dotfiles — captain's rules

This repo is **machine config, and now the Ansible that deploys it.** The deliverable is a
machine Sean can type on without noticing it, provisioned from nothing in one command.

## Scope boundaries — three repos, don't blur them

| Repo | Owns |
| :--- | :--- |
| **dotfiles** (this one) | configs + the playbook that deploys them to **workstations** |
| `pemily-homelab` | donnager's host layer and the family/personal k3s clusters. Its `CLAUDE.md` says not to build personal tooling there |
| `agentic-dotfiles` | Claude Code / opencode config. Moved out deliberately in `9015153` — it changes on a different cadence |

`MANIFEST.md` is the prose version of `ansible/group_vars/all.yml:dotfiles_links`.
**Keep the two in step.** If a path moves in one, move it in the other in the same commit.

## Why this exists

Sean works at pegasus (Ryzen 9700X / RTX 5070, Arch on WSL2) and SSHes to rocinante to do
it. That SSH is laggy even at 7 ms over the LAN. The fix is to make pegasus a first-class
dev machine rather than a terminal, so the playbook's success condition is:
**he stops SSHing to rocinante out of necessity.**

## Blockers — clear these before writing roles

1. **`~/.config/nvim` has 5 uncommitted files.** The live config holds the obsidian.nvim
   path fixes (daily-note folder, `templates.folder`, `note_id_func`). Its remote
   `github.com/seanpe11/nvim-config` is at `40504ec` from **2026-01-08**. Provision pegasus
   today and it gets a config without those fixes. **Commit and push first.**
2. **Two clones of this repo, four years apart.** `~/dotfiles` is at `2e9d3cd` (2022-09-03)
   and points at `github.com/seanpe11/dotfiles`; `~/Documents/projects/dotfiles` is at
   `9015153` (2026-09-27) and points only at `pemily@donnager:git/dotfiles.git`. Same
   history, so it fast-forwards — but **GitHub is four years stale.** Pick one path and one
   remote; the playbook must not clone the 2022 one.
3. **`nvim/` exists both here and as its own repo.** Decide which is authoritative. A
   submodule or a clone in the `editor` role — not two copies that drift.
4. **fish config is tracked nowhere.** `~/.config/fish/` (config.fish, conf.d, functions,
   completions) is live-only on rocinante. Add it; it is the shell.
5. **`starship.toml` is tracked but has no live counterpart** at `~/.config/starship.toml`,
   while starship 1.18.2 is installed. Find where it actually reads from.
6. **`config/hypr/hyprland.conf` differs from live.** Sean moved to Hyprland; live is newer.

## WSL — the things that will bite

- **Never put the vault or repos under `/mnt/c`.** drvfs is an order of magnitude slower on
  small-file work, which recreates the exact lag this repo exists to remove. Everything on ext4.
- **Arch on WSL does not enable systemd.** `/etc/wsl.conf` → `[boot] systemd=true`, then
  `wsl --shutdown`. Without it there is no `systemctl --user`, so no tmux-services, no syncthing unit.
- **inotify limits.** On 2026-10-09 syncthing held 94,751 of rocinante's 119,478 watches (79%)
  indexing 759,905 files, and it read as desktop input lag. Set the sysctls in the `wsl` and
  `base` roles, and ship a `.stignore` with the vault/repo folders. WSL defaults are lower
  than Fedora's.
- **Clock drift after Windows sleep** breaks TLS and git. Handle it.
- WSL terminates the distro when the last process exits; linger plus systemd keeps user units
  alive, but confirm it survives closing the terminal before calling the role done.

## What is already true — don't rebuild it

- **PepeVault is already on pegasus**: Syncthing folder `xuuip-ekrww`, 99.97% complete,
  connected over the LAN at `192.168.8.113:22000`. The `vault` role's job is to make that
  survive reboots and point at an ext4 path — not to move data.
- Tailscale already runs inside the WSL instance (`seanpe-pegasus`, 100.75.193.78, online).
- `tmuxp/*.yaml` and `.tmux.conf` in this repo are **byte-identical to live** on rocinante.
  They are good sources of truth.

## Conventions

- Tags: `user` needs no sudo, `root` and `wsl` do. Same split as `pemily-homelab`.
- Idempotence is the bar. Every role must be safe to run twice; `--check --diff` must be clean
  on a provisioned host.
- Package names differ between pacman and dnf (`fd` vs `fd-find`, `github-cli` vs `gh`).
  The lists in `group_vars/all.yml` are **unverified** — check each before trusting a run.
- ⚠️ `services` is load-bearing on rocinante: the cloudflared tunnel and ttyd are how Sean
  reaches that machine from his phone. Never restart it as a side effect. Warn before touching it.

## Context

`~/Documents/PepeVault` holds why. Relevant: `02-Projects/Devtooling Playbook.md`,
`02-Projects/HomeLab Project.md`, `02-Projects/Donnager.md`, and `MANIFEST.md` here.
