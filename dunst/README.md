<div align="center">
  <h1>dunst</h1>
  <p><em>Lightweight notifications, themed to match the desktop.</em></p>
  <a href="https://github.com/dunst-project/dunst"><img src="https://img.shields.io/badge/upstream-dunst--project%2Fdunst-1a1b26?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/dunst-project/dunst/stargazers"><img src="https://img.shields.io/github/stars/dunst-project/dunst?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-BSD--3--Clause-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

> Powered by **[Dunst](https://dunst-project.org)** by Sascha Kruse & the dunst maintainers. ❤️

> **Forking?** `monitor = 1` in `dunstrc` targets my second display — set it to `0` for a single-monitor setup.

The lightweight notification daemon for this BSPWM/X11 setup — a small libnotify server that draws toasts in the top-right corner and stays out of the way. The whole thing lives in one file, [`dunstrc`](dunstrc), which `setup.sh` symlinks into `~/.config/dunst/`; there's no separate root-level copy.

Everything sits on a dark `#131313` background. The three urgency levels differ mainly in how long they linger and their frame color:

| Urgency | Timeout | Frame |
|---------|---------|-------|
| low | 2s | `#2a84d2` (blue) |
| normal | 5s | `#2a84d2` (blue) |
| critical | never (0) | `#f81118` (red) |
