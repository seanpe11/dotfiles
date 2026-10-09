# ansible — provision the machines Sean types on

Scope: **workstations.** Servers and the household/personal k3s clusters are
`pemily-homelab`; that repo's `CLAUDE.md` says not to build personal tooling there,
so it lives here instead, next to the configs it deploys.

```sh
cd ansible
ansible-playbook site.yml --limit pegasus-wsl --ask-become-pass
ansible-playbook site.yml --limit pegasus-wsl --tags user      # no sudo needed
ansible-playbook site.yml --check --diff                       # dry run
```

| Role | Does |
| :--- | :--- |
| `wsl` | `/etc/wsl.conf` (`systemd=true`), inotify sysctl, clock sync, linger |
| `base` | packages from `group_vars/all.yml`, docker group |
| `shell` | fish + starship + zoxide, default shell |
| `editor` | nvim config, LSP/treesitter prerequisites |
| `tmux` | `.tmux.conf`, tpm, tmuxp sessions, `tmux-services` unit |
| `vault` | syncthing, PepeVault folder, linger |
| `agentic` | claude-code, opencode, `agentic-dotfiles/install.sh` |

Roles are **empty stubs**. See `../CLAUDE.md` for what each must do and the
blockers to clear first.
