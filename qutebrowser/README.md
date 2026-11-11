<div align="center">
  <img src="../assets/qutebrowser.svg" width="72" alt="qutebrowser logo"><br><br>
  <h1>qutebrowser</h1>
  <p><em>A keyboard-driven, Vim-like browser — private by default.</em></p>
  <a href="https://github.com/qutebrowser/qutebrowser"><img src="https://img.shields.io/badge/upstream-qutebrowser%2Fqutebrowser-e06c75?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/qutebrowser/qutebrowser/stargazers"><img src="https://img.shields.io/github/stars/qutebrowser/qutebrowser?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-GPL--3.0-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

> Built on **[qutebrowser](https://qutebrowser.org)** by Florian Bruhin & contributors. ❤️

The daily-driver browser — Vim-like navigation on QtWebEngine, themed to match the dark desktop.

It's tuned to stay private out of the box: JavaScript runs only on sites you allow, third-party cookies are blocked, the ad-blocker is on, and Reddit, Twitter, YouTube, and Instagram get rerouted to privacy front-ends. It all lives in one [`config.py`](config.py).

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
