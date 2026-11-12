<div align="center">
  <img src="../assets/yazi.png" width="88" alt="Yazi logo"><br><br>
  <h1>Yazi</h1>
  <p><em>The primary file manager — a fast, vim-keyed Rust TUI.</em></p>
  <a href="https://github.com/sxyazi/yazi"><img src="https://img.shields.io/badge/upstream-sxyazi%2Fyazi-9ece6a?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/sxyazi/yazi/stargazers"><img src="https://img.shields.io/github/stars/sxyazi/yazi?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-MIT-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

<!-- Screenshot slot: add assets/yazi-shot.png, then uncomment → <div align="center"><img src="../assets/yazi-shot.png" width="80%"></div> -->

> Built on **[Yazi](https://yazi-rs.github.io)** by sxyazi. ❤️

[Yazi](https://github.com/sxyazi/yazi) ("blazing fast") is an async, Rust-based terminal file manager — it's the daily driver in this repo because it stays responsive on large directories, previews almost anything inline (images, video, PDFs, archives, Jupyter notebooks) using the kitty graphics protocol, and is extensible through a real plugin ecosystem managed by its own package manager, `ya`. This config layers vim-style navigation and a consistent set of custom shortcuts on top of the stock bindings, and keeps the same keys and behavior in [lf](../lf/README.md) wherever the two tools overlap (archive, trash, permissions).

## Requirements

Core: `yazi` itself, plus [`ya`](#package-management-ya) (bundled with the yazi install) for managing plugins/flavors.

External tools the plugins and openers shell out to:

| Tool | Used for |
|---|---|
| `rg` (ripgrep), `fd` | `zg`/`zf` content/filename search |
| `eza` | Directory preview (piped through `piper`) |
| `kitty` | Image/video/PDF preview via the `icat` kitten |
| `ffmpegthumbnailer`, `chafa` | Video/image thumbnailing fallback |
| `exiftool` | EXIF metadata (`ei`) |
| `mpv`, `nsxiv` | Audio-only playback (`ap`), image viewing (`ep`/`eP`) |
| `magick` (ImageMagick) | AVIF/HEIF/JXL preview, image→PDF conversion (`eg`) |
| `nbpreview` (pip) | `.ipynb` preview — **not currently installed**, so notebook previews fail until `pip install nbpreview` is run |

## Package management (`ya`)

Plugins and flavors aren't vendored into this repo — they're declared in [`package.toml`](package.toml) and fetched by yazi's own package manager:

```bash
ya pkg add <owner>/<repo>[:<subdir>]   # install a plugin or flavor, pins it in package.toml
ya pkg upgrade                         # update everything already pinned
ya pkg install                         # fetch everything pinned in package.toml (fresh machine)
ya pkg list                            # show what's installed
```

[`packages.md`](packages.md) keeps the original `ya pkg add` command per plugin, annotated with what each one is wired to (or deliberately left unwired) — useful as an install log/reference, separate from `package.toml`'s machine-readable pins.

## Plugins

Everything below is pinned in `package.toml`. "Active" means it's actually wired into `init.lua`/`keymap.toml`/`yazi.toml` and does something; a couple of entries are installed but intentionally inert, noted as such.

| Plugin | Does | Wired as |
|---|---|---|
| [`full-border`](https://github.com/yazi-rs/plugins/tree/main/full-border.yazi) | Rounded border around every pane | `init.lua` setup, passive |
| [`git`](https://github.com/yazi-rs/plugins/tree/main/git.yazi) | Inline git status signs (`?` untracked, colored unstaged/staged/etc.) | `init.lua` setup + `yazi.toml` fetcher, passive |
| [`smart-enter`](https://github.com/yazi-rs/plugins/tree/main/smart-enter.yazi) | One key to open a file *or* enter a directory | `l` |
| [`chmod`](https://github.com/yazi-rs/plugins/tree/main/chmod.yazi) | Interactive chmod on the selection | `cm` |
| [`jump-to-char`](https://github.com/yazi-rs/plugins/tree/main/jump-to-char.yazi) | Vim-style jump to the next file starting with a letter | `f<char>` |
| [`toggle-pane`](https://github.com/yazi-rs/plugins/tree/main/toggle-pane.yazi) | Show/hide/maximize the parent, current, or preview pane | `gp/gP` `gc/gC` `gv/gV` `gr` |
| [`piper`](https://github.com/yazi-rs/plugins/tree/main/piper.yazi) | Pipes any shell command's output into the preview pane | `yazi.toml` previewer — currently used to preview directories via `eza` |
| [`nbpreview`](https://github.com/AnirudhG07/nbpreview.yazi) | Renders Jupyter notebooks in the preview pane | `yazi.toml` previewer for `*.ipynb` — **broken**, needs the `nbpreview` pip package (not installed) |
| [`eza-preview`](https://github.com/ahkohd/eza-preview.yazi) | Interactive tree/list directory preview with its own toggle keys | Installed, `setup()` called in `init.lua` — **but never registered as a previewer**, so it currently does nothing; `piper` handles directory previews directly instead |

Installed but deliberately unused:
- [`starship`](https://github.com/Rolv-Apneseth/starship.yazi) — prompt integration, left commented out in `init.lua`.
- [`vcs-files`](https://github.com/yazi-rs/plugins/tree/main/vcs-files.yazi) — redundant with `git.yazi`'s fetcher, and its suggested keys would collide with `toggle-pane`'s `gc`.

Installed but **broken** on this yazi version, `setup()` left commented out in `init.lua`:
- [`mime-preview`](https://gitee.com/DreamMaoMao/mime-preview.yazi) — calls the removed/renamed `ya.mgr_emit` API, which throws on every redraw and corrupts the whole UI (header/status/borders stop rendering, panes appear to freeze/flicker). Needs an upstream fix before it can be re-enabled.

## Flavors

Two color flavors are pinned (`catppuccin-mocha`, `tokyonight-storm`), but neither is actually activated — there's no `theme.toml` setting `flavor.dark`/`flavor.light`, so yazi falls back to its built-in default colorscheme.

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
- Modified/untracked files are marked inline (git status, color-coded)

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
