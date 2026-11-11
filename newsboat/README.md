<div align="center">
  <img src="../assets/newsboat.svg" width="76" alt="Newsboat logo"><br><br>
  <h1>newsboat</h1>
  <p><em>Terminal RSS/Atom reader with per-link macros.</em></p>
  <a href="https://github.com/newsboat/newsboat"><img src="https://img.shields.io/badge/upstream-newsboat%2Fnewsboat-9ece6a?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/newsboat/newsboat/stargazers"><img src="https://img.shields.io/github/stars/newsboat/newsboat?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-MIT-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

> Built on **[Newsboat](https://newsboat.org)** by Alexander Batischev & the Newsboat project. ❤️

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
