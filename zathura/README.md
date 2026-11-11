<div align="center">
  <img src="../assets/zathura.svg" width="72" alt="Zathura logo"><br><br>
  <h1>Zathura</h1>
  <p><em>A minimal, keyboard-driven document viewer.</em></p>
  <a href="https://github.com/pwmt/zathura"><img src="https://img.shields.io/badge/upstream-pwmt%2Fzathura-61afef?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/pwmt/zathura/stargazers"><img src="https://img.shields.io/github/stars/pwmt/zathura?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-Zlib-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

> Built on **[Zathura](https://pwmt.org/projects/zathura/)** by pwmt (Moritz Lipp & contributors). ❤️

A minimal, keyboard-driven document viewer — the PDF reader for this setup, themed to sit quietly inside the dark desktop rather than look like a stray GTK app.

Documents open fit to width in a two-page spread, scrolling is smooth and page-aware, and the GUI chrome is hidden so it's just you and the page. Selected text goes straight to the system clipboard.

### Keybindings

A few binds on top of Zathura's defaults:

| Key | Action |
|-----|--------|
| `Ctrl+p` | Print the document |
| `Ctrl+o` | Open the current file in Firefox |
| `f` | Toggle fullscreen |

The usual Vim-style motions still work — `j`/`k` and `h`/`l` to move, `/` to search, `a`/`s` to fit width/page, `Tab` for the index, `r` to rotate, `+`/`-` to zoom.
