# Changelog

All notable changes to this dotfiles repo are documented here.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).  
Versions are dated milestones, not semver releases (this is a personal config repo).

## [2026-11-14] — csakura idle screensaver

### Added
- **csakura cherry-blossom screensaver**, auto-launched when the zsh prompt goes idle.
  - Binary committed at `bash_scripts/csakura` (x86-64 Linux, links `libncursesw.so.6`); patched source + `anykey.patch` + rebuild steps in `bash_scripts/csakura.src/`.
  - Patched upstream v3.0.0 with two flags (diff in `csakura.src/anykey.patch`): `-k` (any key quits, not just `q`/`Esc`) so it dismisses like a proper screensaver, and `-C N` (every N s, regrow into the next tree form + palette).
  - `zsh/.zshrc` arms it via `TMOUT=20` + `TRAPALRM`: blooms after 20s idle at an **empty** prompt (never mid-typing, never over a running command), any key dismisses, reblooms on the next idle. Probes for `-k` and falls back to a stock `q`/`Esc` build if present.
  - Each bloom starts on the next of the 15 palettes (sakura → rose → … → ink → wrap), persisted in `~/.cache/csakura-palette` so the cycle advances across terminals and reboots; while open it drifts form+palette every 45s (`-C 45`).
  - Full writeup incl. edge cases: [docs/csakura.md](docs/csakura.md).

## [2026-11-14] — Per-tool modernization pass + image-preview fix (branch: `modernize-2026`)

### Fixed
- **yazi/lf image previews in alacritty** (was green garbage, then shifted/wrong-window). Three stacked causes: (1) alacritty has no native graphics protocol — installed `ueberzugpp`; (2) kitty's `KITTY_WINDOW_ID`/`WINDOWID` leaked into alacritty when spawned from kitty, so yazi sent the kitty graphics protocol and ueberzugpp drew over the wrong window — `.zshrc` now strips those vars when `$TERM` isn't `xterm-kitty`; (3) `alacritty` spawned as a child of kitty confused ueberzugpp's window detection — added an `alacritty()` zsh wrapper that `setsid -f` detaches it. Launching via rofi/sxhkd was always fine.
- **Config deprecations across the stack** (each validated live against the installed version, not guessed):
  - **sxhkd** — `shift+ctrl+{Left,Right}` move-to-desktop focused the wrong direction (hardcoded `next`); sxhkd reload now `SIGUSR1` not kill+restart; dropped dead reboot/shutdown keys (`prompt` never existed).
  - **bspwm** — autostart daemons `pgrep`-guarded so `bspc wm -r` reloads don't spawn duplicates; removed the obsolete `mplayer2` rule.
  - **picom** (v13) — migrated `opacity-rule`/`wintypes` to the unified `rules` block, dropped `mark-wmwin-focused`/`mark-ovredir-focused` (old-style rule opts), added open/close/resize animations. Zero warnings.
  - **polybar** (3.7) — `tray-*` → `internal/tray` module, dropped `spacing`/`throttle-*`, `content`→`format`, `icon-repeatone`→`icon-single`. Zero warnings.
  - **dunst** (1.13) — removed the deprecated `[shortcuts]` section and invalid `notification_height`/`startup_notification`/`verbosity` keys.
  - **ncmpcpp** (0.10) — `visualizer_fifo_path` → `visualizer_data_source`, deduped repeated options.
  - **mpv** (0.41) — `total_playtime` data file moved out of `scripts/` (mpv tried to load it as a script); gitignored the runtime data.

### Removed
- **Unused template files**: polybar's entire `statusbar/` dir + unused modules/scripts (kept only what `[bar/main]` uses); rofi's orphaned `powermenu/` (36 files); ncmpcpp `config1`.
- Consolidated `screenshots/` into `assets/` (moved the 4 used images, dropped 6 unused, fixed every path, removed the dir).

### Verified clean (no change needed)
- **alacritty** (0.17) already fully migrated (`alacritty migrate --dry-run` = no key changes).

## [2026-11-14] — Neovim modernization, doc reviews, README credits (branch: `modernize-2026`, merged to `main`)

