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
| `ra` / `rb` | rename (built-in, pre-filled, cursor before extension) / bulk-rename (edit a list of names in `$EDITOR`) |
| `P` | paste as symlink/hardlink (two-stage: stage with `yy`-equivalent, then `P` to link) |
| `eD` | move selected file(s) into a new folder (prompts for the folder name) |
| `Sf` / `Sd` | select all visible files / select all visible directories |
| `dt` / `dd` / `dD` / `<delete>` | trash / cut / delete / trash |
| `du` | show a folder size breakdown (`du --max-depth=1`) |
| `yy` `yLd` `yp` `yd` `yn` `y.` | copy / copy to `~/Downloads` / yank path / dir / name / name-no-ext |
| `uv` / `uy` | clear the file selection / clear the copy-cut clipboard (these are different things in lf) |
| `md` `mf` | mkdir / mkfile |
| `ch` / `cr` / `cd` | chmod (interactive, prompts for mode bits) / strip spaces from filename / `cd` prompt |
| `cke` / `cku` | make selected file(s) executable / non-executable |
| `au` | unarchive — smart: no wrapper if already single-rooted |
| `az` `at` `ag` `ab` | zip / tar / tar.gz / tar.bz2 (no leading path, auto-renames on collision) |
| `ap` | play hovered file as audio only (no video) |
| `Vna` / `Vaa` | strip audio from video / extract audio from video (ffmpeg) |
| `bg` / `bs` | set wallpaper directly / browse this folder's images in nsxiv and pick one — navigate, then press **`Q`** (capital) on the thumbnail you want, not Enter or double-click |
| `tr` / `tc` / `tg` | trash restore / clear / go to trash |
| `sa` `sc` `se` `sn` `ss` `st` | sort by atime / ctime / extension / name (natural) / size / mtime, each reversed |
| `zA` / `zc` | show atime / ctime in the linemode info column |
| `o` | open with (prompts for a command) |
| `.` | toggle hidden files |
| `ef` `el` | fzf jump / fzf locate |
| `ei` `ee` `eP` | exif info / nvim tabs / nsxiv |
| `ed` `ec` `em` `eg` `ep` | play as DVD (mpv) / vimdiff selected files / compose mail with selection attached / convert image(s) to PDF / browse this folder's images in nsxiv (view only, no wallpaper action) |

> `au` shares yazi's `smart-extract.sh`.
>
> **Known broken, not yet fixed**: `re`/`ri` (rename with cursor pre-positioned before the extension / at the start) and `zb` (zoxide jump variant) are defined in `lfrc` but don't work — `re`/`ri` hit the same `push :rename<space>...` limitation that made `rc` non-functional (lf's `rename` is modal-only and discards anything submitted via the command line), and `zb` calls `z-jump`, a command that's never actually defined anywhere in this config (same root cause as the `Z`/`zz` bindings that were removed outright).
