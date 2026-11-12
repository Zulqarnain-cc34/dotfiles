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

A clean, organized keymap for [Yazi](https://github.com/sxyazi/yazi) file manager with vim-style navigation and powerful shortcuts. These are my most used commands.

## Key Bindings

### Navigation
- `j/k` - Move down/up (no wrap)
- `l/h` - Open/go back (smart enter for open)

### Selection
- `<Space>` - Toggle select and move down
- `q or w` - cd into current dir in yazi and close yazi
- `u` - Clear selections and unyank

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
- `tr/tc/tg` - Trash restore/clear/go to trash