### Changed
- **Neovim** brought fully up to date (nvim 0.12), reviewed file by file: native 0.11+ LSP (`lsp/<server>.lua` overrides + one `vim.lsp.enable`, schemastore `jsonls` deferred to the first JSON file), Tree-sitter `main` branch (parsers compile via the tree-sitter CLI), conform.nvim + nvim-lint replacing the dead efm setup, blink.cmp (Rust fuzzy, ghost text, signature help), which-key/trouble v3.
- **`nvim/README.md`** rewritten: snacks dashboard hero, 2×2 gallery, per-language LSP/formatter/linter matrix, refreshed deep-dive; plugin catalogue split to `plugins.md`.
- **Main README Credits** reworked into a single okivim-style avatar grid (every tool + shell/tmux/yazi plugin + Neovim plugin author) after a full repo attribution audit (rofi/polybar by adi1090x, nord dircolors, qutebrowser themes, ueberzug, vendored scripts); all 80+ links verified live. Compact license footer.
- **kitty** and **zsh** README reviews — documented real behavior, dropped stale claims, added demo screenshots.

### Fixed
- Last deprecated nvim API removed: `vim.diagnostic.goto_next/goto_prev` → `vim.diagnostic.jump`.
- Option-scope cruft cleared; disabled unused perl/ruby providers, added the `regex` parser. Startup ~147 ms, no errors or deprecation warnings.

### Removed
- Stale main-README sections: Experimental Wayland and Neovim Deep-Dive (the deep-dive now lives in `nvim/README.md`).

## [2026-11-13] — Yazi README finalized (branch: `modernize-2026`)

### Added
- Real screenshot (`assets/yazi_shot.png`) and corrected feature/keybinding descriptions caught by a manual review (`q`/`w` cd-on-quit behavior traced to the `.zshrc` wrapper, `eg` is an image→PDF conversion not a preview, `yd` copies a directory path not a "dirname"), plus previously-undocumented bindings (pagination, `Q`, `<C-c>`, `<C-z>`, `y.`).

This closes out the yazi documentation work — README is considered complete as of this entry.

## [2026-11-12] — Yazi deep audit: deprecations, search, plugin wiring (branch: `modernize-2026`)

