<div align="center">
  <h1>lf</h1>
  <p><em>A fast terminal file manager (legacy/secondary).</em></p>
  <a href="https://github.com/gokcehan/lf"><img src="https://img.shields.io/badge/upstream-gokcehan%2Flf-1a1b26?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/gokcehan/lf/stargazers"><img src="https://img.shields.io/github/stars/gokcehan/lf?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-MIT-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

> Built on **[lf](https://github.com/gokcehan/lf)** by Gökçehan Kara. ❤️

A fast terminal file manager, kept around here as the legacy/secondary option — [Yazi](../yazi/README.md) is the primary one for daily work, and lf stays for compatibility and the odd script that still reaches for it. Everything is driven from [`lfrc`](lfrc): settings, custom commands, and keybinds.

Previews come from the `preview` and `cleaner` scripts, with `drawbox`, `icons`, and `ignorecase` turned on and `zsh` as the shell.

### Keybindings

Default lf movement still applies; these are the notable custom maps:

| Key | Action |
|-----|--------|
| `ra` / `rb` / `rc` | rename / bulk-rename / rename to new name |
| `dt` / `dd` / `dD` / `<delete>` | trash / cut / delete / trash |
| `yy` `yp` `yd` `yn` `y.` | copy / yank path / dir / name / name-no-ext |
| `md` `mf` | mkdir / mkfile |
| `au` | unarchive — smart: no wrapper if already single-rooted |
| `az` `at` `ag` `ab` | zip / tar / tar.gz / tar.bz2 (no leading path, auto-renames on collision) |
| `ap` | play hovered file as audio only (no video) |
| `bg` / `bs` | set wallpaper / select wallpaper |
| `cke` / `cku` | make selected file(s) executable / non-executable |
| `tr` / `tc` / `tg` | trash restore / clear / go to trash |
| `ef` `el` | fzf jump / fzf locate |
| `ei` `ee` `eP` | exif info / nvim tabs / nsxiv |

> Archive, `ap`, trash, and `cke/cku` use the same keys and behavior in [yazi](../yazi/README.md); `au` shares yazi's `smart-extract.sh`.
