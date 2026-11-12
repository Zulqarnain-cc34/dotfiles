# Yazi package install log

Original `ya pkg add` command per plugin/flavor, annotated with what each one is wired to (or deliberately left unwired). Machine-readable pins live in [`package.toml`](package.toml) — this file is just the human-readable install history.

## Visuals

```bash
ya pkg add yazi-rs/plugins:full-border
ya pkg add Rolv-Apneseth/starship       # installed, kept disabled in init.lua
```

## File operations

```bash
ya pkg add yazi-rs/plugins:chmod  # wired: c,m
ya pkg add yazi-rs/plugins:git    # wired: init.lua setup + yazi.toml fetchers
```

## Navigation

```bash
ya pkg add yazi-rs/plugins:jump-to-char  # wired: bare f
ya pkg add yazi-rs/plugins:vcs-files     # installed, deliberately NOT wired
                                          # (redundant with git.yazi's fetcher,
                                          # would collide with toggle-pane's g,c)
```

## Pane control

```bash
ya pkg add yazi-rs/plugins:toggle-pane  # wired: g,p/P g,c/C g,v/V g,r
```

## Previews

```bash
ya pkg add ahkohd/eza-preview        # installed, setup() called, but NOT actually
                                      # registered as a previewer -- piper (below)
                                      # handles directory previews directly instead
ya pkg add yazi-rs/plugins:piper     # wired: yazi.toml prepend_previewers (eza dir preview)
ya pkg add DreamMaoMao/mime-preview  # installed, setup() DISABLED in init.lua --
                                      # calls the removed/renamed ya.mgr_emit API,
                                      # throws on every redraw and breaks the UI on 26.9.1
```

## Smart enter

```bash
ya pkg add yazi-rs/plugins:smart-enter  # wired: l
```

## Color scheme

```bash
ya pkg add kalidyasin/yazi-flavors:tokyonight-storm
ya pkg add yazi-rs/flavors:catppuccin-mocha
```

Both pinned, neither activated — no `theme.toml`, so the default colorscheme is in use.

## Tried, not installed

Kept here as a note so it isn't re-attempted blind:

```
github.com/BennyOe/onedark.yazi  -- never actually added, no flavors/onedark.yazi/ on disk
```
