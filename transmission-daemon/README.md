# transmission-daemon

A headless BitTorrent client that runs quietly in the background and takes its orders over an RPC interface — this is the download workhorse of the setup, kept firmly on a short leash.

The RPC interface is enabled but bound to `127.0.0.1` on port `9091` (under `/transmission/`), so it answers only to localhost and is never exposed to the network. A client whitelist (`127.0.0.1`) and host whitelist are both on for good measure, and a salted password hash sits in `settings.json` with authentication available but not currently required. A blocklist is enabled too, pulling iBlockList's "level1" P2P list into `blocklists/` (with `.bin` as Transmission's compiled form).

### Usage

Start the daemon, then drive it from the web UI at `http://127.0.0.1:9091/transmission/`, from `transmission-remote`, or from any RPC client like `transmission-remote-gtk`. One thing to remember: stop the daemon before editing [`settings.json`](settings.json), or it will overwrite your changes when it exits.
