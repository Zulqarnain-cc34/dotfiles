# Firefox

A `userChrome.css` plus the vendored **Sweet** theme for styling the Firefox UI to match the dark desktop. Firefox customisations live in a per-profile directory (`~/.mozilla/firefox/<profile>/chrome/`), so unlike most of this repo, `setup.sh` does **not** symlink this folder — applying it is a manual, per-profile affair. See **[docs/firefox.md](../docs/firefox.md)** for the walkthrough.

The pieces are small: `userChrome.css` is a one-line `@import "firefox-sweet-theme/userChrome.css";`, and `firefox-sweet-theme/` is a vendored copy of the **Sweet** theme by **[EliverLara](https://github.com/EliverLara/firefox-sweet-theme)** (credit retained). The theme's `configuration/user.js` carries the profile prefs that make it work — enabling legacy userChrome stylesheets and CSD, and forcing 100% UI/page zoom, since niri's 1.25x scale was otherwise reading as zoomed-in.

Two helper scripts smooth the rough edges: `scripts/link-user-js.sh` symlinks the theme's `user.js` into the active profile (resolved from `~/.mozilla/firefox/profiles.ini`), and `scripts/reset-page-zoom.sh` clears saved per-site zoom from `content-prefs.sqlite` (close Firefox first).

### Setup

Follow [docs/firefox.md](../docs/firefox.md). In short: enable `toolkit.legacyUserProfileCustomizations.stylesheets`, place or symlink these files into the profile's `chrome/`, link `user.js`, and restart Firefox. Theme variants and colours live under `firefox-sweet-theme/theme/` if you want to retune the look.
