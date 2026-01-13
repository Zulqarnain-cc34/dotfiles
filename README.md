  
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
| <img src="https://img.shields.io/badge/Bar-Polybar-blue?style=flat-square" /> | <img src="https://img.shields.io/badge/Browser-firefox-yellow?style=flat-square&logo=firefox" /> | <img src="https://img.shields.io/badge/Text_Editor-Neovim-blueviolet?style=flat-square&logo=neovim" /> |
| <img src="https://img.shields.io/badge/Compositor-Picom-purple?style=flat-square" /> | <img src="https://img.shields.io/badge/Launcher-Rofi-red?style=flat-square" /> | <img src="https://img.shields.io/badge/File_Manager-LF_+_Yazi-teal?style=flat-square" /> |

</div>

<br>

**Other Notable Tools:**
`dunst` (notifications), `mpd/ncmpcpp` (music), `newsboat` (RSS), `tmux` (multiplexer), `fzf`, `ripgrep`.

---

## ⌨️ Cheatsheet & Keybindings

Don't memorize everything at once. Here are the **critical** keybindings to get you started.

#### 🪟 Window Manager (BSPWM)
| Keybinding | Action |
| :--- | :--- |
| **`Super + T`** | Open Terminal (Kitty) |
| **`Super + Space`** | App Launcher (Rofi) |
| **`Super + Shift + Q`** | Close Focused Window |
| **`Super + H/J/K/L`** | Focus Window (Left/Down/Up/Right) |
| **`Super + D`** | Toggle Floating Mode |
| **`Super + F`** | Toggle Fullscreen |
| **`Super + Alt + R`** | Reload BSPWM |
| **`Super + 1-9`** | Switch Workspaces |

#### 🚀 Apps & Tools
| Keybinding | Action |
| :--- | :--- |
| **`Alt + N`** | Newsboat (RSS Reader) |
| **`Super + M`** | NCMPCPP (Music Player) |
| **`Super + W`** | Firefox |
| **`Super + E`** | Neomutt (Email) |

#### 🖼️ Tmux (Multiplexer)
> **Note:** The prefix key is changed to **`Ctrl + A`** (like GNU Screen) instead of the default `Ctrl + B`.

| Keybinding | Action |
| :--- | :--- |
| **`Ctrl + A`**, then **`c`** | Create new window |
| **`Ctrl + A`**, then **`v`** | Split vertically |
| **`Ctrl + A`**, then **`h`** | Split horizontally |
| **`Ctrl + A`**, then **`H/J/K/L`** | Navigate Panes |

---

## 🧩 Module Deep Dive

### 🧠 Neovim (IDE)
My pride and joy. This Neovim config is designed to replace VSCode entirelly.
- **Lazy Loading**: Plugins load only when you need them (~50ms startup time).
- **LSP**: Native support for Python, Go, C++, Rust, Lua, and Web (JS/TS/HTML/CSS).
- **Aesthetics**: Tokyonight theme, custom statusline (Lualine), and dashboard.
- **Git**: `Lazygit` integration and `Gitsigns` for line-by-line diffs.

### 🐚 ZSH & Terminal
- **Prompt**: Uses `Starship.rs` for a blazing fast, informative prompt.
- **Completion**: `zsh-autosuggestions` and `zsh-syntax-highlighting`.
- **Aliases**: `ls` -> `exa` (icons), `cat` -> `bat` (syntax highlighting).

### 📺 Polybar
A clean, forest-themed bar with custom scripts for:
- 🎵 Music status (MPD)
- 📅 Date & Time
- 💻 CPU/RAM usage
- 📶 Network connectivity
- 🔋 Battery status

---

## 🚀 Installation

### 1. Requirements
Ensure you have the following packages installed on your system (names may vary by distro). This setup is designed primarily for **Arch Linux**.

```bash
# Arch Linux
sudo pacman -S bspwm sxhkd polybar rofi kitty zsh neovim picom dunst \
               ranger lf mpv mpd ncmpcpp newsboat brightnessctl playerctl \
               tmux starship bat exa twisted # ...and fonts!
```

> **Fonts are crucial!** Make sure you install [Nerd Fonts](https://www.nerdfonts.com/) (specifically **JetBrains Mono Nerd Font** or **Iosevka**) for icons to appear correctly.

### 2. Clone & Setup
Clone the repository and run the setup script to symlink configurations:

```bash
git clone https://github.com/Zulqarnain-cc34/dotfiles.git
cd dotfiles
chmod +x setup.sh
./setup.sh
```

> **Note:** The `setup.sh` script handles symlinking automatically. It will back up or warn about existing configs in your `~/.config` directory.

---

## 🤝 Troubleshooting

**Q: Icons are missing in Polybar/Neovim!**
> **A:** You are likely missing a Nerd Font. Install `ttf-jetbrains-mono-nerd` or download one manually from the [Nerd Fonts website](https://www.nerdfonts.com/font-downloads).

**Q: Keybindings aren't working.**
> **A:** Ensure `sxhkd` is running. You can check with `pgrep -a sxhkd`. If not, run standard `sxhkd &` in your terminal to see if it spits out errors.

**Q: The setup script failed.**
> **A:** Check permissions. Run `ls -la setup.sh` to ensure it is executable. Also, make sure you have `git` and `bash` installed.

---

<div align="center">
  <p>If you like this configuration, please give it a ⭐ star!</p>
  <p>Made with ❤️ by <a href="https://github.com/Zulqarnain-cc34">Zulqarnain</a></p>
</div>

