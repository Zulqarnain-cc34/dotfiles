<p align="center">
  <img src="screenshots/logo.png" alt="Logo" width="400"/>
</p>

<h1 align="center">Dotfiles</h1>

<p align="center">
  <em>Dotfiles are like a 💥 secret weapon for productivity, and this repository is my 🏹 arsenal.</em>
</p>

<p align="center">
  <img src="https://img.shields.io/github/license/Zulqarnain-cc34/dotfiles?style=flat-square&color=blue" alt="License"/>
  <img src="https://img.shields.io/github/stars/Zulqarnain-cc34/dotfiles?style=flat-square&color=yellow" alt="Stars"/>
  <img src="https://img.shields.io/github/last-commit/Zulqarnain-cc34/dotfiles?style=flat-square&color=green" alt="Last Commit"/>
</p>

---

These are my personal Linux configuration files for an **Arch Linux** + **bspwm** setup. Feel free to explore, fork, and take whatever you find useful.

## 🖥️ System Overview

| Component | Program |
|-----------|---------|
| 🪟 Window Manager | [bspwm](https://github.com/baskerville/bspwm) |
| 📊 Status Bar | [polybar](https://github.com/polybar/polybar) |
| ✏️ Editor | [neovim](https://github.com/neovim/neovim) |
| 💻 Terminal | [kitty](https://github.com/kovidgoyal/kitty) |
| 📧 Email Client | [neomutt](https://github.com/neomutt/neomutt) |
| 📰 RSS Reader | [newsboat](https://github.com/newsboat/newsboat) |
| 📁 File Manager | [lf](https://github.com/gokcehan/lf) |
| 🚀 Launcher | [rofi](https://github.com/davatorium/rofi) |
| 🔽 Torrent | [transmission](https://transmissionbt.com/) |
| 🎬 Video Player | [mpv](https://github.com/mpv-player/mpv) |
| ✨ Compositor | [picom](https://github.com/yshui/picom) |
| 📈 System Monitor | [conky](https://github.com/brndnmtthws/conky) |
| 🐚 Shell | [zsh](https://www.zsh.org/) + [starship](https://starship.rs/) |

---

## 📑 Table of Contents

- [Screenshots](#-screenshots)
- [Requirements](#-requirements)
- [Installation](#-installation)
- [Configurations](#-configurations)
  - [Desktop](#desktop)
  - [Neovim](#neovim)
  - [Polybar](#polybar)
  - [Kitty](#kitty)
  - [Rofi](#rofi)
  - [Newsboat](#newsboat)
- [Miscellaneous](#-miscellaneous)
- [License](#-license)

---

## 📸 Screenshots

<p align="center">
  <img src="screenshots/desktop-4.png" alt="Desktop Screenshot" width="100%"/>
</p>

---

## 📋 Requirements

Ensure you have the following packages installed via your package manager:

**Core**
- `bspwm` `sxhkd` `polybar` `rofi` `picom` `dunst`

**Terminal & Shell**
- `kitty` or `alacritty`
- `zsh` `fish` `starship`

**Development**
- `neovim` (0.5+)

**Media & Utilities**
- `mpv` `mpd` `ncmpcpp`
- `lf` or `ranger`
- `zathura` `newsboat` `neomutt`

---

## 🔧 Installation

```bash
# Clone the repository
git clone https://github.com/Zulqarnain-cc34/dotfiles.git
cd dotfiles

# Make the setup script executable and run it
chmod +x setup.sh
bash setup.sh
```

The setup script creates symbolic links for all configuration files to their appropriate locations (`~/.config/`, `~/`, etc.).

**To uninstall:**
```bash
bash uninstall.sh
```

---

## ⚙️ Configurations

### Desktop

<p align="center">
  <img src="screenshots/desktop-4.png" alt="Desktop" width="100%"/>
</p>

**Window Manager**: bspwm with sxhkd for keybindings

Key features:
- Tiling window management with smart gaps
- Custom keybindings via `sxhkd`
- Blur and transparency via `picom`
- Desktop notifications with `dunst`

---

### Neovim

<p align="center">
  <img src="screenshots/neovim.png" alt="Neovim" width="100%"/>
</p>
<p align="center">
  <img src="screenshots/neovim-1.png" alt="Neovim LSP" width="100%"/>
</p>
<p align="center">
  <img src="screenshots/neovim-2.png" alt="Neovim Dashboard" width="100%"/>
</p>

A fully-featured IDE-like configuration with ~70% of plugins lazy-loaded for fast startup.

**Features:**
- 🧠 **LSP** — Native [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) with linting, formatting, and code actions
- ⚡ **Autocompletion** — [nvim-compe](https://github.com/hrsh7th/nvim-compe) + [ultisnips](https://github.com/SirVer/ultisnips)
- 🔍 **Fuzzy Finder** — [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- 🌳 **Syntax Highlighting** — [treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- 📂 **File Explorer** — [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua)
- 🎨 **Theme** — [tokyonight](https://github.com/ghifarit53/tokyonight-vim)
- 📊 **Statusline** — [lualine](https://github.com/hoob3rt/lualine.nvim)
- 📑 **Bufferline** — [nvim-bufferline](https://github.com/akinsho/nvim-bufferline.lua)
- ⌨️ **Keybinding Help** — [which-key](https://github.com/folke/which-key.nvim)
- 🏠 **Dashboard** — [dashboard-nvim](https://github.com/glepnir/dashboard-nvim)
- 🔧 **Git Integration** — [fugitive](https://github.com/tpope/vim-fugitive) + [gitgutter](https://github.com/airblade/vim-gitgutter)
- 💡 **LSP UI** — [lspsaga](https://github.com/glepnir/lspsaga.nvim)
- 💬 **Comments** — [nerdcommenter](https://github.com/preservim/nerdcommenter)
- 📓 **Notes** — [vimwiki](https://github.com/vimwiki/vimwiki)

📖 **[View Keybindings →](nvim/README.md)**

---

### Polybar

<p align="center">
  <img src="screenshots/polybar.png" alt="Polybar" width="100%"/>
</p>

Custom tweaks on [forest-theme](https://github.com/adi1090x/polybar-themes) with modules from [polybar-scripts](https://github.com/polybar/polybar-scripts).

---

### Kitty

- Custom shell prompt with [zsh](https://github.com/Zulqarnain-cc34/zsh)
- Vim-like features and keybindings
- Background blur and transparency via [picom](https://github.com/yshui/picom)

---

### Rofi

A powerful window switcher, application launcher, and search engine launcher.

**Integrations:**
- 🎬 [YouTube](https://github.com/pystardust/ytfzf) — Search and play videos
- 🌐 [Surfraw](https://github.com/gotbletu/dotfiles_v2/tree/master/normal_user/rofi/.config/rofi/launchers) — Search engines
- 📺 [Twitch](https://github.com/indeedwatson/rofi-twitch) — Browse live streams

Themes sourced from [rofi-themes](https://github.com/davatorium/rofi-themes) and [rofi-collection](https://github.com/Murzchnvok/rofi-collection).

---

### Newsboat

- Vim-like keybindings
- Integrated with `urlportal.sh` to open URLs based on file extension
- Automatic feed updates via cronjob

---

## 🔮 Miscellaneous

| File/Folder | Description |
|-------------|-------------|
| `starship.toml` | [Starship](https://starship.rs/) prompt configuration |
| `conky/` | Lightweight system monitor ([jotack theme](https://github.com/juliojsb/jotack)) |
| `.Xmodmap` | System-level key rebindings |
| `picom.conf` | Compositor for blur, transparency, and animations |
| `dunstrc` | Notification daemon configuration |
| `mimeapps.list` | Default application associations |
| `.tmux.conf` | Tmux terminal multiplexer config |

---

## 📂 Repository Structure

```
dotfiles/
├── alacritty/       # Alacritty terminal config
├── bspwm/           # Window manager config
├── conky/           # System monitor widgets
├── dunst/           # Notification daemon
├── eww/             # ElKowars Wacky Widgets
├── fish/            # Fish shell config
├── firefox/         # Firefox userChrome
├── kitty/           # Kitty terminal config
├── lf/              # lf file manager
├── mpd/             # Music Player Daemon
├── mpv/             # Video player config
├── mutt/            # Email client
├── ncmpcpp/         # MPD client
├── newsboat/        # RSS reader
├── nvim/            # Neovim (IDE setup)
├── polybar/         # Status bar
├── qutebrowser/     # Keyboard-driven browser
├── ranger/          # File manager
├── rofi/            # Application launcher
├── screenshots/     # Rice screenshots
├── sxhkd/           # Keybinding daemon
├── zathura/         # PDF viewer
├── zsh/             # Zsh shell config
└── ...
```

---

## 📜 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  <strong>⭐ If you find this useful, consider giving it a star!</strong>
</p>

<p align="center">
  Made with ❤️ by <a href="https://github.com/Zulqarnain-cc34">Zulqarnain</a>
</p>
