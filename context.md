# PROJECT CONTEXT — dotfiles_v2

**Last Updated:** 2026-05-15 (full-repo audit)  
**Version:** v2 (stable daily driver; active maintenance)

---

## 1. PROJECT OVERVIEW

- **Purpose:** Personal Linux dotfiles repository (`dotfiles_v2`) that version-controls, documents, and deploys a cohesive desktop and CLI environment. Goals: aesthetic “rice,” fast dev workflow, reproducibility across machines via symlinks—not a distributable app.
- **Audience / problem:** Built for the author (Zulqarnain / `zulqarnain-cc34`) on **Arch Linux**. Solves “new install or new machine” setup, keeps WM/shell/editor/launcher configs in sync, and encodes years of keybindings, themes, and tool integrations.
- **Philosophy:** Minimal tiling WM (BSPWM), keyboard-driven workflow, Nord-ish borders + Tokyo Night / Gruvbox accents in terminals, `lazy.nvim` for IDE-like Neovim, Rofi as hub for launchers/menus, heavy use of terminal TUIs (ncmpcpp, newsboat, neomutt).
- **Tech stack (summary):** **X11** session with **BSPWM 0.9.12** + **sxhkd**, **Polybar 3.7.2**, **picom** (blur/opacity), **dunst** notifications, **Zsh 5.9** + **Starship** + autosuggestions/syntax-highlighting, **Kitty 0.46.2** (README primary; `.profile` still sets `TERMINAL=alacritty`), **Neovim 0.12.2** + **lazy.nvim**, **Rofi 2.0**, file tools **Yazi**, **lf**, **ranger**, media **MPD/ncmpcpp/mpv**, browser **Firefox** + **qutebrowser** configs, optional **fish** shell config.
- **Maturity:** Long-lived repo (commits back to 2021+); **stable daily driver** on author hardware. ~2,000+ tracked files (many vendored Zsh themes, Rofi `.rasi` themes). Ongoing tweaks (Neovim plugins, Yazi, Rofi ribbon colors). Not a 1:1 clone-and-forget kit—multi-monitor BSPWM block is **hardware-specific**.

---

## 2. ARCHITECTURE

### High-level boot flow (ASCII)

```
Login (display manager / startx)
    │
    ▼
.xprofile ──► xrdb ~/.Xresources
    │
    ▼
bspwm (bspwmrc) ──► monitors/desktops/rules
    │                    │
    ├── sxhkd (global keys)     ├── picom (compositor)
    ├── dunst (notifications)   ├── polybar (status bar)
    ├── redshift, clipmenud   ├── conky (optional)
    └── xset / xmodmap        └── external: ~/bin/bash_scripts/random-wallpaper.sh
```

### Component interaction

| Layer | Role | Config entry |
|--------|------|----------------|
| Session | X resources, DPI | `.xprofile`, `.Xresources` |
| WM | Layout, rules, borders | `bspwm/bspwmrc` |
| Keys | All hotkeys | `sxhkd/sxhkdrc` |
| Chrome | Bar, blur, notify | `polybar/`, `picom.conf`, `dunst/` |
| Shell | PATH, aliases, prompt | `.zprofile` → `zsh/.zshrc`, `starship.toml` |
| Apps | Per-tool XDG configs | Symlinked under `~/.config/` via `setup.sh` |

### Config data flow

1. Clone repo to e.g. `/home/alpha/etc/linuxConfig/dotfiles_v2`
2. Run `./setup.sh` from repo root (`$PWD` must be repo dir)
3. Script creates **symlinks** only if target does not exist (`[ ! -d ... ] && ln -s`)
4. Apps read from `~/.config/<app>` or `$HOME` dotfiles

**Design decisions**

| Decision | Why |
|----------|-----|
| Symlinks via `setup.sh` | Live edit in repo; git tracks changes; no copy drift |
| BSPWM over DE | Lightweight, scriptable, keyboard tiling |
| X11 (not Wayland) | Stack built around picom, sxhkd, polybar IPC—no Wayland migration |
| `ZDOTDIR=$HOME/.config/zsh` | Keeps shell config inside XDG tree with other dotfiles |
| Separate `dunstrc` at repo root + `dunst/` | Legacy: root `dunstrc` exists; `setup.sh` links `dunst/` dir only |
| Hardware-specific `bspwmrc` monitors | Author runs 3 outputs; generic Chinese-numeral fallback runs first then overridden |

---

## 3. TECH STACK & VERSIONS

Versions below from **author machine** (`pacman -Q`, May 2026). Other installs may differ.

| Tool | Version | Role |
|------|---------|------|
| bspwm | 0.9.12-1 | Tiling WM |
| sxhkd | 0.6.3-1 | Hotkey daemon |
| polybar | 3.7.2-2 | Status bar |
| rofi | 2.0.0-1 | Launcher / menus |
| kitty | 0.46.2-1 | GPU terminal (README) |
| alacritty | 0.16.1-1 | Alt terminal (`.profile`) |
| neovim | 0.12.2-1 | Editor / IDE |
| picom | 13-2 | Compositor (dual_kawase blur) |
| dunst | 1.13.2-1 | Notifications |
| zsh | 5.9-6 | Login shell |
| mpd | 0.24.10-1 | Music daemon |
| ncmpcpp | 0.10.1-8 | MPD TUI client |
| yazi | 26.5.6-2 | TUI file manager |
| fish | (system) | Alt shell config in repo |
| qutebrowser | (PyQt) | Python `config.py` |
| ranger | (system) | Python rc + rifle |
| lf | (system) | Shell-based file manager |
| newsboat | (system) | RSS TUI |
| transmission | (system) | torrent daemon JSON config |
| fastfetch | (system) | neofetch successor; zsh startup |
| conky | 1.22.2-1 | desktop HUD |
| zathura | (system) | PDF viewer |
| imv | (system) | image viewer |
| vivid | (system) | LS_COLORS generator |

**Notable custom setups**

- **Neovim:** `lazy.nvim` bootstrapped in `nvim/lua/plugins.lua`; LSP via `nvim-lspconfig` + per-lang files in `nvim/lua/lsp/`; formatters via `efm` configs in `nvim/lua/efm/`.
- **Rofi ribbon launcher:** Random theme + color on each invoke (`launcher.sh` sed-patches `colors.rasi`).
- **Zsh plugins:** Cloned on first run into `~/.config/zsh/plugins/` (gitignored); not vendored in repo.
- **Yazi:** Plugins directory gitignored; flavor + `yazi.toml` opener rules; preview via `code` for many mime types.
- **Polybar:** Modular INI (`config.ini` includes `colors.ini`, `bars.ini`, `modules.ini`, `user_modules.ini`); custom scripts under `polybar/scripts/`.
- **w3m:** Extensive CGI bin under `.w3m/` for fzf/surfraw integration.

