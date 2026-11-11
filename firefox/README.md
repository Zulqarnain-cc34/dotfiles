<div align="center">
  <img src="../assets/firefox.svg" width="76" alt="Firefox logo"><br><br>
  <h1>Firefox</h1>
  <p><em>userChrome + the Sweet theme, styled to match the dark desktop.</em></p>
  <a href="https://github.com/mozilla-firefox/firefox"><img src="https://img.shields.io/badge/upstream-mozilla--firefox%2Ffirefox-FF7139?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/mozilla-firefox/firefox/stargazers"><img src="https://img.shields.io/github/stars/mozilla-firefox/firefox?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-MPL--2.0-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

> Built on **[Firefox](https://www.mozilla.org/firefox/)** by Mozilla; **Sweet** theme by **[EliverLara](https://github.com/EliverLara/firefox-sweet-theme)**. ❤️

A `userChrome.css` plus the vendored **Sweet** theme for styling the Firefox UI to match the dark desktop. Firefox customisations live in a per-profile directory (`~/.mozilla/firefox/<profile>/chrome/`), so unlike most of this repo, `setup.sh` does **not** symlink this folder — applying it is a manual, per-profile affair. See **[docs/firefox.md](../docs/firefox.md)** for the walkthrough.

The pieces are small: `userChrome.css` is a one-line `@import "firefox-sweet-theme/userChrome.css";`, and `firefox-sweet-theme/` is a vendored copy of the **Sweet** theme by **[EliverLara](https://github.com/EliverLara/firefox-sweet-theme)** (credit retained). The theme's `configuration/user.js` carries the profile prefs that make it work.
