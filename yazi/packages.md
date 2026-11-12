# Visuals
ya pkg add yazi-rs/plugins:full-border
ya pkg add Rolv-Apneseth/starship  # installed, kept disabled in init.lua

# File operations
ya pkg add yazi-rs/plugins:chmod       # wired: c,m
ya pkg add yazi-rs/plugins:git         # wired: init.lua setup + yazi.toml fetchers

# Navigation
ya pkg add yazi-rs/plugins:jump-to-char  # wired: bare f
ya pkg add yazi-rs/plugins:vcs-files     # installed, deliberately NOT wired
                                          # (redundant with git.yazi's fetcher,
                                          # would collide with toggle-pane's g,c)

# Pane control
ya pkg add yazi-rs/plugins:toggle-pane  # wired: g,p/P g,c/C g,v/V g,r

# Previews
ya pkg add ahkohd/eza-preview      # wired: yazi.toml prepend_previewers
ya pkg add yazi-rs/plugins:piper   # wired: dependency of eza-preview
ya pkg add AnirudhG07/nbpreview    # wired: yazi.toml previewer for *.ipynb
ya pkg add DreamMaoMao/mime-preview  # wired: init.lua setup()

# Smart enter
ya pkg add yazi-rs/plugins:smart-enter  # wired: l

# Color scheme
ya pkg add kalidyasin/yazi-flavors:tokyonight-storm
ya pkg add yazi-rs/flavors:catppuccin-mocha

# Tried, not installed (kept here as a note so it's not re-attempted blind):
# github.com/BennyOe/onedark.yazi -- never actually added, no flavors/onedark.yazi/ on disk.