**Package lists:** `packages/v2/pacman-packages.txt` (full Arch install snapshot), plus `yay-packages.txt`, `pip-packages.txt`, `npm-packages.txt`, `go-packages.txt`. `packages/v1/` is older snapshot.

---

## 4. PROJECT STRUCTURE

This repo is organized as **one top-level folder (or root dotfile) per Linux program**. Almost everything is deployed via `setup.sh` symlinks into `~/.config/` or `$HOME`.

### Master config catalog

| Repo path | Program | Symlink target (`setup.sh`) | Main config file(s) |
|-----------|---------|----------------------------|---------------------|
| `bspwm/` | BSPWM window manager | `~/.config/bspwm` | `bspwmrc` |
| `sxhkd/` | Hotkey daemon | `~/.config/sxhkd` | `sxhkdrc` |
| `polybar/` | Status bar | `~/.config/polybar` | `config.ini`, `modules.ini`, `colors.ini` |
| `picom.conf` | Compositor (picom) | `~/.config/picom.conf` | `picom.conf` |
| `dunst/` | Notifications | `~/.config/dunst` | `dunstrc` |
| `conky/` | Desktop HUD widgets | `~/.config/conky` | `conky1/conkyrc1`, `conky2/conkyrc2`, `conky3/conkyrc` |
| `zsh/` | Zsh shell | `~/.config/zsh` + `~/.config/zsh/.zshrc` | `.zshrc`, `themes/` |
| `.zprofile` | Zsh login | *(file not in setup; source manually or copy)* | sets `ZDOTDIR` |
| `starship.toml` | Prompt | `~/.config/starship.toml` | `starship.toml` |
| `.profile` | Login env (all shells) | `~/.profile` | large PATH/XDG/FZF block |
| `.bashrc`, `.bash_profile` | Bash | `~/.bashrc`, `~/.bash_profile` | `.bashrc` |
| `fish/` | Fish shell (alt) | `~/.config/fish` | `config.fish`, `conf.d/`, `functions/` |
| `kitty/` | Terminal (primary in keys) | `~/.config/kitty` | `kitty.conf`, `config/` subdir |
| `alacritty/` | Terminal (alt) | `~/.config/alacritty` | `alacritty.toml` |
| `.tmux.conf` | Terminal multiplexer | `~/.tmux.conf` | `.tmux.conf` |
| `nvim/` | Neovim editor | `~/.config/nvim` | `init.lua` → `lua/*` |
| `rofi/` | Launcher / menus | `~/.config/rofi` | `launchers/`, `themes/`, `applets/` |
| `yazi/` | File manager (primary) | `~/.config/yazi` | `yazi.toml`, `keymap.toml`, `init.lua` |
| `lf/` | File manager (lf) | `~/.config/lf` | `lfrc`, `preview`, `cleaner` |
| `ranger/` | File manager (ranger) | `~/.config/ranger` | `rc.conf`, `rifle.conf`, `commands.py` |
| `mpv/` | Media player | `~/.config/mpv` | `mpv.conf` (if present), `scripts/*.lua` |
| `mpd/` | Music daemon | `~/.config/mpd` | `mpd.conf` |
| `ncmpcpp/` | MPD TUI client | `~/.config/ncmpcpp` | `config`, `bindings` |
| `newsboat/` | RSS reader | `~/.newsboat` | `config`, `urls` (urls may be local) |
| `mutt/` | Neomutt theme fragments | `~/.config/mutt` | various `*.muttrc` / `*.neomuttrc` |
| `.mutt/` | Neomutt account config | `~/.mutt` | `muttrc`, `accounts/`, `sidebar` |
| `qutebrowser/` | Keyboard browser | `~/.config/qutebrowser` | `config.py`, `themes/css/` |
| `firefox/` | Firefox chrome CSS | **Not in setup.sh** | `userChrome.css`, `firefox-sweet-theme/` |
| `zathura/` | PDF viewer | `~/.config/zathura` | `zathurarc` |
| `imv/` | Image viewer | `~/.config/imv` | `config` |
| `fastfetch/` | System info splash | `~/.config/fastfetch` | `config.jsonc`, `images/`, `ascii/` |
| `transmission-daemon/` | BitTorrent daemon | `~/.config/transmission-daemon` | `settings.json` |
| `.w3m/` | Text browser + CGI | `~/.w3m` | `config`, `cgi-bin/`, `user-agent/` |
| `surfraw/` | CLI search elvi | `~/.config/surfraw` | `conf`, `elvi/*`, `bookmarks` |
| `urlscan/` | URL picker TUI | `~/.config/urlscan` | `config.json` |
| `urlview/` | URL extractor | `~/.config/urlview` | `.urlview` |
| `ytfzf/` | YouTube fuzzy finder | `~/.config/ytfzf` | `conf.sh` |
| `Kvantum/` | Qt5 theme engine | `~/.config/Kvantum` | `kvantum.kvconfig`, `Otto/`, `Sweet/` |
| `vivid/` | LS_COLORS generator | `~/.config/vivid` | `themes/one-dark-modified.yml`, `keymap.toml` |
| `.dir_colors` | dircolors (legacy) | `~/.dir_colors` | `.dir_colors` |
| `mimeapps.list` | Default applications | `~/.config/mimeapps.list` | `mimeapps.list` |
| `.Xresources`, `.Xmodmap`, `.xprofile` | X11 session | `~/.Xresources`, etc. | xrdb, keymap, `xrdb` only in `.xprofile` |
| `.wgetrc` | Wget | `~/.wgetrc` | `.wgetrc` |
| `.gitconfig` | Git | `~/.gitconfig` | **gitignored** |
| `packages/v1`, `v2/` | Package manifests | *(not symlinked)* | `pacman-packages.txt`, etc. |
| `screenshots/` | README assets | *(not symlinked)* | PNG previews only |
| `context.md`, `prompt.txt` | Documentation | *(not symlinked)* | meta |
| `dunstrc` (repo root) | Dunst (orphan copy) | **Not linked** | duplicate of `dunst/dunstrc`? |

**`setup.sh` references missing from repo:** `twitchnotifier.cfg`, `.inputrc` (symlink lines exist; files may be absent on clone).

### Scale (approximate)

| Path | Notes |
|------|--------|
| `rofi/themes/` | ~154 `.rasi` theme files |
| `zsh/themes/` | ~142 OMZ theme files (vendored collection) |
| `rofi/launchers/` | ribbon, rofi-firefox-bookmarks, rofi-surfraw-websearch, rofi-manga, etc. |
| Total tracked files | ~2,000+ (excluding `.git`) |

### Repo-only (manual install)

