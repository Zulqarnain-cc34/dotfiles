# ytfzf

Search and play YouTube without leaving the terminal — results get piped through `fzf`, and whatever you pick streams straight into `mpv`. This is the [`conf.sh`](conf.sh) that shapes that behaviour.

Sourced by ytfzf as `~/.config/ytfzf/conf.sh`, the config keeps a watch and search history (`YTFZF_HIST=1`), stays in the search loop after a video finishes instead of quitting (`YTFZF_LOOP=1`), and caps playback at 1080p via the yt-dlp format string `bestvideo[height<=?1080]+bestaudio/best`. The cache lives at `~/.cache/ytfzf`, and `rofi` is set as the external menu (`rofi -dmenu -fuzzy -width 1000`) for when ytfzf runs with `-D`.

Everyday use:

```
ytfzf <query>        # search, pick in fzf, play in mpv
ytfzf -D <query>     # pick in rofi instead
ytfzf -m <query>     # audio-only (music) mode
```

One caveat worth knowing: these settings use the uppercase `YTFZF_*` variable names. Those were the convention for older ytfzf, and ytfzf 2.x reads lowercase names instead — so on a current build some of these may simply be ignored. Check `man ytfzf` against your installed version if a setting isn't taking effect.

### Setup

You'll need `ytfzf`, `yt-dlp`, `mpv`, and `fzf`, plus `rofi` for the external-menu mode; `jq` and `curl` come along as ytfzf's own dependencies. Everything configurable lives in [`conf.sh`](conf.sh) — adjust `YTFZF_PREF` to raise or lower quality, swap the external menu for `dmenu`, or point the cache somewhere else. The `man ytfzf` page has the full variable list.
