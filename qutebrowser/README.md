<div align="center">
  <img src="../assets/qutebrowser.svg" width="72" alt="qutebrowser logo"><br><br>
  <h1>qutebrowser</h1>
  <p><em>A keyboard-driven, Vim-like browser — private by default.</em></p>
  <a href="https://github.com/qutebrowser/qutebrowser"><img src="https://img.shields.io/badge/upstream-qutebrowser%2Fqutebrowser-e06c75?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/qutebrowser/qutebrowser/stargazers"><img src="https://img.shields.io/github/stars/qutebrowser/qutebrowser?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-GPL--3.0-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

> Built on **[qutebrowser](https://qutebrowser.org)** by Florian Bruhin & contributors. ❤️

A keyboard-driven, Vim-like browser built on QtWebEngine — the daily driver here, themed to match the dark desktop and configured to lean private by default: JavaScript is allow-listed per site, third-party cookies are blocked, the built-in ad-blocker runs in `both` mode, and a request interceptor reroutes Reddit, Twitter, YouTube, and Instagram to privacy front-ends. Everything lives in [`config.py`](config.py).

### Keybindings

On top of qutebrowser's defaults, this config adds its own binds:

| Key | Action |
|-----|--------|
| `A` | hint links, open target in `urlportal.sh` |
| `aa` | open current URL in `urlportal.sh` |
| `ak` | send current URL to Android via `kdeconnect-handler` |
| `R` | run the `readability` userscript |
| `wa` | open current page in the Internet Archive |
| `;wa` | hint links → open via Internet Archive |
| `xb` / `xt` / `xx` | toggle statusbar / tabs / both |
| `gF` | view source in editor |
| `,ap` `,dr` `,gr` `,sd` `,sl` | cycle user stylesheet: apprentice / darculized / gruvbox / solarized-dark / solarized-light |

Insert mode also picks up readline-style editing — `<Ctrl-a>`, `<Ctrl-e>`, `<Ctrl-w>`, and `<Ctrl-x><Ctrl-e>` to drop the field into nvim.
