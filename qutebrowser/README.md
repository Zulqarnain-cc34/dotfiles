# qutebrowser

A keyboard-driven, Vim-like browser built on QtWebEngine — the daily driver for this setup, configured to lean private by default and themed to match the dark desktop. This is the full [`config.py`](config.py) plus the theming CSS it pulls from.

The defaults are deliberately cautious. JavaScript is off globally and allow-listed per site, cookies are `no-3rdparty`, and autoplay, WebGL, and geolocation all stay disabled. The built-in ad-blocker runs in `both` mode (hosts files plus the Brave lists). Pages render in webpage dark mode, pdfjs is turned off, the default zoom sits at 125%, sessions restore lazily, and downloads land in `~/Downloads`.

Search goes through `searx.be` by default, joined by a pile of bang-style engines — `yt` for Invidious, `aw` for the Arch Wiki, plus `re`, `wiki`, `hoog`, and more. A request interceptor quietly reroutes a handful of sites to privacy front-ends:

- Reddit → teddit
- Twitter → nitter
- YouTube → invidious
- Instagram → bibliogram

File dialogs hand off to `lf` running in an Alacritty window, the UI uses a Nerd Font, and the KDE Qt platform theme keeps it looking at home.

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

### Setup

You'll need `qutebrowser`, `lf`, and `alacritty`, plus a Nerd font like `ttf-ubuntu-mono-nerd`. A few binds expect userscripts on `PATH`: `urlportal.sh`, `readability`, and `kdeconnect-handler`.

Everything lives in [`config.py`](config.py) — settings, binds, search engines, and the redirect interceptor. The [`themes/css/`](themes/css) folders hold the Solarized-Everything-CSS stylesheets cycled by the `,`-binds (apprentice is applied by default); [`filepicker`](filepicker) is the dash script that launches `lf` in Alacritty, and [`greassmonkey/`](greassmonkey) carries a couple of Greasemonkey userscripts (4chan X, DuckDuckGo). To tweak things, edit `config.py` directly — the default stylesheet sits near the bottom in `content.user_stylesheets`, engines in `c.url.searchengines`, and the front-end redirects in `REDIRECT_MAP`.
