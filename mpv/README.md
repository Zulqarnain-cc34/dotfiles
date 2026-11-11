<div align="center">
  <img src="../assets/mpv.png" width="80" alt="mpv logo"><br><br>
  <h1>mpv</h1>
  <p><em>The video player — tuned config, handy scripts, sane defaults.</em></p>
  <a href="https://github.com/mpv-player/mpv"><img src="https://img.shields.io/badge/upstream-mpv--player%2Fmpv-61afef?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/mpv-player/mpv/stargazers"><img src="https://img.shields.io/github/stars/mpv-player/mpv?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-GPL--2.0--or--later-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

> Built on **[mpv](https://mpv.io)** by the mpv contributors. ❤️

The media player for this setup. It leans on a small set of Lua scripts to add the things that actually come up while watching: cropping, encoding clips, and a pile of subtitle-study helpers.

Files loop and remember their position when you quit, the window is borderless and autofits to 100%x95% of the screen so it never spills past the edges, and a progress bar sits in the terminal as it plays.

Subtitles get a lot of attention here. External subs and audio autoload fuzzily (no need for exact filename matches), embedded ASS fonts are respected, and plain SRTs get their own Hack-based styling. Track selection follows a language priority: subtitles favour English then German, audio favours Japanese then English then German. There's also an IPC socket at `/tmp/mpv_socket` for driving mpv from the outside, and a handful of per-protocol profiles — HTTP(S) streams are cached behind a spoofed Firefox user-agent, GIFs loop without pausing, and FLAC/MP3 get the terminal bar.

### Keybindings

The custom binds in [`input.conf`](input.conf) mostly drive the scripts:

| Key | Action |
| --- | --- |
| `c` / `alt+c` / `l` | crop — hard / soft / delogo (crop.lua) |
| `C` | toggle crop |
| `d` | remove the crop filter |
| `b` | toggle edge blur (blur-edges.lua) |
| `t` | toggle the seek-to prompt (seek-to.lua) |
| `e` / `alt+e` / `E` | set an encode timestamp — default / webm / slice |
