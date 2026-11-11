<div align="center">
  <h1>sxhkd</h1>
  <p><em>Every global keybinding in the BSPWM session, in one place.</em></p>
  <a href="https://github.com/baskerville/sxhkd"><img src="https://img.shields.io/badge/upstream-baskerville%2Fsxhkd-1a1b26?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/baskerville/sxhkd/stargazers"><img src="https://img.shields.io/github/stars/baskerville/sxhkd?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-BSD--2--Clause-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

> Powered by **[sxhkd](https://github.com/baskerville/sxhkd)** by Bastien Dejean (baskerville). ❤️

The Simple X hotkey daemon — a small program that listens for key combos and fires off commands. Here it owns every global keybinding in the BSPWM session, from window management to app launchers, so all the muscle memory lives in one place.

It's started as `sxhkd &` from `bspwm/bspwmrc` and can be reloaded in place with `super + shift + x`, so edits take effect without restarting the session. Bindings cover the full set of `bspc` window-manager actions — focus, move, resize, preselect, and the nine workspaces — alongside launchers and screenshots. The default terminal is `$TERMINAL` (kitty) and the app launcher is the rofi "ribbon".

### Keybindings

The whole map, as bound in [`sxhkdrc`](sxhkdrc):

| Keys | Action |
|------|--------|
| `super + alt + q` / `super + alt + r` | Quit / restart bspwm |
| `super + shift + r` / `super + shift + s` | Reboot / shutdown (with prompt) |
| `super + q` / `super + shift + q` | Close / kill focused window |
| `super + d` | Toggle floating/tiled |
| `super + f` | Cycle desktop layout (monocle) |
| `super + {1-9}` / `super + shift + {1-9}` | Focus / send to desktop 1–9 |
| `super + {h,j,k,l}` | Focus west/south/north/east |
| `ctrl + alt + {Right,Left}` | Next / previous desktop |
| `alt + {Tab,grave}` | Last node / last desktop |
| `super + ctrl + {h,j,k,l}` | Preselect direction |
| `super + ctrl + {1-9}` | Preselect split ratio |
| `super + ctrl + space` | Cancel preselection |
| `super + alt + {h,j,k,l}` | Expand window side |
| `super + alt + shift + {h,j,k,l}` | Contract window side |
| `super + {Left,Down,Up,Right}` | Move floating window |
| `shift + ctrl + {Left,Right}` | Move window to prev/next desktop and follow |
| `super + space` | rofi ribbon launcher |
| `super + t` / `super + r` / `super + y` / `super + o` / `super + w` | Terminal / tuir / ytfzf / htop / firefox |
| `super + m` | neomutt (email) |
| `alt + n` | newsboat (RSS) |
| `super + v` | clipmenu (rofi) |
| `super + p` | polybar powermenu |
| `alt + l` | Lock screen (slock) |
| `Print` / `shift + Print` | Screenshot full / selection (maim) |
| `super + shift + x` | Reload sxhkd |

### Setup

Requires `sxhkd` and `bspwm` (for `bspc`).
