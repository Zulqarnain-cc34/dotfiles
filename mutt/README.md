# mutt color themes

Drop-in colour schemes for **mutt / NeoMutt** — just the palettes. The actual mail config (accounts, mailcap, aliases, sidebar) lives in the repo-root [`.mutt/`](../.mutt); this folder is only about how the inbox looks. Mail runs on **NeoMutt**, sends through `msmtp`, views HTML via `w3m`, and opens inline images in `nsxiv`.

Pick one by `source`-ing it from your NeoMutt config (or from `.mutt/settings`):

```
source ~/path/to/mutt/zenburn.neomuttrc
```

### Themes

| File | Look |
| --- | --- |
| [`solarized-dark-256.neomuttrc`](solarized-dark-256.neomuttrc) · [`mutt-colors-solarized-dark-256.muttrc`](mutt-colors-solarized-dark-256.muttrc) | Solarized dark |
| [`zenburn.neomuttrc`](zenburn.neomuttrc) | Low-contrast Zenburn |
| [`neonwolf-256.neomuttrc`](neonwolf-256.neomuttrc) | Badwolf-inspired |
| [`vombatidae.neomuttrc`](vombatidae.neomuttrc) | Häggblad's scheme |
| [`atomic.muttrc`](atomic.muttrc) · [`ornuit.muttrc`](ornuit.muttrc) · [`mutt-theme.muttrc`](mutt-theme.muttrc) | Rounding out the set |
| [`linux-background-theme.linux`](linux-background-theme.linux) · [`xterm-white-background.default`](xterm-white-background.default) | Terminal background tweaks |

Most want a 256-colour terminal.
