<div align="center">
  <img src="assets/logo.png" alt="Logo" width="130" height="130">

  <h1>Dotfiles</h1>

  <p>
    <b>Aesthetic. Functional. Fast.</b><br>
    <i>A complete, hand-tuned Arch Linux desktop — window manager, editor, shell, and the whole terminal-first workflow around them.</i>
  </p>

  <p>
    <a href="https://github.com/Zulqarnain-cc34/dotfiles/stargazers"><img src="https://img.shields.io/github/stars/Zulqarnain-cc34/dotfiles?style=for-the-badge&logo=starship&color=ffce63&logoColor=black&labelColor=1a1b26" alt="Stars"></a>
    <a href="https://github.com/Zulqarnain-cc34/dotfiles/network/members"><img src="https://img.shields.io/github/forks/Zulqarnain-cc34/dotfiles?style=for-the-badge&logo=git&color=9ece6a&logoColor=black&labelColor=1a1b26" alt="Forks"></a>
    <a href="LICENSE"><img src="https://img.shields.io/github/license/Zulqarnain-cc34/dotfiles?style=for-the-badge&color=7aa2f7&logoColor=black&labelColor=1a1b26" alt="License"></a>
    <img src="https://img.shields.io/badge/Arch-Linux-1793d1?style=for-the-badge&logo=arch-linux&logoColor=white&labelColor=1a1b26" alt="Arch">
    <img src="https://img.shields.io/badge/Maintained-yes-9ece6a?style=for-the-badge&labelColor=1a1b26" alt="Maintained">
    <img src="https://img.shields.io/badge/full%20review-Nov%202026-c678dd?style=for-the-badge&labelColor=1a1b26" alt="Last full review">
  </p>

  <img src="assets/desktop-4.png" alt="Desktop" width="92%" style="border-radius:12px;">
</div>

---

## Contents

