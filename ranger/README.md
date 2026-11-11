# ranger

A Python-based terminal file manager, kept here as the legacy/secondary option — [Yazi](../yazi/README.md) handles daily work, and ranger stays for occasional use and the scripts that still call it. Options and keybindings live in [`rc.conf`](rc.conf), with [`rifle.conf`](rifle.conf) holding the file-opener rules that decide which app handles which type.

It runs in the familiar Miller-column layout (`column_ratios 1,3,4`) with borders drawn and a custom colorscheme. Image previews go through `scope.sh` using the **ueberzug** method (`preview_images_method ueberzug`).

### Keybindings

Default ranger movement still applies; these are the notable custom maps from `rc.conf`:

| Key | Action |
|-----|--------|
| `zi` / `zh` / `<C-h>` | toggle image preview / show hidden |
| `gzu` `gzz` `gzr` `gzn` | gunzip / gzip / gzip -r / gunzip -r |
| `etu` | tar extract (`tar -xvf`) |
| `yLd` `yip` `yij` `yit` `yik` | copy to Downloads / image png / jpg / text / send to phone |
| `bg` | set wallpaper (`cp` to `~/.config/wall.png` + `feh --bg-scale`) |
| `gsx` `gsw` `gss` | nsxiv all / set wallpaper from nsxiv marks (recursive / selection) |
| `gkm` / `gkz` | mount / unmount KDE Connect phone (sftp) |
| `gkg` `gku` `gks` | rclone mount / unmount / sync Google Drive |
| `cke` `cku` `cfm` | chmod +x / -x / flac→mp3 batch |
| `ei` `emp` `ef` `el` | exif info / mpv dvd / fzf select / fzf locate |
| `<F8>` / `<DELETE>` / `dT` | trash |
