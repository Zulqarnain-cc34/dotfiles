<div align="center">
  <h1>Zsh</h1>
  <p><em>The shell — lazy-loaded, framework-free, quick to start.</em></p>
  <a href="https://github.com/zsh-users/zsh"><img src="https://img.shields.io/badge/upstream-zsh--users%2Fzsh-c678dd?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/zsh-users/zsh/stargazers"><img src="https://img.shields.io/github/stars/zsh-users/zsh?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-MIT--like-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

> Powered by **[Zsh](https://www.zsh.org)** — by the Zsh development group. ❤️

A framework-free setup — no plugin manager, no bloat, just a fast shell that still feels modern. The highlights:

- **Vi mode**, with a cursor that shifts shape between insert and command mode
- **Autosuggestions** that complete from your history as you type
- **Syntax highlighting** right on the command line
- **Shared history** across every session (50k lines, kept in `~/.logs/zsh/history`)
- **Lazy-loaded `nvm`**, so Node tooling never slows startup
- **fzf** wired in, backed by ripgrep (`rg --files --hidden`) and themed to match
- A **`yazi`** shortcut that drops you back wherever you left the file manager

### Keybindings

On top of the standard vi bindings:

| Key | Action |
|-----|--------|
| `Ctrl-R` | incremental history search (pattern) |
| `Ctrl-V` | edit the current command line in `$EDITOR` (nvim) |
| `Ctrl-L` / `Ctrl-H` | clear screen / show history |
| `ci"` `ci(` `di{` … | vi text objects for quotes and brackets (`a`/`i`, visual + operator-pending) |
| `h` `j` `k` `l` | navigate the tab-completion menu |

### Where things live

`ZDOTDIR` is set to `~/.config/zsh` (by [`.zprofile`](../.zprofile)), so Zsh loads its config from there:

- [`.zshrc`](.zshrc) — interactive setup: keybindings, history, vi mode, plugins
- [`.zshenv`](.zshenv) — environment variables and `PATH` (sourced for every shell, so it stays cheap; `vivid`'s `LS_COLORS` is cached rather than regenerated each start)
- **Aliases** are sourced separately from `~/.aliases/aliases`
- **Plugins** (`zsh-autosuggestions`, `zsh-syntax-highlighting`) are git-cloned into `~/.config/zsh/plugins` on first launch — no plugin manager involved