| Path | How to use |
|------|------------|
| `firefox/` | Copy or symlink `userChrome.css` / sweet theme into Firefox profile `chrome/` |
| `dunstrc` (root) | Legacy; use `dunst/dunstrc` via setup |
| `packages/` | Reference lists for `pacman`/`yay`/pip/npm — not loaded at runtime |

### Critical vs boilerplate

| Critical (edit often) | Boilerplate / generated / local-only |
|-----------------------|--------------------------------------|
| `bspwmrc`, `sxhkdrc`, `polybar/*.ini` | `zsh/themes/*`, `rofi/themes/*` |
| `zsh/.zshrc`, `nvim/lua/*`, `yazi/*.toml` | `mpv/watch_later/`, `mpd/database`, `mpd/state` |
| `kitty/kitty.conf`, `qutebrowser/config.py` | `nvim/lazy-lock.json` (gitignored) |
| `ncmpcpp/config`, `newsboat/config` | `yazi/plugins/` (gitignored) |
| `.mutt/accounts/*` | `newsboat/cache.db`, `.w3m/cookie` |

### Entry points

| Entry | Function |
|-------|----------|
| `./setup.sh` | Create all symlinks (non-destructive: skips if target exists) |
| `bspwm/bspwmrc` | WM + full autostart chain |
| `.xprofile` | `xrdb ~/.Xresources` |
| `.zprofile` | `ZDOTDIR=$HOME/.config/zsh` |
| `zsh/.zshrc` | Interactive zsh |
| `nvim/init.lua` | `require("init")` |
| `polybar/launch.sh` | Kill and restart polybar bar `main` |
| `fish/config.fish` | Fish alternative shell |

---

## 5. CORE MODULES & COMPONENTS

One subsection per program/folder (alphabetical by repo path). See §4 catalog for symlink targets.

---

### `alacritty/` — GPU terminal (Argonaut theme)

| | |
|--|--|
| **Entry** | `alacritty.toml` |
| **Theme** | Argonaut colors; cursor `#FF261E` |
| **Links** | `~/.config/alacritty` |
| **Notes** | `.profile` sets `TERMINAL=alacritty`; sxhkd uses **kitty** for `super+t`. Bash `.bashrc` has alacritty-specific PS1 branch. |

---

### `.bashrc` / `.bash_profile` — Bash (non-primary shell)

| | |
|--|--|
| **Entry** | `.bashrc` |
| **Features** | Custom PS1 per `$TERM`; fzf key-bindings; autojump; `vivid generate one-dark` for `LS_COLORS`; lazy `nvm`; conda block **commented out** (slow startup); starship **disabled** in bash |
| **Links** | `~/.bashrc`, `~/.bash_profile` |
| **External** | Sources `$HOME/.aliases/aliases` and `functions` (not in repo) |

---

### `bspwm/` — Tiling window manager

| | |
|--|--|
| **Entry** | `bspwmrc` |
| **Role** | Monitors/desktops, border colors, window rules, **session autostart** |
| **Desktops** | Fallback: 一–九; hardware: DP-0 → 1–7, DP-1 → 8–9, HDMI-A-0 → 10 |
| **Rules** | `mpv` fullscreen; `Zathura` tiled; `Gimp` → desktop 8 floating; `Chromium` → desktop 2 |
| **Autostart** | conky → picom → sxhkd → dunst → redshift → wallpaper script → xset/xmodmap → clipmenud → polybar |
| **Gotcha** | Edit monitor names from `xrandr` on new hardware |

---

### `conky/` — On-desktop system monitor

| | |
|--|--|
| **Layouts** | `conky1/conkyrc1` (used in bspwmrc), `conky2/conkyrc2`, `conky3/conkyrc` + `startconky.sh` + `background.png` |
| **Links** | `~/.config/conky` |
| **Notes** | Started only if `conky` binary exists; 1s `update_interval`, double_buffer |

---

### `dunst/` + root `dunstrc` — Notifications

| | |
|--|--|
| **Entry** | `dunst/dunstrc` (linked); root `dunstrc` is **orphan** (not in setup) |
| **Style** | Terminus 12, gruvbox-ish separator `#ebdbb2`, geometry `500x5-30+50` |
| **Links** | `~/.config/dunst` |
| **Started** | From `bspwmrc` |

---

### `fastfetch/` — Terminal system info (runs in zsh)

| | |
|--|--|
| **Entry** | `config.jsonc` |
| **Logo** | `images/arch.png`, kitty-direct, height 18 |
| **Modules** | custom dots, title, os, kernel, packages (pacman), shell, terminal, … |
| **Assets** | `ascii/`, `images/`, `pngs/` |
| **Links** | `~/.config/fastfetch`; invoked at end of `zsh/.zshrc` |

---

### `firefox/` — Browser UI chrome (manual install)

| | |
|--|--|
| **Entry** | `userChrome.css` → `@import firefox-sweet-theme/userChrome.css` |
| **Links** | **Not in setup.sh** — copy into profile `chrome/` |
| **Notes** | `firefox-sweet-theme/` has icons, scrollbars, tab CSS |

---

### `fish/` — Alternative shell

| | |
|--|--|
| **Entry** | `config.fish` |
| **Defaults** | `EDITOR=nvim`, `TERMINAL=kitty`, `BROWSER=qutebrowser` |
| **Stack** | vi bindings, pure prompt (`conf.d/pure.fish`), fzf, z (directory jumper), fisher plugins in `fishfile` |
| **XDG** | Extensive `XDG_*` re-exports in config |
| **Links** | `~/.config/fish`; `fish_variables` gitignored |

---

### `imv/` — Image viewer

| | |
|--|--|
| **Entry** | `config` |
| **Features** | Custom binds only (`suppress_default_binds`); vim-like `hjkl`; `w` runs `wal -i` + reload bspwm; gif frame advance; rofi tag menu |
| **Links** | `~/.config/imv` |

---

### `kitty/` — Primary terminal (keybindings)

| | |
|--|--|
| **Entry** | `kitty.conf` (+ duplicate tree under `kitty/config/`) |
| **Theme** | Tokyo Night colors, FiraCode Nerd Font 13, opacity 0.90, shell `zsh` |
| **Links** | `~/.config/kitty` |
| **sxhkd** | `super+t`, `super+m` (ncmpcpp), `super+e` (neomutt) |

---

### `Kvantum/` — Qt5 application theming

| | |
|--|--|
| **Entry** | `kvantum.kvconfig` → `theme=Otto`; per-app override for keepassxc |
| **Themes** | `Otto/`, `Sweet/`, `Sweet-Mars/` (some theme dirs gitignored) |
| **Links** | `~/.config/Kvantum` |

---

### `lf/` — Terminal file manager (lf migration source for yazi keys)

