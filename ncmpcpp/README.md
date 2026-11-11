# ncmpcpp

The terminal front-end to mpd for this setup — Vim-style keys, a waveform visualizer wired straight into mpd, and album art drawn in the terminal with ueberzug. It opens on the visualizer screen with the playlist riding along as a slave.

The look is the alternative UI with a columns layout, a centered cursor, and cyclic scrolling, dressed in a custom colour scheme and status/column formats. The visualizer reads mpd's FIFO at `/tmp/mpd.fifo` in stereo `wave` mode — so this only works if mpd is actually running and exposing that FIFO. On every song change, `execute_on_song_change` fires `ncmpcpp-ueberzug/ncmpcpp_cover_art.sh` to draw the current album cover. Lyrics are cached under `~/.config/ncmpcpp/lyrics`.

### Keybindings

The [`bindings`](bindings) file replaces the defaults with Vim-flavoured movement; the ones worth remembering:

| Key | Action |
| --- | --- |
| `h` / `l` | parent directory / enter-or-play item |
| `j` / `k` | scroll down / up |
| `g` / `G` | jump home / end |
| `u` / `d` | page up / down (also `ctrl-u` / `ctrl-d`) |
| `f` | browser / toggle browse mode |
| `s` | search engine |
| `m` | media library |
| `t` | tag editor |
| `v` | visualizer |
| `P` | playlist |
| `.` | show lyrics |
| `p` / `s` / `>` / `<` | pause / stop / next / previous |
| `x` | delete playlist item |
| `U` | update database |
| `=` / `+` | volume up / show clock |
| `n` / `p` | next / previous found item |

### Setup

You need `ncmpcpp` and a running `mpd`, plus `ueberzugpp` — it provides the `ueberzug` command the cover-art wrapper calls. The separate `notification` script also wants `mpc`, `ffmpegthumbnailer`, and `libnotify` for its now-playing popup.

The active config is [`config`](config) (with [`config1`](config1) kept as an alternate variant) — colours, formats, and visualizer type all live there. Keys are in [`bindings`](bindings). The [`ncmpcpp-ueberzug/`](ncmpcpp-ueberzug) folder holds the launcher that sets up the ueberzug FIFO before starting ncmpcpp, plus `ncmpcpp_cover_art.sh`; cover-art geometry (padding, `max_width`, `music_library`) is tunable at the top of that script.