- [About](#-about)
- [Gallery](#-gallery)
- [The Stack](#-the-stack)
- [What's Inside](#-whats-inside)
- [Installation](#-installation)
- [Keybindings](#-keybindings)
- [Repository Structure](#-repository-structure)
- [Credits](#-credits)

---

## 🧭 About

This is my personal Arch Linux configuration — a cohesive, terminal-first desktop built around **BSPWM**, **Neovim**, and **Zsh**, with every piece chosen for speed and kept consistent in look and feel.

The guiding principles:

- **Fast** — measured, not assumed. Neovim boots in ~140 ms; Zsh in ~0.14 s. Plugins lazy-load; expensive work is cached.
- **Keyboard-first** — a tiling WM, fuzzy everything, and TUI apps for mail, music, RSS, files, and browsing.
- **Reproducible** — a single `setup.sh` symlinks everything, package manifests pin the toolset, and a `validate.sh` keeps the repo honest (no leaked paths, no dead tools, no secrets).

> **Primary session is BSPWM (X11).**

---

## 📸 Gallery

<div align="center">
<table>
  <tr>
    <td align="center" width="50%"><img src="assets/neovim-1.png" width="100%"><br><b>Neovim as an IDE</b></td>
    <td align="center" width="50%"><img src="assets/yazi_shot.png" width="100%"><br><b>Yazi file manager</b></td>
  </tr>
  <tr>
    <td align="center" width="50%"><img src="assets/terminal_demo.png" width="100%"><br><b>Kitty terminal</b></td>
    <td align="center" width="50%"><img src="assets/fastfetch_demo.png" width="100%"><br><b>Fastfetch</b></td>
  </tr>
  <tr>
    <td align="center" width="50%"><img src="assets/sakura_1_demo.png" width="100%"><br><b>Sakura · the four forms</b></td>
    <td align="center" width="50%"><img src="assets/csakura_demo.png" width="100%"><br><b>Sakura · 20s idle, my setup</b></td>
  </tr>
  <tr>
    <td align="center" colspan="2"><img src="assets/polybar_demo.png" width="60%"><br><b>Polybar</b></td>
  </tr>
</table>
</div>

---

## 🧱 The Stack

<div align="center">

| | Component | Notes |
| :--- | :--- | :--- |
| **OS** | ![Arch](https://img.shields.io/badge/-Arch_Linux-1793d1?style=flat-square&logo=arch-linux&logoColor=white) | Rolling-release base |
| **WM** | ![BSPWM](https://img.shields.io/badge/-BSPWM-1a1b26?style=flat-square&logo=linux&logoColor=white) | Binary space partitioning, driven by `sxhkd` |
| **Bar** | ![Polybar](https://img.shields.io/badge/-Polybar-3b4252?style=flat-square) | Custom modules |
| **Shell** | ![Zsh](https://img.shields.io/badge/-Zsh-98c379?style=flat-square&logo=zsh&logoColor=white) | `starship` prompt, lazy-loaded, no framework |
| **Terminal** | ![Kitty](https://img.shields.io/badge/-Kitty-c678dd?style=flat-square&logo=kitty&logoColor=white) | GPU-accelerated (Alacritty as alternate) |
| **Editor** | ![Neovim](https://img.shields.io/badge/-Neovim-57a143?style=flat-square&logo=neovim&logoColor=white) | Full IDE, `lazy.nvim` + native LSP (~140 ms) |
| **Launcher** | ![Rofi](https://img.shields.io/badge/-Rofi-e06c75?style=flat-square) | Ribbon theme |
| **Compositor** | ![Picom](https://img.shields.io/badge/-Picom-61afef?style=flat-square) | Blur, shadows, transparency |

</div>

---

## 📦 What's Inside

A complete map of the repo. Deep docs live in each component's own README — linked where available.

### 🪟 Window Manager & Desktop

| Component | Description | Docs |
| :--- | :--- | :--- |
| [`bspwm`](bspwm/) | Tiling window manager (X11) — the primary session | [README](bspwm/README.md) |
| [`sxhkd`](sxhkd/) | Global hotkey daemon driving BSPWM & app launches | [README](sxhkd/README.md) |
| [`polybar`](polybar/) | Status bar with custom modules | [README](polybar/README.md) |
| [`picom`](picom.conf) | Compositor — blur, shadows, transparency | — |
| [`dunst`](dunst/) | Notification daemon | [README](dunst/README.md) |
| [`rofi`](rofi/) | App launcher, window switcher, power menu | [README](rofi/README.md) |
| [`conky`](conky/) | Desktop system widget | [README](conky/README.md) |
| [`redshift`](redshift/) | Night-time colour temperature | [README](redshift/README.md) |

### 💻 Terminal & Shell

| Component | Description | Docs |
| :--- | :--- | :--- |
| [`kitty`](kitty/) | Primary GPU-accelerated terminal | [README](kitty/README.md) |
| [`alacritty`](alacritty/) | Alternate terminal (TOML config) | [README](alacritty/README.md) |
| [`zsh`](zsh/) | Shell — lazy-loaded plugins, hand-managed | [README](zsh/README.md) |
| [`starship.toml`](starship.toml) | Cross-shell prompt | — |
| [`.aliases`](.aliases/) | Shared aliases & helper functions | — |
| [`tmux`](.tmux.conf) | Terminal multiplexer | — |
| [`vivid`](vivid/) | `LS_COLORS` generator (cached) | — |
| [`fastfetch`](fastfetch/) | System info fetch | [README](fastfetch/README.md) |
| `csakura` | Cherry-blossom screensaver that blooms when the prompt goes idle | [docs](docs/csakura.md) |

### ✍️ Editor

| Component | Description | Docs |
| :--- | :--- | :--- |
| [`nvim`](nvim/) | Neovim as a full IDE | [README](nvim/README.md) |

### 🗄️ File Managers

| Component | Description | Docs |
| :--- | :--- | :--- |
| [`yazi`](yazi/) | **Primary** — fast Rust TUI file manager | [README](yazi/README.md) |
| [`lf`](lf/) | Legacy terminal file manager | [README](lf/README.md) |
| [`ranger`](ranger/) | Legacy terminal file manager | — |

### 🎵 Media

| Component | Description | Docs |
| :--- | :--- | :--- |
| [`mpv`](mpv/) | Video player (+ scripts) | [README](mpv/README.md) |
| [`mpd`](mpd/) + [`ncmpcpp`](ncmpcpp/) | Music daemon + TUI client with cover art | [mpd](mpd/README.md) · [ncmpcpp](ncmpcpp/README.md) |
| [`newsboat`](newsboat/) | RSS / Atom reader | [README](newsboat/README.md) |
| [`zathura`](zathura/) | Keyboard-driven PDF viewer | [README](zathura/README.md) |
| [`imv`](imv/) / `nsxiv` | Image viewers | [README](imv/README.md) |
| [`transmission-daemon`](transmission-daemon/) | BitTorrent (RPC bound to localhost) | [README](transmission-daemon/README.md) |

### 🌐 Web

| Component | Description | Docs |
| :--- | :--- | :--- |
| [`firefox`](firefox/) | Firefox `userChrome` + sweet theme | [README](firefox/README.md) |
| [`qutebrowser`](qutebrowser/) | Keyboard-driven browser | [README](qutebrowser/README.md) |
| [`.w3m`](.w3m/) | Terminal web browser | — |
| [`surfraw`](surfraw/) | CLI web-search "elvi" | [README](surfraw/README.md) |
| [`ytfzf`](ytfzf/) | Search & play YouTube from the terminal | [README](ytfzf/README.md) |
| [`mutt`](mutt/) / [`.mutt`](.mutt/) | Neomutt e-mail | [README](mutt/README.md) |

### 🛠️ Utilities & Theming

| Component | Description | Docs |
| :--- | :--- | :--- |
| [`bash_scripts`](bash_scripts/) | Host scripts → `~/bin/bash_scripts` | [README](bash_scripts/README.md) |
| [`scripts`](scripts/) | Setup, dependency install & validation | [host index](scripts/host/README.md) |
| [`packages`](packages/) | Pacman / AUR / pip / npm / go manifests | — |
| [`Kvantum`](Kvantum/) | Qt theming engine | — |
| [`urlscan`](urlscan/) / [`urlview`](urlview/) | Extract & open URLs from text | — |

---

## 🚀 Installation

> ⚠️ These are **personal** dotfiles for Arch Linux. Read what `setup.sh` symlinks before running it, and back up anything you care about.

### Prerequisites

- **Arch Linux** (or an Arch-based distro)
- A **Nerd Font** — the config uses `ttf-jetbrains-mono-nerd` and `ttf-iosevka-nerd`
- `git`, `base-devel`, and an AUR helper (`yay`) for a few packages

### Quick start

```bash
# Clone
git clone https://github.com/Zulqarnain-cc34/dotfiles.git ~/etc/linuxConfig/dotfiles_v2
cd ~/etc/linuxConfig/dotfiles_v2

# Make the helpers executable
chmod +x setup.sh scripts/*.sh

# Install the core package set (or hand-pick from packages/minimal.txt)
./scripts/install-deps.sh

# Symlink configs into ~/.config and $HOME (backs up existing targets first)
./setup.sh --backup

# Enable repo git hooks + run the sanity checks
git config core.hooksPath .githooks
./scripts/validate.sh

# Finally, open Neovim once and let the plugins install
nvim +Lazy sync +qa
```

`setup.sh` flags: `--backup` (copy existing targets to `~/.dotfiles_backup/<timestamp>/` first), `--force` (replace existing targets), `--dry-run` (print what would happen, touch nothing), `--check` (report per-target drift, touch nothing), `--help`.

Full notes: [`docs/INSTALL.md`](docs/INSTALL.md) · Secrets handling: [`docs/secrets.md`](docs/secrets.md) · Minimal package set: [`packages/minimal.txt`](packages/minimal.txt)

---

## 🎹 Keybindings

Leader key in Neovim is **`m`**. The complete maps live in [`sxhkd/sxhkdrc`](sxhkd/sxhkdrc) and [`nvim/lua/mappings.lua`](nvim/lua/mappings.lua).

<details>
<summary><b>🪟 Window Manager (BSPWM / sxhkd)</b></summary>

| Keys | Action |
| :--- | :--- |
| `Super + T` | Terminal (Kitty) |
| `Super + Space` | App launcher (Rofi ribbon) |
| `Super + Q` / `Super + Shift + Q` | Close / kill window |
| `Super + H/J/K/L` | Focus window (←↓↑→) |
| `Super + D` | Toggle floating |
| `Super + F` | Fullscreen / monocle |
| `Super + Alt + H/J/K/L` | Resize window |
| `Super + {1-9}` | Switch to workspace |
| `Super + Shift + {1-9}` | Send window to workspace |
| `Super + V` | Clipboard menu (clipmenu) |
| `Super + P` | Power menu |
| `Alt + L` | Lock screen (slock) |
| `Print` / `Shift + Print` | Screenshot: full / selection (maim) |

</details>

<details>
<summary><b>🚀 Apps</b></summary>

| Keys | Action |
| :--- | :--- |
| `Super + W` | Firefox |
| `Super + M` | E-mail (Neomutt) |
| `Alt + N` | RSS (Newsboat) |
| `Super + R` | Reddit (tuir) |
| `Super + Y` | YouTube (ytfzf) |
| `Super + O` | Process monitor (htop) |

</details>

<details>
<summary><b>✍️ Neovim (leader = <code>m</code>)</b></summary>

| Keys | Action |
| :--- | :--- |
| `Ctrl + S` | Find files (`snacks.picker`) |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `Ctrl + N` | File explorer (`snacks.explorer`) |
| `K` | Hover docs |
| `<leader>ld` | Go to definition |
| `<leader>lr` | References (Trouble) |
| `<leader>la` | Code action |
| `<leader>le` | Rename symbol |
| `<leader>lf` | Format buffer |
| `<leader>ds` | Buffer diagnostics (Trouble) |
| `<leader>gg` | Git UI (Neogit) |
| `Alt + D` | Toggle terminal |

</details>

---

## 📁 Repository Structure

```text
dotfiles/
├── bspwm/  sxhkd/  polybar/  picom.conf   # Window manager, hotkeys, bar, compositor
├── dunst/  rofi/  conky/  redshift/       # Notifications, launcher, widgets, night colour
├── kitty/  alacritty/                     # Terminals
├── zsh/  .aliases/  starship.toml         # Shell, aliases, prompt
├── nvim/                                  # Neovim (lazy.nvim + native LSP)
├── yazi/  lf/                             # File managers (yazi primary)
├── mpv/  mpd/  ncmpcpp/  newsboat/        # Media & feeds
├── qutebrowser/  firefox/  .w3m/  ytfzf/  # Web
├── mutt/  .mutt/  zathura/                # Mail & docs
├── bash_scripts/  scripts/  packages/     # Host scripts, setup helpers, manifests
├── docs/                                  # INSTALL, secrets, firefox
├── setup.sh                               # Symlink deploy
└── CHANGELOG.md                           # Notable repo changes
```

---

<div align="center">

## ❤️ Credits

None of this is mine to take credit for. It's the work of the people who build and
maintain the tools these configs sit on top of, plus the **r/unixporn** and dotfiles
community whose rices sparked half the ideas here. Huge thanks to all of them.

<a href="https://github.com/neovim" title="Neovim"><img src="https://github.com/neovim.png" width="56" alt="Neovim"/></a> <!-- group: Tools & projects -->
<a href="https://github.com/kovidgoyal" title="kitty"><img src="https://github.com/kovidgoyal.png" width="56" alt="kitty"/></a>
<a href="https://github.com/sxyazi" title="yazi"><img src="https://github.com/sxyazi.png" width="56" alt="yazi"/></a>
<a href="https://github.com/gokcehan" title="lf"><img src="https://github.com/gokcehan.png" width="56" alt="lf"/></a>
<a href="https://github.com/baskerville" title="bspwm / sxhkd"><img src="https://github.com/baskerville.png" width="56" alt="bspwm / sxhkd"/></a>
<a href="https://github.com/polybar" title="Polybar"><img src="https://github.com/polybar.png" width="56" alt="Polybar"/></a>
<a href="https://github.com/yshui" title="picom"><img src="https://github.com/yshui.png" width="56" alt="picom"/></a>
<a href="https://github.com/dunst-project" title="dunst"><img src="https://github.com/dunst-project.png" width="56" alt="dunst"/></a>
<a href="https://github.com/davatorium" title="rofi"><img src="https://github.com/davatorium.png" width="56" alt="rofi"/></a>
<a href="https://github.com/alacritty" title="Alacritty"><img src="https://github.com/alacritty.png" width="56" alt="Alacritty"/></a>
<a href="https://github.com/mpv-player" title="mpv"><img src="https://github.com/mpv-player.png" width="56" alt="mpv"/></a>
<a href="https://github.com/MusicPlayerDaemon" title="MPD"><img src="https://github.com/MusicPlayerDaemon.png" width="56" alt="MPD"/></a>
<a href="https://github.com/newsboat" title="Newsboat"><img src="https://github.com/newsboat.png" width="56" alt="Newsboat"/></a>
<a href="https://github.com/neomutt" title="NeoMutt"><img src="https://github.com/neomutt.png" width="56" alt="NeoMutt"/></a>
<a href="https://github.com/pwmt" title="zathura"><img src="https://github.com/pwmt.png" width="56" alt="zathura"/></a>
<a href="https://github.com/qutebrowser" title="qutebrowser"><img src="https://github.com/qutebrowser.png" width="56" alt="qutebrowser"/></a>
<a href="https://github.com/jonls" title="redshift"><img src="https://github.com/jonls.png" width="56" alt="redshift"/></a>
<a href="https://github.com/YaLTeR" title="niri"><img src="https://github.com/YaLTeR.png" width="56" alt="niri"/></a>
<a href="https://github.com/Alexays" title="Waybar"><img src="https://github.com/Alexays.png" width="56" alt="Waybar"/></a>
<a href="https://github.com/fish-shell" title="fish"><img src="https://github.com/fish-shell.png" width="56" alt="fish"/></a>
<a href="https://github.com/sharkdp" title="vivid / fd / bat"><img src="https://github.com/sharkdp.png" width="56" alt="vivid / fd / bat"/></a>
<a href="https://github.com/pystardust" title="ytfzf"><img src="https://github.com/pystardust.png" width="56" alt="ytfzf"/></a>
<a href="https://github.com/transmission" title="Transmission"><img src="https://github.com/transmission.png" width="56" alt="Transmission"/></a>
<a href="https://github.com/EliverLara" title="firefox-sweet-theme"><img src="https://github.com/EliverLara.png" width="56" alt="firefox-sweet-theme"/></a>
<a href="https://github.com/starship" title="Starship prompt"><img src="https://github.com/starship.png" width="56" alt="Starship"/></a>
<a href="https://github.com/junegunn" title="fzf"><img src="https://github.com/junegunn.png" width="56" alt="fzf"/></a>
<a href="https://github.com/eza-community" title="eza"><img src="https://github.com/eza-community.png" width="56" alt="eza"/></a>
<a href="https://github.com/tmux" title="tmux"><img src="https://github.com/tmux.png" width="56" alt="tmux"/></a>
<a href="https://github.com/fastfetch-cli" title="Fastfetch"><img src="https://github.com/fastfetch-cli.png" width="56" alt="Fastfetch"/></a>
<a href="https://github.com/brndnmtthws" title="Conky"><img src="https://github.com/brndnmtthws.png" width="56" alt="Conky"/></a>
<a href="https://github.com/arybczak" title="ncmpcpp"><img src="https://github.com/arybczak.png" width="56" alt="ncmpcpp"/></a>
<a href="https://github.com/ranger" title="ranger"><img src="https://github.com/ranger.png" width="56" alt="ranger"/></a>
<a href="https://github.com/tsujan" title="Kvantum"><img src="https://github.com/tsujan.png" width="56" alt="Kvantum"/></a>
<a href="https://github.com/tats" title="w3m"><img src="https://github.com/tats.png" width="56" alt="w3m"/></a>
<a href="https://github.com/firecat53" title="urlscan"><img src="https://github.com/firecat53.png" width="56" alt="urlscan"/></a>
<a href="https://github.com/sigpipe" title="urlview"><img src="https://github.com/sigpipe.png" width="56" alt="urlview"/></a>
<a href="https://github.com/hpjansson" title="chafa (image preview)"><img src="https://github.com/hpjansson.png" width="56" alt="chafa"/></a>
<a href="https://github.com/charmbracelet" title="glow (markdown preview)"><img src="https://github.com/charmbracelet.png" width="56" alt="glow"/></a>
<a href="https://github.com/andreafrancia" title="trash-cli"><img src="https://github.com/andreafrancia.png" width="56" alt="trash-cli"/></a>
<a href="https://github.com/wting" title="autojump"><img src="https://github.com/wting.png" width="56" alt="autojump"/></a>
<a href="https://github.com/realstrawhat" title="csakura (sakura terminal screensaver)"><img src="https://github.com/realstrawhat.png" width="56" alt="csakura"/></a>
<a href="https://github.com/zsh-users" title="zsh-autosuggestions · zsh-syntax-highlighting"><img src="https://github.com/zsh-users.png" width="56" alt="zsh-users"/></a> <!-- group: Shell, prompt & tmux plugins -->
<a href="https://github.com/jorgebucaran" title="fisher (fish plugin manager)"><img src="https://github.com/jorgebucaran.png" width="56" alt="fisher"/></a>
<a href="https://github.com/rafaelrinaldi" title="pure (fish prompt)"><img src="https://github.com/rafaelrinaldi.png" width="56" alt="pure prompt"/></a>
<a href="https://github.com/jethrokuan" title="fzf.fish"><img src="https://github.com/jethrokuan.png" width="56" alt="fzf.fish"/></a>
<a href="https://github.com/oh-my-fish" title="plugin-foreign-env"><img src="https://github.com/oh-my-fish.png" width="56" alt="oh-my-fish"/></a>
<a href="https://github.com/tmux-plugins" title="tpm · sensible · battery · cpu · urlview · yank · copycat"><img src="https://github.com/tmux-plugins.png" width="56" alt="tmux-plugins"/></a>
<a href="https://github.com/yazi-rs" title="full-border · git · chmod · jump-to-char · toggle-pane · smart-enter · piper · vcs-files · catppuccin flavor"><img src="https://github.com/yazi-rs.png" width="56" alt="yazi-rs"/></a> <!-- group: Yazi plugins & flavors -->
<a href="https://github.com/Rolv-Apneseth" title="starship (yazi plugin)"><img src="https://github.com/Rolv-Apneseth.png" width="56" alt="Rolv-Apneseth"/></a>
<a href="https://github.com/DreamMaoMao" title="mime-preview (yazi plugin)"><img src="https://github.com/DreamMaoMao.png" width="56" alt="DreamMaoMao"/></a>
<a href="https://github.com/kalidyasin" title="tokyonight-storm (yazi flavor)"><img src="https://github.com/kalidyasin.png" width="56" alt="kalidyasin"/></a>
<a href="https://github.com/folke" title="snacks · lazy · which-key · trouble · todo-comments · persistence · styler · lazydev · tokyonight"><img src="https://github.com/folke.png" width="56" alt="folke"/></a> <!-- group: Neovim plugin authors -->
<a href="https://github.com/saghen" title="blink.cmp"><img src="https://github.com/saghen.png" width="56" alt="blink.cmp"/></a>
<a href="https://github.com/stevearc" title="conform.nvim"><img src="https://github.com/stevearc.png" width="56" alt="conform.nvim"/></a>
<a href="https://github.com/mfussenegger" title="nvim-lint"><img src="https://github.com/mfussenegger.png" width="56" alt="nvim-lint"/></a>
<a href="https://github.com/nvim-treesitter" title="nvim-treesitter"><img src="https://github.com/nvim-treesitter.png" width="56" alt="nvim-treesitter"/></a>
<a href="https://github.com/nvim-lua" title="plenary.nvim"><img src="https://github.com/nvim-lua.png" width="56" alt="plenary.nvim"/></a>
<a href="https://github.com/nvim-telescope" title="telescope.nvim"><img src="https://github.com/nvim-telescope.png" width="56" alt="telescope.nvim"/></a>
<a href="https://github.com/nvim-tree" title="nvim-web-devicons"><img src="https://github.com/nvim-tree.png" width="56" alt="nvim-web-devicons"/></a>
<a href="https://github.com/nvim-lualine" title="lualine.nvim"><img src="https://github.com/nvim-lualine.png" width="56" alt="lualine.nvim"/></a>
<a href="https://github.com/NeogitOrg" title="neogit"><img src="https://github.com/NeogitOrg.png" width="56" alt="neogit"/></a>
<a href="https://github.com/sindrets" title="diffview.nvim"><img src="https://github.com/sindrets.png" width="56" alt="diffview.nvim"/></a>
<a href="https://github.com/akinsho" title="bufferline.nvim"><img src="https://github.com/akinsho.png" width="56" alt="bufferline.nvim"/></a>
<a href="https://github.com/catgoose" title="nvim-colorizer.lua"><img src="https://github.com/catgoose.png" width="56" alt="nvim-colorizer.lua"/></a>
<a href="https://github.com/petertriho" title="nvim-scrollbar"><img src="https://github.com/petertriho.png" width="56" alt="nvim-scrollbar"/></a>
<a href="https://github.com/ellisonleao" title="gruvbox.nvim"><img src="https://github.com/ellisonleao.png" width="56" alt="gruvbox.nvim"/></a>
<a href="https://github.com/navarasu" title="onedark.nvim"><img src="https://github.com/navarasu.png" width="56" alt="onedark.nvim"/></a>
<a href="https://github.com/sphamba" title="smear-cursor.nvim"><img src="https://github.com/sphamba.png" width="56" alt="smear-cursor.nvim"/></a>
<a href="https://github.com/HiPhish" title="rainbow-delimiters.nvim"><img src="https://github.com/HiPhish.png" width="56" alt="rainbow-delimiters.nvim"/></a>
<a href="https://github.com/windwp" title="nvim-ts-autotag"><img src="https://github.com/windwp.png" width="56" alt="nvim-ts-autotag"/></a>
<a href="https://github.com/OXY2DEV" title="markview.nvim"><img src="https://github.com/OXY2DEV.png" width="56" alt="markview.nvim"/></a>
<a href="https://github.com/iamcco" title="markdown-preview.nvim"><img src="https://github.com/iamcco.png" width="56" alt="markdown-preview.nvim"/></a>
<a href="https://github.com/dstein64" title="vim-startuptime"><img src="https://github.com/dstein64.png" width="56" alt="vim-startuptime"/></a>
<a href="https://github.com/rafamadriz" title="friendly-snippets"><img src="https://github.com/rafamadriz.png" width="56" alt="friendly-snippets"/></a>
<a href="https://github.com/MunifTanjim" title="nui.nvim"><img src="https://github.com/MunifTanjim.png" width="56" alt="nui.nvim"/></a>
<a href="https://github.com/amitds1997" title="remote-nvim.nvim"><img src="https://github.com/amitds1997.png" width="56" alt="remote-nvim.nvim"/></a>
<a href="https://github.com/nemanjamalesija" title="smart-paste.nvim"><img src="https://github.com/nemanjamalesija.png" width="56" alt="smart-paste.nvim"/></a>
<a href="https://github.com/b0o" title="schemastore.nvim"><img src="https://github.com/b0o.png" width="56" alt="schemastore.nvim"/></a>
<a href="https://github.com/alphapapa" title="qutebrowser site themes (solarized-everything-css)"><img src="https://github.com/alphapapa.png" width="56" alt="alphapapa"/></a> <!-- group: Borrowed scripts & themes -->
<a href="https://github.com/seebye" title="ueberzug (image preview backend)"><img src="https://github.com/seebye.png" width="56" alt="seebye"/></a>
<a href="https://github.com/gotbletu" title="shell scripts (urlportal, redshift-toggle)"><img src="https://github.com/gotbletu.png" width="56" alt="gotbletu"/></a>
<a href="https://github.com/chubin" title="cheat.sh (cht.sh)"><img src="https://github.com/chubin.png" width="56" alt="chubin"/></a>
<a href="https://github.com/livibetter" title="pipesX.sh colorscript"><img src="https://github.com/livibetter.png" width="56" alt="livibetter"/></a>
<a href="https://github.com/rossy" title="mpv repl.lua (powers sub-search)"><img src="https://github.com/rossy.png" width="56" alt="rossy"/></a>
<a href="https://github.com/adi1090x" title="Aditya Shakya — rofi applets/launchers/powermenu + polybar config"><img src="https://github.com/adi1090x.png" width="56" alt="adi1090x"/></a>
<a href="https://github.com/arcticicestudio" title=".dir_colors (Nord dircolors)"><img src="https://github.com/arcticicestudio.png" width="56" alt="arcticicestudio"/></a>
<a href="https://github.com/Andr3as07" title="polybar sb-tasks script"><img src="https://github.com/Andr3as07.png" width="56" alt="Andr3as07"/></a>

</div>

<div align="center">
<sub>© 2021 Muhammad Zulqarnain. <a href="LICENSE">MIT License</a>.</sub>
</div>
