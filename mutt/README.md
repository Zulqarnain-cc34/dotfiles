# mutt color themes

A small collection of drop-in color schemes for mutt and NeoMutt — just the palettes, nothing else. The real mail client configuration lives elsewhere; this directory is purely about how the inbox looks.

The actual setup is in the repo-root [`.mutt/`](../.mutt), which carries the settings, mailcap, colors, aliases, and sidebar. Mail runs on **NeoMutt**, sending through **`msmtp`** (`set sendmail="/usr/bin/msmtp"`) and talking IMAP with IDLE. HTML parts are auto-viewed through `w3m`, and inline images open in **`nsxiv`** — all wired up in `.mutt/mailcap`.

To use one of these, `source` it from your NeoMutt config:

```
source ~/path/to/mutt/zenburn.neomuttrc
```

The schemes on offer: [`solarized-dark-256.neomuttrc`](solarized-dark-256.neomuttrc) and [`mutt-colors-solarized-dark-256.muttrc`](mutt-colors-solarized-dark-256.muttrc) for Solarized dark, [`zenburn.neomuttrc`](zenburn.neomuttrc) for a low-contrast Zenburn, [`neonwolf-256.neomuttrc`](neonwolf-256.neomuttrc) for a badwolf-inspired look, and [`vombatidae.neomuttrc`](vombatidae.neomuttrc) for Häggblad's scheme. [`atomic.muttrc`](atomic.muttrc), [`ornuit.muttrc`](ornuit.muttrc), and [`mutt-theme.muttrc`](mutt-theme.muttrc) round out the set, with [`linux-background-theme.linux`](linux-background-theme.linux) and [`xterm-white-background.default`](xterm-white-background.default) handling terminal-specific background tweaks. Most of these want a 256-color terminal.

### Setup

The theming helpers assume `neomutt` and `msmtp`, with `w3m`, `nsxiv`, `mpv`, `zathura`, `gpg`, and `urlscan` covering the various mailcap handlers. Pick a scheme by `source`-ing it from `.mutt/settings` (or `.mutt/colors`), and edit the `color` lines inside any `.neomuttrc`/`.muttrc` to adjust individual elements. Anything beyond color — accounts, behaviour, mailcap — belongs in the repo-root [`.mutt/`](../.mutt).
