# Yazi Keymap Configuration

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
- `az/at/ag/ab` - Create ZIP/TAR/TAR.GZ/TAR.BZ2
- `au` - Extract archive

### Utilities
- `;/:` - Shell command (interactive/block)
- `ee` - Open with editor
- `ei/eg/ep/eP` - EXIF/PDF/sxiv preview
- `tr/tc/tg` - Trash restore/clear/go to trash
