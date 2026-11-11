# newsboat

The terminal RSS/Atom reader for this setup — Vim-style keys and, more usefully, a set of macros that hand each link off to whatever tool actually fits it instead of dumping everything into a browser.

Navigation is the familiar `j`/`k` to move, `h`/`BACKSPACE` to back out, `H`/`L` to flip between feeds, `l`/`RIGHT` to open, and `c` to toggle read feeds. Feeds reload every 150 minutes across 4 parallel threads, and new articles ping a desktop notification through `nb-notify`. The default browser is `~/bin/bash_scripts/urlportal.sh`, a link dispatcher; each macro temporarily swaps the browser to its own tool, opens the link, then restores the portal. Feeds themselves — query feeds and tag-grouped sources like Reddit, Programming, YouTube, and Linux — are defined in [`urls`](urls).

### Macros

Macros run off the prefix key `i` — press `i`, then the macro letter:

| Macro | Action |
| --- | --- |
| `i`,`r` | open the Reddit thread in `tuir` |
| `i`,`p` | play the link in `mpv` |
| `i`,`c` | YouTube comments via `pipe-viewer --comments` |
| `i`,`s` | launch `pipe-viewer` (search) |
| `i`,`o` | open in terminal `w3m` (`$TERMINAL`) |
| `i`,`i` | download the image with `wget` and view it in `feh` |
| `i`,`y` | copy the URL to the clipboard with `xclip` |

### Setup

Install `newsboat` and `libnotify`, and make sure `~/bin/bash_scripts/urlportal.sh` exists — it's the dispatcher everything falls back to. The macros assume their tools are on hand: `tuir`, `mpv`, `pipe-viewer`, `w3m`, `wget` + `feh`, and `xclip`.

Settings, macros, keys, and the colour theme all live in [`config`](config); add or regroup feeds in [`urls`](urls). The `nb.notify` script is the `notify-send` wrapper invoked as `nb-notify`.
