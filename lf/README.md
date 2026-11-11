# lf

A fast terminal file manager, kept around here as the legacy/secondary option — [Yazi](../yazi/README.md) is the primary one for daily work, and lf stays for compatibility and the odd script that still reaches for it. Everything is driven from [`lfrc`](lfrc): settings, custom commands, and keybinds.

Previews come from the `preview` and `cleaner` scripts, with `drawbox`, `icons`, and `ignorecase` turned on and `zsh` as the shell. A custom `open` command dispatches by MIME type — nsxiv for images, mpv for video, zathura for PDF and djvu, `$EDITOR` for text, YACReader for cbz/cbr, and xlsx2csv/pandoc for spreadsheets and documents. On top of that sit a lot of custom maps: trash-cli deletion, archive extract and create, wallpaper setting, clipboard yanks, SSHFS and KDE Connect mounts, zoxide/fzf jumping, bulk rename, and image-to-pdf. `on-cd` hooks keep the prompt showing git status and zoxide-tracked directories.

### Keybindings

Default lf movement still applies; these are the notable custom maps:

| Key | Action |
|-----|--------|
| `ra` / `rb` / `rc` | rename / bulk-rename / rename to new name |
| `dt` / `dd` / `dD` / `<delete>` | trash / cut / delete / trash |
| `yy` `yp` `yd` `yn` `y.` | copy / yank path / dir / name / name-no-ext |
| `yip` `yij` `yit` `yik` | copy image png / jpg / text / send to phone (KDE Connect) |
| `md` `mf` `mk` `mi` | mkdir / mkfile / mount KDE Connect / mount iso |
| `au` `az` `at` `ag` | unarchive / zip / tar / tar.gz |
| `bg` / `bs` | set wallpaper / select wallpaper |
| `ef` `el` `Z` `zz` | fzf jump / fzf locate / zoxide jump |
| `ei` `ee` `eP` `es` | exif info / nvim tabs / nsxiv / share (0x0.st) |
| `anm` | SSHFS mount anime server |

### Setup

Install `lf`, then the external tools the maps call on: `nsxiv`, `mpv`, `zathura`, `xclip`, `trash-cli`, `zoxide`, `autojump`, `fzf`, `xwallpaper`, `imagemagick` (`convert`), `exiftool`, `rsync`, `sshfs`, `kdeconnect`, and the archive tools (`unrar`, `p7zip`, `zip`/`unzip`, `zstd`). A few maps also reach for scripts under `~/bin/bash_scripts/`.

To change anything, edit [`lfrc`](lfrc) directly or use the `config-edit` command (it opens via `$EDITOR`). The `preview`/`cleaner` scripts handle previewing and cleanup, and `folder` is a small icon/preview helper. Note that the wallpaper, mount, and network paths — things like `anime-mount` and the Firefox new-tab locations — are specific to this machine, so update the IPs and paths for your own setup.
