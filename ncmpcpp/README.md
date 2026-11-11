# ncmpcpp

The terminal front-end to mpd for this setup — Vim-style keys, a waveform visualizer wired straight into mpd, and album art drawn in the terminal with ueberzug. It opens on the visualizer screen with the playlist riding along as a slave.

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
