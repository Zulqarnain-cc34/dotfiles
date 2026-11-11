<div align="center">
  <img src="../assets/rofi.png" width="96" alt="Rofi logo"><br><br>
  <h1>Rofi</h1>
  <p><em>Launcher, window switcher, and power menu for the rice.</em></p>
  <a href="https://github.com/davatorium/rofi"><img src="https://img.shields.io/badge/upstream-davatorium%2Frofi-e06c75?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/davatorium/rofi/stargazers"><img src="https://img.shields.io/github/stars/davatorium/rofi?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-MIT-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

<!-- Screenshot slot: add assets/rofi-shot.png, then uncomment → <div align="center"><img src="../assets/rofi-shot.png" width="70%"></div> -->

> Built on **[Rofi](https://davatorium.github.io/rofi/)** by Dave Davenport. ❤️

The application launcher and dmenu stand-in for this BSPWM/X11 setup — it also handles the power menu and feeds a handful of smaller dmenu-style tools. [`config.rasi`](config.rasi) points the default theme at the **ribbon** launcher (`@theme "launchers/ribbon/ribbon_left.rasi"`); the stock ribbon colorscheme is a bit flat on its own, so the launcher scripts paint over it on every run.

The main pieces are a drun launcher in the ribbon theme and a separate power menu covering shutdown, reboot, lock, suspend, and logout — each with its own layouts. Beyond those, `launchers/` carries extra dmenu menus (web search, snippets, KeePassXC, bookmarks, manga, `locate`, and friends), with panel applets living under `applets/` and `bin/`.

### Running it

Launch apps with `bin/launcher_ribbon` (or `launchers/ribbon/launcher.sh`), which just shows `rofi -show drun`. The power menu is `powermenu/powermenu` (or `bin/powermenu`), and it routes destructive choices through a `confirm.rasi` prompt first.

Both launcher scripts pick a random layout and a random color on each run, sliding the choice into `styles/colors.rasi` with `sed`. If you'd rather pin a fixed look, comment the `sed` and `themes=` lines near the top of the script and set `theme=` to the one you want.

### Setup

Install `rofi` itself, then the helpers the power menu leans on: `systemd` (`systemctl`), `i3lock` or `betterlockscreen` for locking, plus `mpc`, `alsa-utils` (`amixer`), and `bspwm` (`bspc`). For theming you'll want a Nerd Font — the ribbon layout asks for `FantasqueSansMono Nerd Font` — and `papirus-icon-theme`.

The config spreads across a few directories: [`config.rasi`](config.rasi) for the global default import, `launchers/ribbon/` for the ribbon layouts (`ribbon_*`, `full_*`) and `launcher.sh` plus the eight color variants under `styles/`, `powermenu/` for the power-menu layouts (`card_*`, `column_*`, `dock_*`, `drop_*`, `full_*`, `row_*`) alongside `confirm.rasi`, `message.rasi`, and the `powermenu` script, and `bin/` for the entry scripts (`launcher_ribbon`, `menu_*`, `applet_*`). To change the default theme, edit `config.rasi` or the `theme=` line in whichever launcher script you run.
