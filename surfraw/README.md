# surfraw

Surfraw turns web searches into shell commands — each search provider is an "elvis" you call by name, so looking something up never means opening a browser first. This is the config plus a handful of custom elvi layered on top of the ones surfraw ships with.

[`conf`](conf) sets the browsers: `firefox` as the graphical browser, `w3m` as the text browser, and `SURFRAW_graphical=yes` so results open in Firefox by default. The [`elvi/`](elvi) directory holds the custom search providers, each an executable `sh` script.

Using it looks like this:

```
surfraw piratebay ubuntu iso       # or the short alias: sr piratebay ...
sr -browser=w3m twitter archlinux  # override the browser per call
```

Run any elvis with no arguments and it just opens the site's homepage.

### The custom elvi

- **Dev / OS** — `arcolinux`, `osdev`, `awesomeopensource`, `dato`
- **Media / social** — `twitter`, `twitch`, `deviantart`, `slader`
- **Torrent / download** — `piratebay`, `limetorrents`, `eztv`, `RARBG`, `ytsmx`, `moviesforfree`, `zlibrary`

A fair few of these point at sites that have since died or moved domains — `RARBG` (→ rarbgget.org), `zlibrary` (→ 3lib.net), `moviesforfree`, and `ytsmx` among them. If a search 404s, open the elvis and update the `w3_browse_url` inside it.

### Setup

Install `surfraw` along with the browsers `conf` references (`firefox` and `w3m`). The config normally lives at `~/.config/surfraw/conf`, and the elvi at `~/.config/surfraw/elvi/`. To add a provider, copy an existing elvis and change its `w3_browse_url` target — or let `mkelvis` from `surfraw-tools` scaffold one for you.
