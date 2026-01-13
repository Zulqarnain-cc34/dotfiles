  
<div align="center">
  <img src="screenshots/logo.png" alt="Logo" width="120" height="120">

  <h1 align="center">Dotfiles</h1>

  <p align="center">
    <b>Aesthetic. Functional. Fast.</b><br>
    My personal configuration files for Linux, tuned for a seamless development workflow.
  </p>

  <p align="center">
    <a href="https://github.com/Zulqarnain-cc34/dotfiles/stargazers"><img src="https://img.shields.io/github/stars/Zulqarnain-cc34/dotfiles?style=for-the-badge&logo=star&color=ffce63" alt="Stars"></a>
    <a href="https://github.com/Zulqarnain-cc34/dotfiles/network/members"><img src="https://img.shields.io/github/forks/Zulqarnain-cc34/dotfiles?style=for-the-badge&logo=git&color=9cf" alt="Forks"></a>
    <a href="https://github.com/Zulqarnain-cc34/dotfiles/issues"><img src="https://img.shields.io/github/issues/Zulqarnain-cc34/dotfiles?style=for-the-badge&logo=github&color=ff6363" alt="Issues"></a>
    <img src="https://img.shields.io/badge/Maintained-Yes-success?style=for-the-badge&logo=check" alt="Maintained">
  </p>
</div>

---

## 🎨 Gallery

<div align="center">
  <img src="screenshots/desktop-4.png" alt="Desktop Rice" width="100%" style="border-radius: 10px; box-shadow: 0px 4px 10px rgba(0,0,0,0.5);">
  <p><i>My clean BSPWM setup with Polybar and customized transparency.</i></p>
</div>

<br>

| **Neovim Dashboard** | **Polybar** |
| :---: | :---: |
| <img src="screenshots/neovim.png" width="95%" style="border-radius: 8px;"> | <img src="screenshots/polybar.png" width="95%" style="border-radius: 8px;"> |

| **Code Editing** | **Telescope / UI** |
| :---: | :---: |
| <img src="screenshots/neovim-1.png" width="95%" style="border-radius: 8px;"> | <img src="screenshots/neovim-2.png" width="95%" style="border-radius: 8px;"> |

---

## 🛠️ Tech Stack

<div align="center">

| **Core** | **Apps** | **CLI Tools** |
| :--- | :--- | :--- |
| <img src="https://img.shields.io/badge/WM-bspwm-black?style=flat-square&logo=linux" /> | <img src="https://img.shields.io/badge/Terminal-Kitty-orange?style=flat-square&logo=terminal" /> | <img src="https://img.shields.io/badge/Shell-Zsh-green?style=flat-square&logo=zsh" /> |
| <img src="https://img.shields.io/badge/Bar-Polybar-blue?style=flat-square" /> | <img src="https://img.shields.io/badge/Browser-Qutebrowser-yellow?style=flat-square" /> | <img src="https://img.shields.io/badge/Text_Editor-Neovim-blueviolet?style=flat-square&logo=neovim" /> |
| <img src="https://img.shields.io/badge/Compositor-Picom-purple?style=flat-square" /> | <img src="https://img.shields.io/badge/Launcher-Rofi-red?style=flat-square" /> | <img src="https://img.shields.io/badge/File_Manager-LF_+_Yazi-teal?style=flat-square" /> |

</div>

<br>

**Other Notable Tools:**
`dunst` (notifications), `mpd/ncmpcpp` (music), `newsboat` (RSS), `tmux` (multiplexer), `fzf`, `ripgrep`.

---

## ✨ Features

- **⚡ Blazing Fast**: Optimized config for minimal latency.
- **🧠 Intelligent Neovim**: Full LSP support (Python, Go, JS/TS, C++, etc.), DAP (Debugging), and Treesitter.
- **🎹 Keyboard Driven**: Ergonomic keybindings for `bspwm`, `tmux`, and `nvim` to keep your hands on the home row.
- **🎨 Consistent Theme**: Unified colorscheme across all applications (Terminal, Editor, Window Manager).
- **🔋 Battery Friendly**: Minimal background services and lightweight daemons.

---

## 🚀 Installation

### 1. Requirements
Ensure you have the following packages installed on your system (names may vary by distro):
```bash
# Arch Linux example
sudo pacman -S bspwm sxhkd polybar rofi kitty zsh neovim picom dunst \
               ranger lf mpv mpd ncmpcpp newsboat brightnessctl playerctl
```

### 2. Clone & Setup
Clone the repository and run the setup script to symlink configurations:

```bash
git clone https://github.com/Zulqarnain-cc34/dotfiles.git
cd dotfiles
chmod +x setup.sh
./setup.sh
```

> **Note:** The `setup.sh` script will create symbolic links from this directory to your `$HOME/.config` and other locations. It checks if the directory exists before linking.

---

## 📂 Structure

A quick look at how the configs are organized:

```tree
dotfiles/
├── bspwm/           # Window Manager
├── polybar/         # Status Bar
├── sxhkd/           # Global Keybindings
├── nvim/            # Neovim IDE
├── zsh/             # Shell Config
├── kitty/           # Terminal
├── rofi/            # Launcher
├── picom.conf       # Compositor (Transparency/Blur)
├── script/          # Utility scripts
└── ...
```

---

<div align="center">
  <p>If you like this configuration, please give it a ⭐ star!</p>
  <p>Made with ❤️ by <a href="https://github.com/Zulqarnain-cc34">Zulqarnain</a></p>
</div>

