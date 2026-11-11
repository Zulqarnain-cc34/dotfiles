<div align="center">
  <img src="../assets/transmission.svg" width="76" alt="Transmission logo"><br><br>
  <h1>transmission-daemon</h1>
  <p><em>A headless BitTorrent client, driven over RPC.</em></p>
  <a href="https://github.com/transmission/transmission"><img src="https://img.shields.io/badge/upstream-transmission%2Ftransmission-e06c75?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/transmission/transmission/stargazers"><img src="https://img.shields.io/github/stars/transmission/transmission?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-GPL--2.0-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

> Built on **[Transmission](https://transmissionbt.com)** by the Transmission project. ❤️

A headless BitTorrent client that runs quietly in the background and takes its orders over an RPC interface — this is the download workhorse of the setup, kept firmly on a short leash.

The RPC interface is enabled but bound to `127.0.0.1` on port `9091` (under `/transmission/`), so it answers only to localhost and is never exposed to the network. A client whitelist (`127.0.0.1`) and host whitelist are both on for good measure, and a salted password hash sits in `settings.json` with authentication available but not currently required. A blocklist is enabled too, pulling iBlockList's "level1" P2P list into `blocklists/` (with `.bin` as Transmission's compiled form).

### Usage

Start the daemon, then drive it from the web UI at `http://127.0.0.1:9091/transmission/`, from `transmission-remote`, or from any RPC client like `transmission-remote-gtk`. One thing to remember: stop the daemon before editing [`settings.json`](settings.json), or it will overwrite your changes when it exits.
