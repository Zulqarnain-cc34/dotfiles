<div align="center">
  <img src="../assets/kitty.svg" width="72" alt="kitty logo"><br><br>
  <h1>kitty</h1>
  <p><em>The primary terminal — GPU-accelerated, fast, endlessly scriptable.</em></p>
  <a href="https://github.com/kovidgoyal/kitty"><img src="https://img.shields.io/badge/upstream-kovidgoyal%2Fkitty-c678dd?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/kovidgoyal/kitty/stargazers"><img src="https://img.shields.io/github/stars/kovidgoyal/kitty?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-GPL--3.0-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

<!-- Screenshot slot: add assets/kitty-shot.png, then uncomment → <div align="center"><img src="../assets/kitty-shot.png" width="80%"></div> -->

> Built on **[kitty](https://sw.kovidgoyal.net/kitty/)** by Kovid Goyal. ❤️

A GPU-accelerated terminal emulator — the primary terminal in this setup, dressed in Tokyo Night (storm) and launching straight into Zsh.

It runs `FiraCode Nerd Font` with the bold and italic faces derived automatically, keeps the background at `background_opacity 0.90` so a little of the desktop shows through, and drops the usual ceremony: `shell_integration` is disabled and `confirm_os_window_close` is off, so closing a window just closes it.

### Keybindings

The one binding worth noting opens a tab where you already are rather than back at `$HOME`:

| Key | Action |
| --- | --- |
| `kitty_mod+t` | New tab in the current working directory |

`kitty_mod` is Ctrl+Shift by default.

### Font size

Font size is the one thing that changes per session, so it's split out of the main config. [`kitty.conf`](kitty.conf) does `include font_size.conf`, and `font_size.conf` is a symlink that [`scripts/link-font-size.sh`](scripts/link-font-size.sh) repoints: it detects BSPWM and `ln -sf`s the matching snippet into place — [`font_size-bspwm.conf`](font_size-bspwm.conf) at size 13 under BSPWM, [`font_size-default.conf`](font_size-default.conf) at size 11 everywhere else (niri and friends). To change a size, edit the relevant snippet and run the script again.

### Setup

Install `kitty`, `ttf-firacode-nerd` for the font, and `zsh` as the shell it launches. The main config — font, colours, opacity, shell, and that one keybinding — lives in [`kitty.conf`](kitty.conf). The [`config/`](config) directory holds extra reference configs (a diff view, a Dracula variant, a no-config fallback) if you want to compare.
