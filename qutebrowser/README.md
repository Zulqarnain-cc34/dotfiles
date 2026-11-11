# qutebrowser

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
