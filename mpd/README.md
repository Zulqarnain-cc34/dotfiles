<div align="center">
  <img src="../assets/mpd.svg" width="80" alt="MPD logo"><br><br>
  <h1>mpd</h1>
  <p><em>Music Player Daemon — the backend that holds the library.</em></p>
  <a href="https://github.com/MusicPlayerDaemon/MPD"><img src="https://img.shields.io/badge/upstream-MusicPlayerDaemon%2FMPD-c678dd?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/MusicPlayerDaemon/MPD/stargazers"><img src="https://img.shields.io/github/stars/MusicPlayerDaemon/MPD?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-GPL--2.0-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

> Built on **[MPD](https://www.musicpd.org)** by Max Kellermann & the MPD project. ❤️

Music Player Daemon — the quiet backend that holds the music library and feeds the clients. Nothing here is user-facing; ncmpcpp (or `mpc`) does the talking, mpd just plays.

The library lives at `~/Music/` and re-scans itself whenever files change. State, database, and playlists all sit under `~/.config/mpd/`. The daemon binds to `127.0.0.1` only, so it's reachable at `localhost:6600` and nowhere else.
