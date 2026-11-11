# Fish

An experimental Fish config, kept around for tinkering rather than daily use — Zsh ([`zsh/`](../zsh)) is the primary shell here. Fish just gets a corner to play in.

Fair warning: this was copied from a **Void Linux** setup and never fully adapted to Arch/BSPWM, so it still carries Void-isms and stale references. Treat it as a scratch config. You'll find `abbr v xbpsui`, `XBPS_DISTDIR`, and other `XBPS` abbreviations (Void's package manager), an `abbr ls 'exa'` where the rest of the repo standardised on `eza` (`validate.sh` rejects `exa`), and a `functions/fzf_key_bindings.fish` symlink pointing at a dead `/home/jojo/.fzf/...` path. Vendored plugins — pure prompt, z, fzf, foreign-env — live under `conf.d/`, `functions/`, and `completions/`.

Underneath the cruft it does configure a real shell: vi key bindings, an empty greeting, `EDITOR=nvim`, `TERMINAL=kitty`, `BROWSER=qutebrowser`, a generous set of XDG base-directory env vars, a `startx` on login (vt1) block, and plenty of abbreviations for git, mpv, ncmpcpp, aria2c torrents, and youtube-dl.

### Setup

Install `fish`. Plugins listed in `fishfile` are managed by Fisher (`z`, `pure`, `fzf`, `plugin-foreign-env`, `kubectl-completions`). `setup.sh` symlinks this directory to `~/.config/fish` but does not set it as the login shell. To experiment, run `fish` interactively or `chsh -s $(which fish)` by hand — and expect to fix the Void-specific lines first. For real work, prefer `zsh/`.
