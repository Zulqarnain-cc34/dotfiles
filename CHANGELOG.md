# Changelog

Notable changes to this repo, one entry per day — a simpler, human variant of [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), no categories or semver.
The detailed record lives in the git commit messages — see `git log` when you need that.

## [2026-11-19] — dunst theming overhaul, polybar OSD

- Gave **dunst** a real visual overhaul, fixing a few long-standing bugs along the way, landing a personalized theme verified against real dotfiles, and adding OSD-style volume/brightness notifications.
- Rewired **polybar**'s volume and brightness modules to trigger those notifications on scroll/click, and fixed a stale permission bug that had silently broken its own brightness control.

## [2026-11-18] — fastfetch theming, newsboat audit, csakura mouse dismiss, gh workflow

- Gave **fastfetch** a brand new look — sections, colors, icons, a proper font, a working package count, and a second color theme.
- Did a full **newsboat** audit and fixed what was broken (notifications, bookmarking, a few dead feeds).
- Added a **csakura** feature: the screensaver now dismisses on mouse movement too, not just a keypress.
- Set up a proper **GitHub workflow**: `develop`/`main` branches, and automatic account switching between profiles.

## [2026-11-16] — csakura build-on-setup, small reliability fixes

- Made **csakura** build itself from source during setup instead of shipping a committed binary.
- A batch of small reliability fixes: csakura's idle timeout, lf's preview columns, fastfetch's package count, and more robust polybar/wallpaper restarts.

## [2026-11-15] — Light maintenance

- Updated Neovim's plugin lockfile, refreshed the polybar demo image, and cleaned up a few unused aliases.

## [2026-11-14] — csakura screensaver, README credits, desktop-stack modernization

- Added the **csakura** cherry-blossom screensaver as a brand new feature.
- Reworked the main **README**'s credits into a proper avatar grid after a full attribution audit.
- Modernized **bspwm**, **sxhkd**, **picom**, **polybar**, **dunst**, and **rofi** — fixed deprecated config options and cleared out dead files across the board.
- Fixed image-preview bugs in **alacritty** and **kitty**.

## [2026-11-13] — yazi/lf docs finished, full Neovim modernization

- Finished the yazi and lf documentation, with more real bugs found and fixed along the way (archive handling, bulk rename, dead keybindings).
- Did a full Neovim modernization: native LSP, Tree-sitter on the main branch, a cleaned-up plugin list, and a rewritten README.

## [2026-11-12] — Security hardening, deep yazi/lf/ranger audit

- Hardened repo security: stopped tracking a secret, removed a committed binary, and locked down the setup script.
- Did a deep audit of yazi, lf, and ranger — fixed real bugs in archive handling and keybindings, switched image previews to kitty, and wired up several plugins.

## [2026-11-11] — Documentation overhaul

- Wrote proper READMEs for almost every tool in the repo, with logos and hero headers.

## [2026-11-10] — Neovim keybinding update

- Small Neovim keybinding fix.

## [2026-11-09] — First modernization push

- Fixed broken shell and file-manager tools, cleaned up the X11 stack, modernized Neovim, and added install docs/infrastructure.

## [2026-05-23] — Niri (Wayland) session added alongside bspwm

- Added niri as an optional second, Wayland session next to bspwm — with waybar as its status bar and gammastep for night color.
- Per-workspace random wallpapers that switch automatically via niri's own IPC.
- Laid the foundation for the repo's security practices: secret bootstrapping, config validation, and secrets scanning.

## [2026-05-15]

*This changelog starts here — the earliest entry on record.*

- Started tracking a few more config files (newsboat, transmission, inputrc, twitch notifier) and added project documentation.

## Notes

- **Day-to-day tweaks** (colors, plugins, keybinds): use `git log` — no need to log every commit here.
- **Log here when:** setup/install flow changes, secrets policy changes, breaking sxhkd/README behavior
