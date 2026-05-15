# Firefox

Not wired by `setup.sh`. Manual steps:

## Sweet theme

```bash
cd firefox/firefox-sweet-theme/scripts
./install.sh
```

## userChrome

1. `about:config` → `toolkit.legacyUserProfileCustomizations.stylesheets` = `true`
2. Copy CSS into `~/.mozilla/firefox/<profile>/chrome/`