### Fixed
- `yazi.toml`/`keymap.toml` had drifted from real 26.x renames/removals, confirmed against the **v26.9.1-tagged** source (not the `main` branch, which had already drifted ahead of our installed version and gave a first, incorrect read): `title_format` (removed, dead), `micro_workers`/`macro_workers` (removed, replaced by `file/plugin/fetch/preload/process_workers`; `bizarre_retry` is unrelated and still valid, kept), `overwrite_content`/`quit_content` (renamed to `*_body`), and `copy dirname` → `copy dirpath` (renamed, confirmed live via clipboard check). `[input].search_*` is **still valid** in 26.9.1 — initially removed by mistake, restored.
- Added `z,g`/`z,f` bound to the real native `search --via=rg`/`--via=fd` action. First attempt used `plugin rg`/`plugin fd`, which is 26.9.1's *default keymap on the `main` branch* for an unreleased, plugin-based rewrite of search — live-tested and confirmed it throws "Plugin load failed" on our installed version, since no such `rg.yazi`/`fd.yazi` plugin exists anywhere (confirmed: neither is in the `yazi-rs/plugins` monorepo). Verified live via tmux: rg correctly filtered files by content, fd correctly filtered by filename.
- Wired up `git.yazi` (fetcher, verified live via ANSI-color capture: untracked files get the magenta `?` sign, a modified tracked file gets a yellow unstaged sign), `chmod.yazi` (`c,m`, verified live via `ls -la`), `jump-to-char.yazi` (bare `f`, verified live jumping to two different files by letter), and `toggle-pane.yazi` (`g,p/P` `g,c/C` `g,v/V` `g,r`, verified live — pane layout actually changes). `vcs-files.yazi` deliberately left unwired (redundant with `git.yazi`, would collide with `toggle-pane`'s `g,c`).
- `mime-preview.yazi` was installed via a bare `git clone`, invisible to `ya pkg sync`. Re-installed via `ya pkg add DreamMaoMao/mime-preview` (content was byte-identical — confirmed by diff before overwriting) and tracked in `package.toml`.
- Discovered while wiring `toggle-pane`'s `g`-prefix: yazi's `[mgr].keymap` array fully *replaces* the stock keymap rather than layering on top of it (unlike lf), so our custom config had silently dropped yazi's default top/bottom/follow-symlink navigation. Added `gg`/`G`/`<Home>`/`<End>` (go to top/bottom) and `g,f` (follow symlink) to restore it; lf already had equivalent behavior natively, no lf change needed.

## [2026-11-12] — Image preview: ueberzug → kitty (branch: `modernize-2026`)

### Fixed
- ranger's `preview_images_method` was set to `ueberzug` (the original, X11-window-overlay-based tool), which crashes with `OSError: [Errno 25] Inappropriate ioctl for device` outside a plain TTY and is well known to be unreliable, especially under terminal multiplexers. The user's actual terminal is kitty (`TERMINAL=kitty` in `.zshenv`/`.profile`), which ranger supports natively — switched `preview_images_method` to `kitty`.
- lf's `preview` script's `image()` function always went through the same ueberzug-FIFO path whenever `$DISPLAY` was set, never checking for kitty at all. Added a `*kitty*` case using kitty's own `icat` kitten (ships with kitty, no extra dependency) via the documented `--place=<w>x<h>@<x>x<y>` syntax. `cleaner` updated to match (`icat --clear`) so switching away from an image preview actually clears it.

### Fixed (follow-up, same day — found after the user hit it in real use)
- Both `icat` calls redirected stdin to `/dev/null`, which hangs indefinitely — the kitty graphics protocol needs stdin connected to receive the terminal's handshake response. First fix was `< /dev/tty > /dev/tty`, which looked correct in isolated testing but still hung in real use (user-reported: lf stuck at a loading screen).
- Root cause turned out to be deeper: `lf` runs `preview`/`cleaner` in a background process group, so the moment `icat` (a child process) tries to read/write `/dev/tty`, the kernel sends `SIGTTIN`/`SIGTTOU` and **job-control-stops** it (process state `T`, not actually hung) — confirmed via `ps`/`pstree` showing state `T` and zero CPU. Fixed by having the subshell `trap '' TTOU TTIN` before `exec`ing `icat` — but `timeout` (added as a safety net) resets signal dispositions before its own exec, so the trap has to be set *inside* the `timeout`'d subshell, not outside it (`timeout 5 sh -c 'trap ...; exec icat ...'`, not `timeout 5 icat ...` after a trap in the parent). Confirmed via process state only: navigated every file in a real directory (`~/Downloads`, mixed PDFs/images/folders) through real `lf` in a real kitty window, checking for any `T`-state process after each step — zero hangs across the full pass.
- ranger's kitty image support doesn't share this risk: its Python `KittyImageDisplayer` writes escape codes directly from ranger's own main process (no subprocess spawn), so there's no background-process-group to get job-control-stopped. No change needed there.

Pixel-level rendering (does the image actually *look* right) still could not be verified by me — not for lack of trying: X11 window-screenshot capture on this display leaked real, sensitive desktop content four separate times during this investigation (including once with the window's own metadata confirming the correct target immediately before and after capture, while the pixels returned were from something else entirely — a deeper tooling desync than simple window-ID reuse). That method is no longer used on this machine, full stop. What's confirmed via process state: the hang is genuinely fixed, not just in isolation but across every file in a real directory, through real `lf`. **Pixel rendering still needs your own eyes** — open `ranger` or `lf` on an image in your real kitty terminal (not tmux) and confirm it actually displays.

## [2026-11-12] — Cross-tool feature parity (branch: `modernize-2026`)

### Changed
- `smart-extract.sh` moved from `yazi/` to `bash_scripts/` (on `$PATH` via `~/bin/bash_scripts`) and is now `au` in **all three** file managers, not just yazi. lf's `au` was single-file-only (`$f`) before; it's now multi-select (`$fx`) and single-root-aware, same as yazi and ranger.
- Added `ap` (play hovered file as audio only, `mpv --no-video`) to lf and ranger, matching yazi.
- Added `cke`/`cku` (chmod +x / -x on selection) to yazi and lf, matching ranger's existing ones.

Verified live: `au` produces byte-identical results (single-rooted archive extracts with no wrapper, confirmed on all three via the same test fixture) since all three now call the same script. `cke`/`cku` confirmed live in yazi and lf (via tmux, after an xterm/xdotool session repeatedly misdirected input — switched to tmux mid-verification). `ap` relies on the same `mpv --no-video` invocation and `$`-prefix blocking already confirmed working earlier for yazi and lf respectively; not re-confirmed live for lf specifically due to an unrelated directory-listing cache issue in that session.

## [2026-11-12] — Cross-tool keybinding consistency (branch: `modernize-2026`)

### Changed
- ranger's archive scheme (`gzu`/`gzz`/`gzr`/`gzn`/`etu`, tar-only, no creation) replaced with `az`/`at`/`ag`/`ab`/`au` — same letters, same behavior (collision-safe, no leading path, one archive at a time on extract) as yazi and lf. `gzu`/`gzz`/`gzr`/`gzn` (single-file gzip, a different operation) are kept as-is.
- ranger's trash binding moved from `dT` to `dt`, and `tr`/`tc`/`tg` (restore/clear/go-to-trash) added — same scheme as yazi and lf. Overrides ranger's stock `dt` (cut mode=toggle, still reachable via `dd`/`da`/`dr`) and stock bare `t` (`tag_toggle`, no longer reachable); both were real stock features, not bugs, overridden deliberately for consistency.
- ranger's bare `a` (`rename_append`) unmapped to make room for the `a*` archive prefix — still reachable via `<F2>`, `A`, or `I`.

Verified live via `ranger` in `tmux`: `az`/`at`/`ag`/`ab` create correctly (no leading path, collision-safe rename confirmed earlier this session), `au` extracts and correctly surfaces `unzip`'s interactive overwrite prompt, `dt`/`tr`/`tc`/`tg` all round-trip correctly through real `trash-put`/`trash-restore`/`trash-empty`.

## [2026-11-12] — ranger command fixes (branch: `modernize-2026`)

### Fixed
- `etu` (tar extract): `tar -xvf %s` passed every selected file to a single `tar` invocation — with more than one selected, tar treats the 2nd+ as path filters *inside* the first archive, fails with "Not found in archive", and extracts nothing (confirmed exit 2, zero files extracted, reproduced standalone before fixing). Now loops and extracts each selected archive individually; verified against multi-select and a filename containing a space (ranger's `%s`/`%f`/`%p` are all pre-quoted by ranger itself, confirmed via a debug binding).

### Removed
- `gkm`/`gkz` (mount/unmount a paired KDE Connect device) — same reasoning as yazi's `m,k` and lf's `mk`: not meaningful to verify outside a specific paired device.
- `gkg`/`gku`/`gks` (rclone mount/unmount/sync to a hardcoded personal rclone remote) — same reasoning as lf's dropped SSHFS/OneDrive bindings: tied to the author's own cloud accounts.

Verified live via `ranger` run inside `tmux` (text-based `capture-pane`, not X11 screenshots — this session's live GUI testing had already leaked real desktop content twice through window-ID-based screenshot capture, so ranger was deliberately tested through a fully isolated virtual terminal instead).

## [2026-11-12] — lf command fixes (branch: `modernize-2026`)

### Fixed
- `az` (`cmd zip`): `zip -r "$f" "$f"` used the same name for input and output — zip never auto-appends `.zip` to a file that already has an extension, so it tried to treat the source as an existing archive to update and failed with "Zip file structure invalid". Reproduced standalone before fixing.
- `az`/`at`/`ag`/`tarbz2`: all passed `$f` (lf's full absolute path) straight to zip/tar, baking the leading directory structure into the archive — confirmed live (`tar tf` showed `tmp/lf_archive_test/doc.txt` instead of `doc.txt`). All four now `cd` into the file's directory and pack by basename, with collision-safe auto-rename (`-1`, `-2`, ...), matching the yazi archive fixes above.
- `map ab targz` — duplicate of `ag`; `ab` now correctly maps to the already-defined (but previously unreachable) `tarbz2` command.

### Removed
- `map mg mount_Gdrive` / `map mn mount_nextcloud` — both referenced commands that were never defined anywhere in `lfrc`; pressing either produced an "unknown mapping" error.
- `anm` (SSHFS mount to a hardcoded LAN IP), `mk` (mount a paired KDE Connect device), `yLu` (`cp` to a hardcoded `$HOME/LAN/Users/$USER/Downloads/` path), `bt` (overwrote a hardcoded Firefox profile hash's new-tab background), and `image2pdf_and_upload2onedrive` (never mapped to any key, and synced to a hardcoded personal rclone remote) — all tied to the author's specific personal devices, network, or accounts, none of it meaningful or testable outside that one setup.

Verified by installing `lf` and driving the real binary end-to-end, not just reasoning about the shell one-liners.

## [2026-11-12] — Yazi keymap fixes & smart extraction (branch: `modernize-2026`)

### Fixed
- `a,p`/`a,z`/`a,t`/`a,g`/`a,b`/`a,u`/`b,g`: all read yazi's selected-file placeholder via `$1`/`$@`/`${!#}` — those are shell positional params and are never set in yazi's `run` strings (only `%h`/`%s`/`%1`/`%d1` are text-substituted in). Replaced with the correct placeholders throughout.
- `a,z`/`a,t`/`a,g`/`a,b`: archive creation baked in the full absolute path and could silently clobber a same-named output; now packs by basename (no leading path) and auto-renames on collision (`-1`, `-2`, ...).
- `[opener]`/`e,e`/`e,i`/`e,g`: redundant manual quoting around already-quoted `%s`/`%1` (doubled quotes broke filenames containing spaces/pipes), and a missing `--block` left `nvim`/`exiftool | less` running detached instead of taking over the terminal.
- `t,r` (`trash-restore`): same missing-`--block` bug — the interactive "what file to restore" prompt had nowhere visible to go and no input reached it, so it exited immediately without restoring anything. `t,c` (`trash-empty`) got `--block` too, for visible output rather than a functional fix (it's non-interactive by default).

### Removed
- Dead `[mgr] keymap` binding on `w` ("Set directory and exit", wrote `$YAZI_CWD` to `/tmp/yazi_cwd`) — `prepend_keymap` binds `w` to `quit` too and is matched first, so this one never fired. Confirmed live: pressing `w` quit without creating the file. `/tmp/yazi_cwd` wasn't read anywhere else in the repo either.
- `a,n`/`m,k` (mount a hardcoded SSHFS share / KDE Connect device) — tied to a specific LAN host and a paired device, neither reachable or meaningful to verify outside the author's own network.

### Added
- `yazi/smart-extract.sh`, bound to `a,u`: extracts into the current directory with no wrapper folder when an archive already has a single top-level folder (matches 7-Zip/Nautilus/Archive Utility convention); otherwise wraps the contents in a new folder named after the archive, auto-renamed on collision. Non-archive files in a mixed selection are skipped, not fatal.

Verified by driving the real `yazi` binary end-to-end (real keystrokes, real screenshots), not just testing scripts standalone.

## [2026-11-12] — Security & repo hygiene hardening (branch: `modernize-2026`)

### Security
- `transmission-daemon/settings.json`, which carried a real `rpc-password` hash, is no longer tracked. It's now generated from a sanitized `settings.json.example` by `scripts/bootstrap-secrets.sh` (same pattern already used for `.gitconfig` and the rofi ribbon colours).
- `scripts/validate.sh`: added a guard so `transmission-daemon/settings.json` fails validation if it's ever re-tracked; added a check that fails on any committed compiled binary (ELF/Mach-O/PE32).
- Removed `eval` from `bash_scripts/scripts/rofi-klipper.sh` — none of the calls needed shell re-parsing, so this closes an unnecessary injection surface.

### Removed
- ~30MB of committed Transmission blocklist data (`transmission-daemon/blocklists/*.p2p*`) — it's fetched at runtime via `settings.json`'s `blocklist-url` and never needed to be in git.
- A compiled binary (`bash_scripts/scripts/greenclip`) that dotfiles should never ship.
- `bash_scripts/scripts/autostart.sh` — an orphaned, unreferenced file (the real autostart lives in `bspwm/bspwmrc`); it also carried the dead binary call above and the deprecated picom `--experimental-backends` flag.

### Added
- `.gitattributes`: line-ending normalization, binary markers for images/fonts, and `linguist-vendored`/`linguist-generated` on third-party code (firefox-sweet-theme, qutebrowser greasemonkey scripts, yazi flavor packs, fish's generated functions).
- `setup.sh --dry-run`: prints every planned action with zero filesystem writes.
- `setup.sh --check`: reports per-target drift (ok / drift / missing) with zero filesystem writes.
- A live CI "secrets scan" badge on the main README.

## [2026-11-11] — Documentation overhaul (branch: `modernize-2026`)

### Added
- Rewrote the main **`README.md`**: hero, gallery, a complete grouped component inventory (every tool linked), a Neovim deep-dive, install guide, and collapsible keybinding cheatsheets.
- A **per-component README** for nearly every tool, written in a consistent, concise voice straight from the real configs (accurate keybinds/deps, with honest caveats kept).
- **Hero headers** on the signature and medium/large tools — tool logo, upstream link, live GitHub stars badge, license, and a soft author credit; tools with no official logo get a clean typographic hero. Logos committed under `assets/`.
- `docs/firefox.md`.

### Changed
- Trimmed component READMEs to essentials (intro + keybinding/usage tables); dropped most per-tool "Setup" sections.

### Removed
- Thin/redundant component READMEs: `urlscan`, `urlview`, `Kvantum`, `vivid`, `gammastep`, `scripts`.
- Main README "Making It Yours" and "Maintenance" sections.

## [2026-11-09] — Modernization & dead-tool cleanup (branch: `modernize-2026`)

### Changed
- Dead tools → maintained forks: `exa`→`eza`, `youtube-dl`→`yt-dlp`, `sxiv`→`nsxiv`, `rtv`→`tuir`, `ag`→`rg` (FZF command)
- Neovim consolidated onto **snacks.nvim** (picker / explorer / notifier); dropped the noice, oil, dressing, mini.nvim, mini.icons, fzf-lua, mini.pick overlaps
- mpv `sub-ass-force-style`→`sub-ass-style-overrides`; dunst `geometry`→`width`/`height`/`origin`/`offset`; picom dropped removed keys (`dbe`, `glx-copy-from-front`)
- polybar network modules use `interface-type = wireless` (auto-detect) instead of hardcoded `wlan0`
- Alacritty: removed invalid top-level `theme=` / misplaced `title=` keys
- Package manifests: dropped `neofetch`/`screenfetch`, `ueberzug`→`ueberzugpp`, `sxiv`→`nsxiv`
- `vivid` LS_COLORS cached instead of regenerated every shell; `JAVA_HOME` guarded to Arch default JDK

### Fixed
- Neovim latent bug: packer-era `requires=`/`after=` keys that lazy.nvim silently ignored → proper `dependencies`
- Neovim keybinds repointed from Telescope/Oil to snacks (would have errored on keypress)
- yazi: invalid commands (`find_next`, `atime/ctime` sorts, `show-info`), `%s`→`$@` openers, and an invalid multi-line inline table (TOML)
- dunst: removed a foreign `/home/<user>/.nix-profile` dmenu path + dead gnome icon paths
- sxhkd: workspace bind `{1-8}`→`{1-9}` (desktop 九 was unreachable); removed shadowed duplicate `super+space`
- Transmission: RPC bound to `127.0.0.1` (was `0.0.0.0`); `$USER`/`$HOME` literal paths → absolute (exempted in `validate.sh`)
- Hardcoded foreign usernames (`/home/<user>`) → `$HOME`

### Removed
- Neovim dead code: `config/*.vimrc` tree, `UltiSnips/` (no loader), 10 orphaned `plugins/*.lua` (~2,500 lines)
- `.Xresources`: dead `~/etc/...` include + unused URxvt block (kept the `Xft.*` hints)

### Added
- `docs/firefox.md` (referenced by `setup.sh`/CHANGELOG but previously missing)

## [Unreleased]

### Added
- **Niri (Wayland) session:** `niri/config.kdl`, `niri/autostart.sh`, `niri/powermenu.sh`, `niri/README.md`, `packages/niri-wayland.txt`
- **Waybar** for niri: `waybar/config.jsonc`, `waybar/style.css`, scripts (net speed, battery, uptime); polybar-style split icon + text modules
- **Gammastep** Wayland night colour: `gammastep/config.ini` linked via `setup.sh` (use in niri only — not redshift)
- **Per-workspace random wallpapers:** `niri/scripts/workspace-wallpaper.sh` + `awww` (new random image on every workspace switch via niri IPC)
- `xwayland-satellite` block in niri config for X11 apps on demand
- `bash_scripts/` vendored → `~/bin/bash_scripts` via `setup.sh`
- `setup.sh` flags: `--backup`, `--force`, `--help`; links `niri/`, `waybar/`, `gammastep/`; runs `disable-xdg-autostart.sh`
- `scripts/`: `bootstrap-secrets.sh`, `validate.sh`, `install-deps.sh`
- `docs/`: `INSTALL.md`, `secrets.md`, `firefox.md`
- `SECURITY.md`, `.gitleaks.toml`, `.githooks/pre-commit`, `.github/workflows/secrets.yml`
- `.gitconfig.example`, `packages/minimal.txt`

### Changed
- **BSPWM unchanged;** niri is an optional second session (`niri-session`, not bare `niri`)
- **Wallpapers:** `bash_scripts/random-wallpaper.sh` supports `awww` (Arch swww rename), `--pick` / `--set`, Wayland vs X11 locks; global cycler stopped in niri autostart
- **Gammastep** starts from `niri/autostart.sh` with explicit `-c`; `adjustment-method=drm` / `card=1` (wayland gamma failed on Intel i915)
- **Niri keybindings:** workspace/monitor/column navigation, overview on `Super+O`, htop on `Super+Shift+O`, sxhkd-style app binds
- **Waybar styling:** `spacing: 0`, transparent module boxes, tuned icon/text padding (right/center/left modules); disk icon ; left-side net/battery spacing
- **Kitty** `font_size` 11.5 (was 13)
- `setup.sh` uses `ln -sfn`, skips missing repo paths, links `.zprofile`
- Gitignore **only** `rofi/launchers/ribbon/styles/colors.rasi`; add `colors.rasi.example`
- README/sxhkd sync; `TERMINAL=kitty`; bspwm profiles; dunst cleanup; gmail retired; lazy-lock tracked
- Removed bulk `rofi/themes/` and `zsh/themes/`; ribbon launcher is primary rofi UI
- Restored `bootstrap-secrets.sh`, `docs/secrets.md`
- Portability: `$HOMgE` paths, `CONFIG_BACKUP`, wget, gcloud SDK, nvim undodir

### Removed
- Firefox from XDG autostart on author machine (`~/.config/autostart/firefox.desktop` entries — local, not in repo)
- Duplicate `spawn-at-startup "gammastep"` from niri config (handled in `autostart.sh`)
- `context.md` from git (local-only; listed in `.gitignore`)
- `scripts/purge-history.sh` — not needed for day-to-day use
- Polybar unified via `launch.sh`; maim screenshots

### Fixed
- Waybar workspace labels (niri `.focused` / CSS reset; was black on unfocused)
- Workspace wallpaper daemon not firing on switch (`WorkspaceActivated` events, not only `WorkspacesChanged`)
- Duplicate wallpaper daemons / global `random-wallpaper.sh` overriding niri per-switch wallpapers
- Two Firefox windows + junk apps on niri login (systemd XDG autostart)
- Waybar icon/text clipping on right-side and clock modules
- Battery waybar module showing >100% when `charge_now > charge_full`
- Firefox appearing zoomed in on niri (1.25× compositor scale + system DPI)

## [2026-05-15]

### Added
- Tracked config: `newsboat/urls`, `transmission-daemon/settings.json`, `.inputrc`, `twitchnotifier.cfg`
- `context.md` project documentation

## Notes

- **Day-to-day tweaks** (colors, plugins, keybinds): use `git log` — no need to log every commit here.
- **Log here when:** setup/install flow changes, secrets policy changes, breaking sxhkd/README behavior
