<div align="center">
  <img src="../assets/yazi.png" width="88" alt="Yazi logo"><br><br>
  <h1>Yazi</h1>
  <p><em>The primary file manager — a fast, vim-keyed Rust TUI.</em></p>
  <a href="https://github.com/sxyazi/yazi"><img src="https://img.shields.io/badge/upstream-sxyazi%2Fyazi-9ece6a?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/sxyazi/yazi/stargazers"><img src="https://img.shields.io/github/stars/sxyazi/yazi?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-MIT-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

> Built on **[Yazi](https://yazi-rs.github.io)** by sxyazi. ❤️

A fast, async terminal file manager with inline previews (images, video, PDFs, archives) via kitty's graphics protocol. Under the hood it's async and multi-threaded top to bottom: listing a directory, decoding a thumbnail, and hashing a file for its cache all happen off the main thread, so a folder with ten thousand files feels exactly as instant as one with ten. That speed is the whole reason it replaced lf/ranger as the daily driver here.

**A few of the things that make it worth switching to:**

- 🚀 **Fully async I/O** — nothing blocks the UI, work is spread across threads
- 🖼️ **Inline previews everywhere** — images, video, PDFs, archives, code, even directories, rendered through the kitty graphics protocol (Überzug++/Chafa as fallback)
- 🔌 **Real plugin system** — UI, previewers, fetchers, and spotters are just Lua; see the [Plugins](#plugins) table below for what's active here
- 📦 **Built-in package manager** (`ya`) — one command to install, pin, or upgrade a plugin or flavor
- 🧰 **Native `ripgrep`/`fd` integration** — `zg`/`zf` in this config search file contents and names without a plugin
- 🔄 **Bulk rename, smart archive extraction, multi-tab** — the stuff you reach for daily, not buried behind config

### Plugins

| Plugin | Key | Note |
|---|---|---|
| `git` | — | Inline status signs; directories show the worst status of anything inside them |
| `smart-enter` | `l` | Open file or enter directory in one key |
| `chmod` | `cm` | Interactive chmod on the selection |
| `jump-to-char` | `f<char>` | Jump to next file starting with a letter |
| `toggle-pane` | `gp/gP` `gc/gC` `gv/gV` `gr` | Show/hide/maximize parent, current, preview panes |
| `full-border` | — | Rounded pane borders |
| `piper` | — | Pipes `eza` into the directory preview |
| `eza-preview` | — | Installed, inactive (never registered as a previewer) |
| `vcs-files`, `starship` | — | Installed, unused |
| `mime-preview` | — | Installed, **disabled** — breaks the UI on 26.9.1 (calls a removed API) |

Two flavors (`catppuccin-mocha`, `tokyonight-storm`) are pinned but not activated; no `theme.toml` means the default colorscheme is in use.

## Key Bindings

### Navigation
- `j/k` - Move down/up (no wrap)
- `l/h` - Open/go back (smart enter for open)
- `gg/G` or `<Home>/<End>` - Go to top/bottom
- `gf` - Follow hovered symlink

### Selection
- `<Space>` - Toggle select and move down
- `q or w` - cd into current dir in yazi and close yazi
- `u` - Clear selections and unyank

### Search / Sort / View
- `/` `?` - Find file forward/backward
- `n/N` - Next/previous match
- `zg/zf` - Search file contents (ripgrep) / filenames (fd)
- `f<char>` - Jump to next file starting with `<char>`
- `.` - Toggle hidden files
- `sb/se/sn/ss/st` - Sort by creation/extension/name/size/modified time
- `zi` - Show file info (spot popup)
- `gp/gP` `gc/gC` `gv/gV` - Show-hide / maximize-restore parent, current, preview panes
- `gr` - Reset pane layout to configured ratio

### Copy/Paste
- `yy` - Copy files
- `dd` - Cut files
- `p` - Paste
- `P` - Paste (force overwrite)
- `yp/yd/yn` - Copy path/dirname/filename

### Create/Rename
- `md` - Create directory
- `mf` - Create file
- `ra/rc/re` - Rename (start/ext/ext only)

### Delete
- `dt` - Trash
- `dD` - Permanent delete
- `<Delete>` - Trash

### Archive
- `az/at/ag/ab` - Create ZIP/TAR/TAR.GZ/TAR.BZ2 (packs all selected, named after the last one, auto-renames on collision)
- `au` - Extract archive(s) (smart: no wrapper if already single-rooted, auto-renames on collision, skips non-archives)

### Utilities
- `;/:` - Shell command (interactive/block)
- `ee` - Open with editor
- `ei/eg/ep/eP` - EXIF/PDF/nsxiv preview
- `ap` - Play hovered file as audio only (no video)
- `bg` - Set hovered image as desktop wallpaper
- `cke/cku` - Make selected file(s) executable / non-executable
- `cm` - Chmod on selected files (interactive)
- `tr/tc/tg` - Trash restore/clear/go to trash

> Archive (`az/at/ag/ab/au`), audio-only play (`ap`), trash (`dt`/`tr/tc/tg`), and permissions (`cke/cku`) use the same keys and behavior in [lf](../lf/README.md) and [ranger](../ranger/README.md).