| | |
|--|--|
| **Entry** | `lfrc` (~550 lines) |
| **Features** | `previewer`/`cleaner` scripts; icons; custom `open` by mime (zathura, mpv, pandoc, w3m); many shell `%` mappings |
| **Shell** | `set shell zsh` |
| **Links** | `~/.config/lf` |

---

### `mpd/` — Music Player Daemon

| | |
|--|--|
| **Entry** | `mpd.conf` |
| **Audio** | PulseAudio output; `music_directory ~/Music/` |
| **State** | `database`, `state`, `sticker.sql` in repo but **gitignored** at runtime |
| **Links** | `~/.config/mpd` |
| **Service** | User systemd unit expected (not in repo) |

---

### `mpv/` — Video player + Lua extensions

| | |
|--|--|
| **Scripts** | `blacklist-extensions`, `blur-edges`, `crop`, `misc`, `mpv-commands`, `seek-to`, `sub-bilingual`, `sub-bookmarks`, `sub-cut`, `sub-export`, `sub-playback`, `sub-replay`, `sub-search`, `sub-sentences`, `total_playtime` (+ `.list` data file), `unused/` archive |
| **Links** | `~/.config/mpv` |
| **Ignored** | `watch_later/` |
| **BSPWM** | Rule: fullscreen |

---

### `mutt/` + `.mutt/` — Email (NeoMutt)

| | |
|--|--|
| **`mutt/`** | Theme/color fragments: solarized, zenburn, neonwolf, etc. → `~/.config/mutt` |
| **`.mutt/`** | Live config: `muttrc` sources account files, sidebar, settings, colors, aliases |
| **Accounts** | `accounts/account.com.gmail.*` — **gitignored** (secrets) |
| **Active** | `Airuniversity` account sourced by default; powerranger account commented “broken” |
| **sxhkd** | `super+e` → `kitty -e neomutt` |
| **Links** | `~/.mutt` + `~/.config/mutt` |

---

### `ncmpcpp/` — MPD client TUI

| | |
|--|--|
| **Entry** | `config`, `bindings`, alt `config1` |
| **UI** | Columns mode, fancy scrolling, alternative UI, colored columns |
| **Cover art** | `ncmpcpp-ueberzug/` scripts (ueberzug integration) |
| **Visualizer** | FIFO `/tmp/mpd.fifo` |
| **Links** | `~/.config/ncmpcpp`; `error.log` gitignored |

---

### `newsboat/` — RSS reader

| | |
|--|--|
| **Entry** | `config` (+ local `urls` file) |
| **Browser** | `$HOME/bin/bash_scripts/urlportal.sh` |
| **Behavior** | `refresh-on-startup`, 150s reload, `nb-notify`, 120-day article retention, feed sort by views |
| **Colorschemes** | 12+ schemes in `colorschemes/` (gitignored dir per `.gitignore`) |
| **sxhkd** | `alt+n` (not README’s `super+n`) |
| **Links** | `~/.newsboat` |

---

### `nvim/` — Neovim IDE

| | |
|--|--|
| **Bootstrap** | `init.lua` → `lua/init.lua` → plugins, general, settings, mappings, utils, config, autocommands |
| **Plugins** | `lua/plugins.lua` (lazy.nvim); splits in `lua/plugins/*.lua` |
| **LSP** | `lua/lsp/`: bash, C, cmake, css, dartls, docker, emmet, eslint, gopls, graphql, html, json, lua_ls, python, sqls, tsserver, vim, efm |
| **Format/lint** | `lua/efm/`: prettier, flake8, isort, gofumpt, shellcheck, shfmt, luacheck, markdownlint, pandoc, cppcheck, … |
| **Extras** | `UltiSnips/` (JS/TS snippets), `ftplugin/cpp.vim`, `config/statusline.vimrc`, `README.md` plugin list |
| **Docs** | See `nvim/README.md` for plugin inventory |
| **Gotcha** | `lazy-lock.json` gitignored; run `:Lazy sync` on new machine |

---

### `picom.conf` — Compositor (repo root file)

| | |
|--|--|
| **Effects** | dual_kawase blur (strength 4), 90% opacity rules for kitty/rofi/dunst/etc., GLX backend, vsync |
| **Links** | `~/.config/picom.conf` |
| **Reload** | `pkill picom; picom &` |

---

### `polybar/` — Status bar

