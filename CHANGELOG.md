# Changelog

Notable changes to this repo, one entry per day — a simpler, human variant of [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), no categories or semver.
The detailed record lives in the git commit messages — see `git log` when you need that.

## [2026-11-21] — Niri setup removal, rate fix

- Removed **niri**, **waybar**, **gammastep**, and **fish** entirely — dormant, unmaintained components whose bugs had gone unnoticed for lack of real use.
- Fixed the **xset** keyboard repeat-rate bug for real — event-driven self-heal, still logging in case it happens again.

## [2026-11-20] — sddm theme, dunst fix

- Stopped **dunst** from silently pausing notifications during the **csakura** idle screensaver.
- Added **sddm** theme tracking and activated the sugar-candy theme.
- Gave **setup.sh** sudo-aware linking for system files outside `$HOME`.
- Small fixes: **bspwm**/**redshift** cleanup, **clipmenud** dedup, **vivid** theme.
- Expanded **fonts** install coverage and added a **packages** v3 snapshot plus a snapshot script.

## [2026-11-19] — dunst theming, polybar OSD, fastfetch/bspwm fixes

- Gave **dunst** a real visual overhaul: a personalized theme, OSD notifications, a do-not-disturb toggle, and clickable action buttons.
- Rewired **polybar**'s volume and brightness controls to work with the new OSD, fixing a stale permission bug along the way.
- Rewrote **CLAUDE.md** for clarity, tightening the wording throughout.
- Fixed **fastfetch**'s package-count render blocking.
- Added a **bspwm** keyboard repeat-rate watchdog to monitor a bug.

## [2026-11-18] — fastfetch theme, newsboat audit

- Gave **fastfetch** a brand new look — sections, colors, icons, a proper font, a working package count, and a second color theme.
- Did a full **newsboat** audit and fixed what was broken (notifications, bookmarking, a few dead feeds).
- Added a **csakura** feature: the screensaver now dismisses on mouse movement too, not just a keypress.
- Set up a proper **GitHub workflow**: `develop`/`main` branches, and automatic account switching between profiles.

## [2026-11-16] — csakura build-on-setup, small reliability fixes

- Made **csakura** build itself from source during setup instead of shipping a committed binary.
- A batch of small reliability fixes: **csakura**'s idle timeout, **lf**'s preview columns, **fastfetch**'s package count, and more robust **polybar**/wallpaper restarts.

## [2026-11-15] — Light maintenance

- Updated **Neovim**'s plugin lockfile, refreshed the **polybar** demo image, and cleaned up a few unused aliases.

## [2026-11-14] — csakura screensaver, desktop-stack modernization

- Added the **csakura** cherry-blossom screensaver as a brand new feature.
- Reworked the main **README**'s credits into a proper avatar grid after a full attribution audit.
- Modernized **bspwm**, **sxhkd**, **picom**, **polybar**, **dunst**, and **rofi** — fixed deprecated config options and cleared out dead files across the board.
- Fixed image-preview bugs in **alacritty** and **kitty**.

## [2026-11-13] — yazi/lf docs finished, full Neovim modernization

- Finished the **yazi** and **lf** documentation, with more real bugs found and fixed along the way (archive handling, bulk rename, dead keybindings).
- Did a full **Neovim** modernization: native LSP, Tree-sitter on the main branch, a cleaned-up plugin list, and a rewritten README.

## [2026-11-12] — Security hardening, deep yazi/lf/ranger audit

- Hardened repo security: stopped tracking a secret, removed a committed binary, and locked down the setup script.
- Did a deep audit of **yazi**, **lf**, and **ranger** — fixed real bugs in archive handling and keybindings, switched image previews to **kitty**, and wired up several plugins.

## [2026-11-11] — Documentation overhaul

- Wrote proper **README**s for almost every tool in the repo, with logos and hero headers.

## [2026-11-09] — First modernization push

- Fixed broken shell and file-manager tools, cleaned up the **X11** stack, modernized **Neovim**, and added install docs/infrastructure.

## [2026-05-23] — Niri (Wayland) added, security foundations

- Added **niri** as an optional second, Wayland session next to **bspwm** — with **waybar** as its status bar and **gammastep** for night color.
- Per-workspace random wallpapers that switch automatically via **niri**'s own IPC.
- Laid the foundation for the repo's security practices: secret bootstrapping, config validation, and secrets scanning.

## [2026-05-15] — Config tracking expanded, project docs added

*This changelog starts here — the earliest entry on record.*

- Started tracking a few more config files (**newsboat**, **transmission**, **inputrc**, **twitch notifier**) and added project documentation.

## Notes

- **Day-to-day tweaks** (colors, plugins, keybinds): use `git log` — no need to log every commit here.
- **Log here when:** setup/install flow changes, secrets policy changes, breaking sxhkd/README behavior
