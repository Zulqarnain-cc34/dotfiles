# lf

A fast terminal file manager, kept around here as the legacy/secondary option — [Yazi](../yazi/README.md) is the primary one for daily work, and lf stays for compatibility and the odd script that still reaches for it. Everything is driven from [`lfrc`](lfrc): settings, custom commands, and keybinds.

Previews come from the `preview` and `cleaner` scripts, with `drawbox`, `icons`, and `ignorecase` turned on and `zsh` as the shell.

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
