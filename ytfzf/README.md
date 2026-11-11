# ytfzf

Search and play YouTube without leaving the terminal — results pipe through `fzf`, and whatever you pick streams straight into `mpv`. This is the [`conf.sh`](conf.sh) that shapes it: watch/search history, a stay-in-the-loop search after each video, and 1080p-capped playback.

Worth knowing: these settings use the uppercase `YTFZF_*` variable names, the old convention — ytfzf 2.x reads lowercase names instead, so on a current build some of them may simply be ignored. Check `man ytfzf` against your installed version if a setting isn't taking effect.
