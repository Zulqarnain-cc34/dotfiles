<div align="center">
  <h1>Zsh</h1>
  <p><em>The shell — lazy-loaded, framework-free, quick to start.</em></p>
  <a href="https://github.com/zsh-users/zsh"><img src="https://img.shields.io/badge/upstream-zsh--users%2Fzsh-c678dd?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/zsh-users/zsh/stargazers"><img src="https://img.shields.io/github/stars/zsh-users/zsh?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-MIT--like-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

> Powered by **[Zsh](https://www.zsh.org)** — by the Zsh development group. ❤️

The primary interactive shell — no framework, no plugin manager, just two files and a couple of plugins cloned straight from git on first run.

[`.zshrc`](.zshrc) is where the shell actually feels lived-in: vi mode via `bindkey -v`, with a cursor that changes shape between insert and command mode, and `select-quoted` / `select-bracketed` so text objects like `ci"` and `di{` work the way they do in Vim. History is shared and extended, kept under `~/.logs/zsh/history`. fzf and autojump are wired in when present, `nvm` is lazy-loaded so it never slows startup, and a small `yazi` wrapper hands you back wherever you left the file manager via cd-on-exit. The two plugins — `zsh-autosuggestions` and `zsh-syntax-highlighting` — clone themselves into `~/.config/zsh/plugins/` the first time an interactive shell starts, then source from there.

[`.zshenv`](.zshenv) handles the environment: editor, terminal and the rest of the usual exports, PATH assembled and de-duplicated with `typeset -U` (Go, pnpm, and local bins folded in), fzf defaults, and `less` termcap colours for readable man pages. It also caches `vivid`'s `LS_COLORS` to `${XDG_CACHE_HOME}/vivid-one-dark.lscolors` and only regenerates when the `vivid` binary is newer than the cache — since `.zshenv` is sourced for non-interactive shells too, that shortcut keeps startup quick.

### Setup

`ZDOTDIR` points at `~/.config/zsh`, so both files live there once linked. You'll want `zsh` itself, plus `starship` and `git` (git does the plugin cloning). Everything else is used only when it's installed: `vivid`, `fzf`, `autojump`, `yazi`, `nvm`, and `ripgrep` (which backs the fzf file command). A Nerd Font such as JetBrains Mono or Iosevka rounds it out.

A note on the prompt: a [`starship.toml`](../starship.toml) sits at the repo root, but these files don't currently contain a `starship init` line, so wire that up yourself if you want the Starship prompt live. For the colours, delete the vivid cache file to force a refresh; env and PATH changes go in [`.zshenv`](.zshenv), keybindings and functions in [`.zshrc`](.zshrc).
