# newsboat

The terminal RSS/Atom reader for this setup — Vim-style keys and, more usefully, a set of macros that hand each link off to whatever tool actually fits it instead of dumping everything into a browser.

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
