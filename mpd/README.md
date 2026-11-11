# mpd

Music Player Daemon — the quiet backend that holds the music library and feeds the clients. Nothing here is user-facing; ncmpcpp (or `mpc`) does the talking, mpd just plays.

The library lives at `~/Music/` and re-scans itself whenever files change. State, database, and playlists all sit under `~/.config/mpd/`, and `restore_paused` means a paused track stays paused across restarts. The daemon binds to `127.0.0.1` only, so it's reachable at `localhost:6600` and nowhere else.

There are two audio outputs. The first is a PulseAudio output for actual playback — which works fine on PipeWire through its `pipewire-pulse` drop-in. The second is a FIFO at `/tmp/mpd.fifo` (`44100:16:2`), and that one exists purely to feed ncmpcpp's visualizer; its path has to match ncmpcpp's `visualizer_fifo_path`. There are ALSA output blocks too, left in but commented out.

### Setup

Install `mpd`, plus `pulseaudio` or `pipewire-pulse` for the pulse output, and a client like `ncmpcpp` or `mpc`. Run it as a user service or directly with `mpd ~/.config/mpd/mpd.conf`, then point your client at `localhost:6600`.

Everything is in one file, [`mpd.conf`](mpd.conf): swap the `audio_output` blocks to move between pulse and ALSA, or change `music_directory` to use a different library. Just keep the FIFO path in sync with ncmpcpp if you touch it.