| | |
|--|--|
| **INI** | `config.ini` includes colors, bars, modules, user_modules |
| **Bar `main`** | Modules: launcher, bspwm, net up/down, battery, mpd, date, uptime, cpu/ram/fs bars, volume, backlight, powermenu |
| **Scripts** | `powermenu` (rofi → lock/logout/suspend/reboot/shutdown), `weather.py`, `updates.sh`, `gmail` (gitignored), `polybar-mpv/` |
| **statusbar/** | `sb-news`, `sb-volume`, `sb-pacpackages`, `sb-kbselect`, … |
| **launch.sh** | killall polybar → restart `main` |
| **Fonts** | Iosevka Nerd, waffle, Noto Color Emoji, Noto Sans CJK JP |

---

### `qutebrowser/` — Keyboard-driven browser

| | |
|--|--|
| **Entry** | `config.py` (autoconfig disabled; explicit Python config) |
| **Features** | Dark mode, lazy session restore, custom aliases (`q`/`w`/`wq`), per-site CSS under `themes/css/` (apprentice, solarized, darculized) |
| **Extras** | `blocked-hosts`, `quickmarks`, greasemonkey scripts (4chanX, duckduckgo) |
| **fish** | Default `BROWSER=qutebrowser` in fish only |
| **Ignored** | `bookmarks/` |

---

### `ranger/` — Vim-like file manager

| | |
|--|--|
| **Entry** | `rc.conf`, `rifle.conf`, `commands.py`, `scope.sh` |
| **Plugins** | `plugins/` python extensions |
| **Colors** | `colorschemes/zenburn.py`, etc. |
| **Custom** | gzip/gunzip maps, tar extract, many custom keymaps at top of rc |

---

### `rofi/` — Launcher, menus, themes

| | |
|--|--|
| **Primary** | `launchers/ribbon/launcher.sh` — random ribbon + random color (`sed` on `styles/colors.rasi`) |
| **Launchers** | `rofi-firefox-bookmarks`, `rofi-chromium-history`, `rofi-surfraw-websearch`, `rofi-manga`, `rofi-snippet`, `rofi-keepassXC`, `rofi-locate`, `web-search.py`, … |
| **Applets** | `applets/` — battery, network, screenshot, powermenu variants (circle/square/rounded) |
| **Themes** | ~154 `.rasi` files (Arc family, gruvbox, material, etc.) |
| **bin/** | Android-oriented helper scripts |
| **sxhkd** | `super+space`; clipmenu `CM_LAUNCHER=rofi` |

---

### `surfraw/` — CLI search front-end

| | |
|--|--|
| **Entry** | `conf` — graphical browser firefox, text browser w3m |
| **elvi/** | Custom search: zlibrary, piratebay, twitch, RARBG, ytsmx, … |
| **Ignored** | `bookmarks` (local) |
| **Links** | `~/.config/surfraw` |
| **Integrates** | w3m CGI (`fzf_surfraw.cgi`), rofi web search launchers |

---

### `sxhkd/` — Global hotkeys

| | |
|--|--|
| **Entry** | `sxhkdrc` |
| **Sections** | BSPWM bindings, preselect, move/resize, system (slock, restart sxhkd), applications |
| **Apps map** | `super+t` kitty, `super+r` kitty+rtv, `super+y` ytfzf, `super+o` htop, `super+w` firefox, `super+e` neomutt, `super+m` ncmpcpp, `super+space` rofi ribbon, `super+p` powermenu, `shift+alt+t` notifytorrents |
| **Gotcha** | Large block of commented `crystal` legacy bindings; README differs on some keys |

---

### `transmission-daemon/` — BitTorrent

| | |
|--|--|
| **Entry** | `settings.json` |
| **Paths** | Download `/home/$USER/Videos`, incomplete `Downloads` |
| **Features** | Blocklist enabled, PEX, ratio limit 2, port 58926 |
| **Ignored** | `dht.dat`, `stats.json`, `resume/`, `torrents/` |
| **sxhkd** | `shift+alt+t` → `notifytorrents` (external script) |

---

### `urlscan/` — Terminal URL picker

| | |
|--|--|
| **Entry** | `config.json` — palettes, vim-like keys (`j`/`k`, `c` context, `C` clipboard) |
| **Links** | `~/.config/urlscan` |
| **tmux** | `@urlview-key` in `.tmux.conf` (related tool) |

---

### `urlview/` — URL extractor for mutt/pipelines

| | |
|--|--|
| **Entry** | `.urlview` |
| **Links** | `~/.config/urlview` |

---

### `.w3m/` — Text browser + automation CGI

| | |
|--|--|
| **cgi-bin/** | `fzf_surfraw`, `fzf_bookmarks`, `fzf_settings_toggle` (+ tmux variants), `user_agent_switcher`, `save_bookmark_surfraw`, `bulkdownload`, `magnet.py`, `queue2ariadaemon` |
| **root-cgi-bin/** | clipboard, surfraw, restore_tab, treat_as_url |
| **setting-toggle/** | image enable/disable, table borders, aria2c daemon |
| **user-agent/** | Spoof agents (PS4, iPhone, 3DS, …) |
| **Ignored** | `cookie` |
| **Profile** | `BROWSERCLI=w3m` in zsh |

---

### `yazi/` — Primary TUI file manager

| | |
|--|--|
| **Configs** | `yazi.toml` (openers, preview, plugins), `keymap.toml` (lf-style binds migrated), `init.lua`, `package.toml` |
| **Plugins** | Install via `packages.md` (`ya pkg add …`); `plugins/` **gitignored** |
| **Flavors** | tokyonight-storm, onedark (manual clone) |
| **Open** | mpv for A/V, `$EDITOR` for text, xdg-open fallback; `code` previewer for many mimes |
| **Zsh** | `yazi()` function preserves cwd via temp file |
| **Gotcha** | May 2026: open rules use `url` key not `name` |

---

### `ytfzf/` — YouTube fuzzy finder

| | |
|--|--|
| **Entry** | `conf.sh` |
| **Settings** | hist on, loop, 1080p pref, cache `~/.cache/ytfzf`, menu via **rofi** |
| **sxhkd** | `super+r` → `kitty -e $HOME/bin/bash_scripts/ytfzf -D` (script outside repo) |
| **Links** | `~/.config/ytfzf` |

---

### `zathura/` — PDF/DjVu viewer

| | |
|--|--|
| **Entry** | `zathurarc` |
| **Style** | Dark (#202020), 2 pages per row, smooth scroll, dual monitor copy mode |
| **Font** | Inconsolata 15 |
| **lf/ranger** | Opened from lf `open` for pdf/djvu |
| **BSPWM** | Rule: tiled (not floating) |

---

### `zsh/` — Primary interactive shell

| | |
|--|--|
| **Entry** | `.zshrc` (also symlinked as `~/.config/zsh/.zshrc`) |
| **Features** | Vi mode, fzf, autosuggestions + syntax-highlighting (auto-clone to `plugins/`), yazi cwd hook, lazy nvm/conda, pnpm PATH, `fastfetch`, gcloud SDK snippets |
| **themes/** | ~142 OMZ themes (vendored; rarely all used) |
| **External** | `$HOME/.aliases/aliases`, optional `.zshenv` |
| **`.zprofile`** | Only sets `ZDOTDIR` — **not** symlinked by setup.sh |

---

### Root dotfiles (session & defaults)

| File | Program | Purpose |
|------|---------|---------|
| `.profile` | login shell | XDG, FZF (ag backend), `EDITOR`, `TERMINAL`, book/video dirs, npm/pnpm, long PATH |
| `.xprofile` | X session | `xrdb ~/.Xresources` |
| `.Xresources` | X11 | Colors, fonts, DPI |
| `.Xmodmap` | X11 | Keymap (loaded in bspwmrc) |
| `starship.toml` | prompt | Vi-mode symbols, package/python/git modules; used by zsh (not bash) |
| `.tmux.conf` | tmux | prefix `C-a`, vi mode, mouse, CPU/RAM in statusline, urlview key `u` |
| `mimeapps.list` | xdg-mime | Default apps for MIME types |
| `.dir_colors` | ls colors | Legacy; bash/zsh prefer **vivid** when installed |
| `.wgetrc` | wget | Download defaults |
| `.gitconfig` | git | **gitignored** — local credentials |

---

### `vivid/` — LS_COLORS

| | |
|--|--|
| **Entry** | `themes/one-dark-modified.yml`, `filetypes.yml`, `keymap.toml` |
| **Usage** | Bash: `vivid generate one-dark`; zsh may use `.dir_colors` |
| **Links** | `~/.config/vivid` |

---

### `packages/` — Install manifests (not runtime config)

| | |
|--|--|
| **v2/** | `pacman-packages.txt`, `yay-packages.txt`, `pip`, `npm`, `go`, `total-package-list.txt` |
| **v1/** | Older pip/npm/go lists |
| **Use** | Reference when rebuilding system; not sourced by dotfiles |

---

## 6. DESKTOP SESSION & WINDOW MANAGER

### Stack

**BSPWM + sxhkd** on X11. No display manager config in repo (assume existing DM or `startx`).

### Monitors & desktops

- Generic: 9 desktops with Chinese labels (overwritten on real hardware).
- Author setup: 10 logical desktops across 3 monitors (see `bspwmrc` lines 10–12).

### Autostart chain (from `bspwmrc`)

1. `conky` (if installed) — `~/.config/conky/conky1/conkyrc1`
2. `picom &`
3. `sxhkd &`
4. `dunst &`
5. `redshift -O 5000 &`
6. `$HOME/bin/bash_scripts/random-wallpaper.sh` (if executable)
7. `xset r rate 300 50`
8. `xmodmap ~/.Xmodmap`
9. `clipmenud &`
10. `polybar -r main --config=$HOME/.config/polybar/config.ini`

### Keybinding map (major)

| Binding | Action |
|---------|--------|
| `super + alt + q/r` | Quit / restart bspwm |
| `super + d` | Toggle floating |
| `super + q` / `super + shift + q` | Close / kill node |
| `super + h/j/k/l` | Focus direction |
| `super + 1-8` / `super + shift + 1-8` | Desktop focus / send node |
| `super + f` | Monocle / fullscreen cycle |
| `super + space` | Rofi ribbon launcher |
| `super + t` | Kitty terminal |
| `super + r` | Kitty + rtv |
| `super + y` | ytfzf (`~/bin/bash_scripts/ytfzf -D`) |
| `super + o` | htop (kitty) |
| `super + w` | Firefox |
| `super + e` | Neomutt (kitty) |
| `super + m` | ncmpcpp |
| `alt + n` | newsboat |
| `super + p` | Polybar powermenu |
| `super + v` | `clipmenu` via rofi |
| `super + shift + x` | Restart sxhkd |
| `alt + l` | `slock` |
| `ctrl + alt + Left/Right` | Prev/next desktop |

### Polybar

- **IPC:** enabled; `wm-restack = bspwm`
- **Tray:** right side
- **Scripts:** MPD, network speed, powermenu, gmail script path gitignored

### Picom

- **Backend:** GLX, dual_kawase blur strength 4
- **Opacity:** 90% for kitty, rofi, dunst, alacritty, etc.
- **Fading:** disabled
- **Note:** Feb 2026 commit fixed picom deprecation errors

---

## 7. SHELL, PROMPT & CLI TOOLING

### Shell load order

1. Login: `.profile` (env, PATH, XDG, FZF, many exports)
2. Zsh: `.zprofile` sets `ZDOTDIR=$HOME/.config/zsh`
3. Interactive: `~/.config/zsh/.zshrc` (symlinked from repo)

### Zsh features

- Vi mode (`bindkey -v`), fzf history search `^R`
- Plugins: zsh-autosuggestions, zsh-syntax-highlighting (auto-git-clone)
- Sources: `~/.aliases/aliases`, `/usr/share/fzf/key-bindings.zsh`, autojump
- Lazy: `nvm`, `conda-init` function
- **yazi:** shell function preserves cwd after exit
- **Prompt:** Starship (`starship.toml`, `add_newline = false`)
- **On start:** `fastfetch`

### Terminal vs WM

- sxhkd → **kitty** for `super+t`
- `.profile` → `TERMINAL=alacritty`, `EDITOR=nvim`, `BROWSER=firefox`

### File managers & launcher

| Tool | Invocation |
|------|------------|
| Yazi | Shell `yazi` function; config in `yazi/yazi.toml` |
| lf | `~/.config/lf` |
| ranger | `~/.config/ranger` |
| Rofi | `super+space` → ribbon launcher |

### Tmux / Git

- `.tmux.conf` symlinked to `$HOME`
- `.gitconfig` symlinked but **also gitignored** — local credentials stay machine-local

---

## 8. CONFIG FILES & SCHEMAS

### Formats by app

| App | Format | Repo path |
|-----|--------|-----------|
| BSPWM, sxhkd | shell / rc | `bspwm/bspwmrc`, `sxhkd/sxhkdrc` |
| Polybar | INI | `polybar/*.ini` |
| Picom | YAML | `picom.conf` |
| Dunst | ini | `dunst/dunstrc` |
| Kitty, Alacritty | conf / TOML | `kitty/kitty.conf`, `alacritty/alacritty.toml` |
| Neovim | Lua | `nvim/**/*.lua` |
| Rofi | rasi | `rofi/**/*.rasi` |
| Yazi | TOML + Lua | `yazi/yazi.toml`, `keymap.toml`, `init.lua` |
| lf | lf shell | `lf/lfrc` |
| ranger | Python + conf | `ranger/rc.conf`, `commands.py` |
| qutebrowser | Python | `qutebrowser/config.py` |
| mpd, ncmpcpp | conf / ini | `mpd/mpd.conf`, `ncmpcpp/config` |
| newsboat | conf | `newsboat/config` |
| mutt / neomutt | muttrc | `.mutt/muttrc`, `mutt/*.neomuttrc` |
| mpv | Lua | `mpv/scripts/*.lua` |
| transmission | JSON | `transmission-daemon/settings.json` |
| fastfetch | JSONC | `fastfetch/config.jsonc` |
| fish | fish | `fish/config.fish` |
| zathura, imv | conf | `zathura/zathurarc`, `imv/config` |
| surfraw | conf | `surfraw/conf` |
| urlscan | JSON | `urlscan/config.json` |
| urlview | conf | `urlview/.urlview` |
| ytfzf | shell | `ytfzf/conf.sh` |
| w3m | CGI + conf | `.w3m/cgi-bin/*` |
| Kvantum | kvconfig | `Kvantum/kvantum.kvconfig` |
| vivid | YAML | `vivid/themes/*.yml` |
| Starship, tmux | TOML / tmux | `starship.toml`, `.tmux.conf` |
| X11 | resources | `.Xresources`, `.Xmodmap` |
| MIME | ini | `mimeapps.list` |

### Theme consistency

- **BSPWM borders:** `#4c566a`, focus `#327bd1`, urgent `#dd2727` (Nord-like)
- **Kitty / nvim:** Tokyo Night / Gruvbox family
- **Dunst:** Gruvbox separator `#ebdbb2`
- **Rofi:** Many Arc/Gruvbox variants; ribbon launcher randomizes
- **LS_COLORS:** `vivid/themes/`, `.dir_colors`

### Symlink map (`setup.sh` — complete)

**Directories → `~/.config/` (or special):**

`polybar`, `transmission-daemon`, `rofi`, `urlscan`, `urlview`, `surfraw`, `ytfzf`, `ranger`, `mutt`, `Kvantum`, `lf`, `mpv`, `dunst`, `alacritty`, `nvim`, `zsh`, `conky`, `bspwm`, `sxhkd`, `qutebrowser`, `zathura`, `mpd`, `ncmpcpp`, `vivid`, `fish`, `imv`, `kitty`, `yazi`, `fastfetch` → `~/.config/<name>`

**Special directory targets:** `newsboat/` → `~/.newsboat`; `.w3m/` → `~/.w3m`; `.mutt/` → `~/.mutt`

**Files:** `mimeapps.list`, `starship.toml`, `twitchnotifier.cfg` → `~/.config/`; `.bashrc`, `.bash_profile`, `.gitconfig`, `.Xresources`, `.tmux.conf`, `.Xmodmap`, `.profile`, `.inputrc`, `.xprofile`, `.dir_colors`, `.wgetrc` → `$HOME/`; `picom.conf` → `~/.config/picom.conf`; `zsh/.zshrc` → `~/.config/zsh/.zshrc`

**Not symlinked by setup.sh:** `firefox/`, root `dunstrc`, `.zprofile`, `packages/`, `screenshots/`, `context.md`, `prompt.txt`

**Note:** `setup.sh` does **not** overwrite existing paths; first install only.

### Gitignored / secret-adjacent

- `.gitconfig`, `.mutt/muttrc`, `.mutt/accounts`
- `polybar/scripts/gmail`
- `newsboat/cache.db`, `mpv/watch_later`
- `zsh/plugins/`, `yazi/plugins/`, `nvim/lazy-lock.json`
- `transmission-daemon` state, `ncmpcpp/error.log`

---

## 9. ENVIRONMENT & CONFIGURATION

### Important variables (from `.profile` / `.zshrc`)

| Variable | Purpose |
|----------|---------|
| `ZDOTDIR` | Zsh config dir (`~/.config/zsh`) |
| `XDG_*` | XDG base dirs |
| `EDITOR` | `nvim` |
| `BROWSER` / `BROWSERCLI` | `firefox` / `w3m` |
| `TERMINAL` | `alacritty` (profile) vs kitty (keys) |
| `FZF_DEFAULT_OPTS` | Dark theme, reverse layout |
| `FZF_DEFAULT_COMMAND` | `ag --hidden ...` |
| `CONFIG_BACKUP` | Points to dotfiles path |
| `GDK_DPI_SCALE` | `0.8` GTK scaling |
| `PNPM_HOME`, `NVM_DIR` | Node tooling |
| `CLOUDSDK_PYTHON_SITEPACKAGES` | gcloud |

### External services

| Service | Integration |
|---------|-------------|
| MPD | Local `127.0.0.1`, PulseAudio output |
| Transmission | `transmission-daemon/` config |
| Email | neomutt (secrets local) |
| Newsboat | RSS feeds |
| Twitch notifier | `twitchnotifier.cfg` (symlinked) |

### Secrets

- **Never commit:** mutt accounts, gmail polybar script, `.gitconfig`, API tokens in newsboat/mutt.
- **Approach:** gitignore + machine-local files; `setup.sh` won't clobber existing secrets.

### Host-specific

- BSPWM monitor names
- Paths under `/home/alpha/`, `~/bin/bash_scripts/`, `~/anaconda3`, Google Cloud SDK location
- `conda`, `nvm`, `pnpm` optional installs

---

## 10. CURRENT STATE OF THE PROJECT

### Stable

- BSPWM + sxhkd + polybar + picom session on author hardware
- Zsh + starship daily use
- Neovim + lazy.nvim LSP workflow
- Rofi ribbon launcher, Yazi, MPD/ncmpcpp, mpv scripts
- `setup.sh` symlink deployment

### Partial / experimental

- Multi-monitor `bspwmrc` block not portable without edit
- Fish config present; primary shell is Zsh
- Conky autostart optional (`command -v conky`)
- Some sxhkd/README bindings out of sync (workspace count, `super+n` newsboat vs `alt+n`)

### Known issues

- **Terminal inconsistency:** README/keys use Kitty; `.profile` exports `TERMINAL=alacritty`
- **Rofi `sed -i`:** modifies tracked `colors.rasi` when using random colors
- **Google Cloud SDK:** paths in `.zshrc` point to `~/Downloads/google-cloud-sdk` (fragile)
- **setup.sh:** no backup despite README claiming warnings/backups
- **dunstrc** duplicate at repo root vs `dunst/` directory

### Not started / deferred

- Wayland port (Hyprland/Sway) — explicitly not in repo
- Automated CI/config tests
- Unified theme token file across all apps

---

## 11. RECENT CHANGES & DECISIONS LOG

| Date | Change | Why | Files |
|------|--------|-----|-------|
| 2026-05-15 | Playtime list, lazy-lock, Rofi colors, Yazi `url`, gcloud PATH in zsh | Maintenance / QoL | `mpv/scripts/total_playtime.list`, `nvim/lazy-lock.json`, `rofi/.../colors.rasi`, `yazi/yazi.toml`, `zsh/.zshrc` |
| 2026-05-06 | Misc fixes | Unspecified | various |
| 2026-04-01 | Branch sync `main` | Housekeeping | — |
| 2026-03-31 | Neovim plugin version bumps | Compatibility | `nvim/` |
| 2026-03-08 | Clangd / C LSP config | C++ dev | `nvim/lua/lsp/C.lua` |
| 2026-02-27 | General changes | — | — |
| 2026-02-10 | Picom deprecation fix | picom 13 API | `picom.conf` |
| 2026-02-04 | Newsboat URL cleanup | Reduce feed bloat | `newsboat/` |
| 2026-02-04 | Path portability | Remove hardcoded `/home/alpha` | many configs |
| 2026-02-04 | QoL + critical config fixes | Stability | multiple |
| 2026-01-21 | clipmenu + rofi | Clipboard UX | `sxhkdrc`, rofi |
| 2026-01-14 | Neovim doc rename | GitHub visibility | `nvim/README` |

---

## 12. BUGS & FIXES LOG

### Fixed (historical)

| Issue | Fix |
|-------|-----|
| Picom deprecated options | Updated `picom.conf` (2026-02-10) |
| Hardcoded `/home/alpha` paths | Replaced with `$HOME` (2026-02-04) |
| Critical config issues batch | Feb 2026 “resolve 20 critical config issues” commits |

### Open

| Issue | Workaround |
|-------|------------|
| Monitor names in bspwmrc | Edit for your `xrandr` output |
| Rofi random color edits git tree | Comment `sed` lines in `launcher.sh` |
| README vs sxhkd key mismatches | Trust `sxhkdrc` over README |
| `lazy-lock.json` not tracked | Regenerate locally after plugin changes |

---

## 13. IMPORTANT PATTERNS & CONVENTIONS

- **Naming:** App configs mirror XDG: `~/.config/<app>/`; dotfiles at repo root for legacy (` .tmux.conf`, `.Xresources`).
- **Adding new dotfiles:** (1) Add dir/file to repo, (2) add `ln -s` line to `setup.sh`, (3) document in README if user-facing, (4) add to `.gitignore` if generated/secret.
- **Shell scripts:** Prefer `[ -f ... ] && source` guards; polybar scripts assume `$HOME/.config/polybar`.
- **Neovim:** New plugins go in `lua/plugins.lua` or `lua/plugins/*.lua`; LSP per language in `lua/lsp/<lang>.lua`.
- **Polybar:** New modules in `modules.ini` or `user_modules.ini`, reference in `config.ini` `modules-*` lists.
- **Debugging:** `polybar -m` for bar placement; `sxhkd -c` path; `nvim --headless` for init errors; `bspc wm -d` for WM state.

---

## 14. EXTERNAL DEPENDENCIES & INTEGRATIONS

### System packages

- Primary manifest: `packages/v2/pacman-packages.txt` (500+ packages on author system)
- AUR: `packages/v2/yay-packages.txt`
- Languages: `pip-packages.txt`, `npm-packages.txt`, `go-packages.txt`

### README minimum set

```
bspwm sxhkd polybar rofi kitty zsh neovim picom dunst ranger lf mpv mpd ncmpcpp newsboat brightnessctl playerctl tmux starship bat exa
ttf-jetbrains-mono-nerd ttf-iosevka-nerd
```

### Integrations

| Tool | Auth / connection |
|------|-------------------|
| MPD | localhost, PulseAudio |
| Git | `~/.gitconfig` (local, ignored) |
| Gmail (polybar) | Script gitignored |
| gcloud | Local SDK install + zsh snippets |
| w3m/surfraw | CLI, no OAuth in repo |

### Constraints

- **X11 required** for picom blur + sxhkd + current polybar
- **Nerd fonts** for bar and terminal glyphs
- **playerctl** for MPD media keys (if used in scripts)
- Optional: **ueberzug** for ncmpcpp album art, **clipmenud** for clipboard

---

## 15. TESTING & VALIDATION

### What exists

- Manual validation only; no automated test suite in repo
- README benchmarks: `nvim --startuptime`, `zsh -i -c exit`

### Recommended checks after edits

```bash
# Neovim config loads
nvim --headless "+qa"

# Polybar syntax / monitors
polybar -m
polybar -c ~/.config/polybar/config.ini main &

# sxhkd config
sxhkd -c ~/.config/sxhkd/sxhkdrc

# BSPWM (reload)
bspc wm -r

# Picom
picom --config ~/.config/picom.conf --diagnostics
```

### Not tested automatically

- Full install on clean Arch VM
- Multi-monitor bspwm layouts
- Every rofi theme/applet
- Fish vs zsh parity

---

## 16. HOW TO INSTALL & USE

### From scratch (Arch)

1. Install base packages (see README or `packages/v2/pacman-packages.txt` subset).
2. Install fonts: `ttf-jetbrains-mono-nerd`, `ttf-iosevka-nerd` (and FiraCode for kitty).
3. Clone: `git clone <repo-url> ~/etc/linuxConfig/dotfiles_v2 && cd dotfiles_v2`
4. Run: `chmod +x setup.sh && ./setup.sh`
5. Ensure `~/.aliases/aliases` exists if expected by zsh.
6. Clone zsh plugins (happens automatically on first zsh start) or pre-clone to `~/.config/zsh/plugins/`.
7. Install Neovim plugins: open `nvim`, run `:Lazy sync`.
8. Install Yazi plugins per `yazi/packages.md` if needed.
9. Edit `bspwm/bspwmrc` monitor section for your displays.
10. Start X session with bspwm (DM-specific).

### Post-install

- Enable user services: `mpd` (systemd user), optionally `transmission-daemon`
- Place music in `~/Music/` for MPD
- Configure mutt/newsboat credentials locally

### Reload without logout

| Component | Command |
|-----------|---------|
| sxhkd | `super+shift+x` or `pkill sxhkd; sxhkd &` |
| polybar | `~/.config/polybar/launch.sh` or `polybar -r main` |
| picom | `pkill picom; picom &` |
| bspwm | `bspc wm -r` or `super+alt+r` |
| zsh | `exec zsh` |

---

## 17. NEXT STEPS & ROADMAP

### Immediate (from recent git)

- Neovim plugin lockfile hygiene
- Yazi config (`url` vs `name` fields) stabilization
- Rofi ribbon color import consistency
- Consolidate gcloud PATH (single location)

### Short-term

- Align README keybindings with `sxhkdrc`
- Resolve `TERMINAL` kitty vs alacritty
- Document or script bspwm monitor detection

### Long-term

- Optional Wayland migration (not started)
- Central theme variables shared across kitty/nvim/polybar/rofi
- `setup.sh` backup/overwrite flags

### Explicitly not doing

- **Wayland-first stack** — would replace picom/sxhkd/polybar patterns
- **Full automated test CI** — personal dotfiles, manual validation sufficient for now

---

## 18. CONTEXT FOR AI ASSISTANTS

### Preferred edit style

- Minimal diffs; match existing indentation and theme hex values
- When changing colors, check kitty, bspwm borders, dunst, polybar `colors.ini` for consistency
- Use `$HOME` not hardcoded `/home/alpha` (project convention since Feb 2026)

### Do NOT touch (unless user asks)

- `mpv/watch_later/`, `mpv/scripts/total_playtime.list` (user data) — only if task-related
- `nvim/lazy-lock.json` — only when updating Neovim plugins intentionally
- `.gitconfig`, `.mutt/accounts`, `polybar/scripts/gmail`
- `zsh/plugins/` (downloaded), `yazi/plugins/` (managed separately)
- `transmission-daemon` resume/torrent state
- Mass renames in `zsh/themes/` or `rofi/themes/`

### Recurring mistakes to avoid

- Assuming Wayland or Hyprland
- Changing `setup.sh` symlinks without documenting new paths
- Running `sed -i` on tracked rofi files without user consent
- Breaking `ZDOTDIR` layout (zsh expects `.zshrc` at `~/.config/zsh/.zshrc`)
- Adding `lazy.nvim` plugins without lazy-loading pattern used elsewhere
- Trusting README over `sxhkdrc` for bindings

### Final decisions (do not re-debate)

- **BSPWM + sxhkd** remain the WM stack
- **Symlink-based deploy** via `setup.sh`, not GNU stow or chezmoi
- **Neovim + lazy.nvim** is the editor stack (not VimPlug)
- **X11 + picom** until a deliberate migration project exists

---

*Generated from repository analysis per `prompt.txt`. Re-run analysis after major structural changes.*

