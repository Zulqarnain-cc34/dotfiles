# surfraw

Surfraw turns web searches into shell commands — each search provider is an "elvis" you call by name, so looking something up never means opening a browser first. This is the config plus a handful of custom elvi layered on top of the ones surfraw ships with.

[`conf`](conf) sets the browsers: `firefox` as the graphical browser, `w3m` as the text browser, and `SURFRAW_graphical=yes` so results open in Firefox by default. The [`elvi/`](elvi) directory holds the custom search providers, each an executable `sh` script.

### The custom elvi

- **Dev / OS** — `arcolinux`, `osdev`, `awesomeopensource`, `dato`
- **Media / social** — `twitter`, `twitch`, `deviantart`, `slader`
- **Torrent / download** — `piratebay`, `limetorrents`, `eztv`, `RARBG`, `ytsmx`, `moviesforfree`, `zlibrary`
