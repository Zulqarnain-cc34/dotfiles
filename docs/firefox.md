# Firefox

Firefox is **not** symlinked by `setup.sh`, because its config lives inside a
per-machine, randomly-named profile directory
(`~/.mozilla/firefox/<random>.default-release/`) that can't be predicted or
safely symlinked wholesale.

This repo ships a Firefox `userChrome.css` setup under `firefox/` (the
[firefox-sweet-theme](https://github.com/EliverLara/firefox-sweet-theme) by
EliverLara, plus a top-level `firefox/userChrome.css`).

## Applying the theme

1. Find your profile directory:
   ```bash
   ls -d ~/.mozilla/firefox/*.default-release
   ```
2. Enable legacy stylesheet support — in `about:config` set:
   ```
   toolkit.legacyUserProfileCustomizations.stylesheets = true
   ```
3. Copy the theme's `chrome/` assets into that profile. The theme bundles an
   installer that does this for you:
   ```bash
   cd firefox/firefox-sweet-theme
   ./scripts/install.sh            # see `./scripts/install.sh -h` for options
   ```
   Or copy `firefox/userChrome.css` (and any referenced assets) into
   `<profile>/chrome/userChrome.css` by hand.
4. Restart Firefox.

> Note: the vendored theme README lists old Firefox versions (68–70); the CSS
> still loads on current Firefox, but some selectors may need touch-ups as
> Firefox's internal chrome markup changes between releases.
