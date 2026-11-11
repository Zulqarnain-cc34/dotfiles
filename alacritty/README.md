# Alacritty

A GPU-accelerated terminal and the alternate to Kitty here — same job, kept around as a lightweight second option, launching Zsh just the same.

The whole thing is one TOML file with its colours written inline rather than pulled from a packaged theme. It runs `JetBrains Mono` across all four styles (regular, bold, italic, bold-italic), keeps 10,000 lines of scrollback, pads the window by 4px, and deliberately leaves selected text out of the clipboard until you copy it on purpose. Edits apply the moment you save — `live_config_reload` is on, so there's no restart.

### Setup

Install `alacritty`, `ttf-jetbrains-mono` for the font, and `zsh`. Everything lives in [`alacritty.toml`](alacritty.toml): colours sit in the `[colors.normal]`, `[colors.bright]`, `[colors.primary]`, and `[colors.cursor]` tables, and the font family and styles under `[font]` and the `[font.*]` tables. If you'd rather use a packaged theme than the inline palette, add a `[general].import = [...]` entry pointing at it.
