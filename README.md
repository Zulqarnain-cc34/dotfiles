# Dotfiles

[Zulqarnain-cc34](https://www.github.com/Zulqarnain-cc34)

Dotfiles for my local Arch setup,

| Functionality  | Program      |
|----------------|--------------|
| status bar     | polybar      |
| editor         | neovim       |
| terminal       | alacritty    |
| email client   | neomutt      |
| rss reader     | newsboat     |
| file manager   | lf           |
| launcher       | rofi         |
| torrent        | transmission |
| video player   | mpv          |
| compositer     | picom        |
| System Moniter | Conky        |

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Modules](#modules)

### Requirements

### Installation

To install on your system ,just run setup.sh on your local linux
machine. It will create symbolic links for all the configuration files
to their appropriate locations.

- git clone the repo
- Run command to make symbolic links
  `chmod +x setup.sh         bash setup.sh`
- Run `bash uninstall.sh`, will remove all the config files. uninstall
  script will come soon

### Modules

- [Desktop](#desktop)
- [Alacritty](#alacritty)
- [Polybar](#polybar)
- [Neovim](#neovim)
- [Rofi](#rofi)
- [Neomutt](#neomutt)
- [Newsboat](#newsboat)
- [Transmission](#transmission)
- [lf](#lf)
- [Miscellaneous](#miscellaneous)

#### Desktop

<p align="center">
<img src="./screenshots/desktop-4.png"  title="alacritty">
</p>

#### Alacritty

<p align="center">
<img src="./screenshots/alacritty.png"  title="alacritty">
</p>

- Custom shell prompt with
  [Startship](https://github.com/starship/starship).
- Multiple Alacritty themes via
  [alacritty-themes](https://github.com/eendroroy/alacritty-theme) (i am
  using Argonaut theme).
- Background blur and transparency using
  [picom](https://github.com/yshui/picom).

#### Polybar

Custom tweaks on
[forest-theme](https://github.com/adi1090x/polybar-themes) and some
modules from
[polybar-scripts](https://github.com/polybar/polybar-scripts)

<p align="center">
<img src="./screenshots/polybar.png"  title="polybar">
</p>

#### Neovim

<p align="center">
<img src="./screenshots/neovim.png"  title="neovim">
<img src="./screenshots/neovim-1.png"  title="neovim">
<img src="./screenshots/neovim-2.png"  title="neovim">
</p>

##### Features

- IDE like Configuration with native
  [lsp](https://github.com/neovim/nvim-lspconfig).
- Linting, Formatting and Code actions configured for most languages.
- [nvim-compe](https://github.com/hrsh7th/nvim-compe) for Code
  Autocompletion with snippets from
  [ulitsnips](https://github.com/SirVer/ultisnips).
- Fast Directory traversal with
  [nvimtree](https://github.com/kyazdani42/nvim-tree.lua).
- Git integration with [fugitive](https://github.com/tpope/vim-fugitive)
  and [gitgutter](https://github.com/airblade/vim-gitgutter).
- Colorful theme from
  [nvim-tokyonight](https://github.com/ghifarit53/tokyonight-vim).
- Fuzzy searcher and finder
  [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).
- Keybinding Prompt with
  [whichkey](https://github.com/folke/which-key.nvim).
- Beautiful dashboard via
  [dashboard-nvim](https://github.com/glepnir/dashboard-nvim).
- Source code linting and fixing with
  [efm-language-server](https://github.com/mattn/efm-langserver).
- Code Semantic and Structure highlighting using
  [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
- [NerdCommentor](https://github.com/preservim/nerdcommenter) for Code
  Commenting.
- On the fly function signatures with
  [lsp-signature.nvim](https://github.com/ray-x/lsp_signature.nvim)
- Highly Performatant UI for built-in-lsp
  [Lspsaga](https://github.com/glepnir/lspsaga.nvim).
- Fast Status bar with
  [Lualine](https://github.com/hoob3rt/lualine.nvim).
- Vim Diary to note TODOs
  [vim-wiki](https://github.com/vimwiki/vimwiki).
- Snazzy bufferline with
  [nvim-bufferline](https://github.com/akinsho/nvim-bufferline.lua).

You can find shorcuts and keybindings in
[KeyBindings](https://github.com/Zulqarnain-cc34/dotfiles/tree/main/nvim/README.md).About
70% of these plugins are lazy loaded to improve faster runtimes for
neovim.

#### Rofi

using rofi as a custom launcher,ssh launcher and search engine. Lots of
more scripts to integrate rofi with
[twitch](https://github.com/indeedwatson/rofi-twitch),
[youtube](https://github.com/pystardust/ytfzf),
[surfraw](https://github.com/gotbletu/dotfiles_v2/tree/master/normal_user/rofi/.config/rofi/launchers)
,[wifi-menu](https://github.com/zbaylin/rofi-wifi-menu)
,[rofi-spotlight](https://github.com/manilarome/rofi-spotlight) and
[others](https://github.com/gotbletu/dotfiles_v2/tree/master/normal_user/rofi/.config/rofi/launchers).
Using rofi bangs script to manage all in one menu. Themes have been used
from [rofi-themes](https://github.com/davatorium/rofi-themes.git) and
[rofi-collection](https://github.com/Murzchnvok/rofi-collection) .

#### Newsboat

Configuration has features

- Vim like key bindings
- integrated with `urlportal.sh` script to open url appropriately
  according to their extension.
- feeds update on cronjob every x minutes in time.

#### NeoMutt

Setup with - Aliases `~/.mutt/aliases` All the aliases are stored in
aliases file. - Colors `~/.mutt/colors` Color theme for neomutt. -
Settings `~/.mutt/settings` Main config and personalized settings. -
Sidebar `~/.mutt/sidebar` Sidebar theme. - muttrc `~/.mutt/.muttrc` All
files are sourced in .muttrc as `source ./settings` and
`source ./aliases` etc.

Mutt themes are forked from
[mutt-solarized-theme](https://github.com/altercation/mutt-colors-solarized)
and [neon-mutt-theme](https://github.com/h3xx/mutt-colors-neonwolf)

#### Transmission

#### lf

#### Miscellaneous

- Starship Prompt configured with `starship.toml` file.
- Themes for desktop in themes folder (I am using xfce4).
- `.Xmodmap` for unbinding and binding keys on a system level.
- `twitch notifer.cfg` to format output for
  [twitch-notifier](https://github.com/GiedriusS/TwitchNotifier)
  package.
- urlportal.sh script to open files depending upon their extensions.
- Conky light weight System Moniter with [Conky
  theme](https://github.com/juliojsb/jotack).

Currently Under work

[(Back to top)](#top)
