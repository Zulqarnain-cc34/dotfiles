  
<br />
<div align="center">
  <a href="https://github.com/Zulqarnain-cc34/dotfiles">
    <img src="screenshots/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">Dotfiles</h3>

  <p align="center">
    These are my linux configuration files, Hope you can find something to your liking.
  </p>
</div>

| Functionality  | Program      |
|----------------|--------------|
| status bar     | polybar      |
| editor         | neovim       |
| terminal       | kitty        |
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

You will need to install the above listed packages from your package manager.

### Installation

To install on your system ,just run setup.sh on your local linux
machine. It will create symbolic links for all the configuration files
to their appropriate locations.

- Clone the Repository.
- Run command to make symbolic links
  `chmod +x setup.sh         bash setup.sh`
- Run `bash uninstall.sh`, will remove all the config files. uninstall
  script will come soon

### Modules

- [Desktop](#desktop)
- [Kitty](#kitty)
- [Polybar](#polybar)
- [Neovim](#neovim)
- [Rofi](#rofi)
- [Newsboat](#newsboat)
- [Miscellaneous](#miscellaneous)

#### Desktop

<p align="center">
    <img src="./screenshots/desktop-4.png"  title="alacritty">
</p>

#### Kitty 

- Custom shell prompt with
  [zsh](https://github.com/Zulqarnain-cc34/zsh).
- Vim like features and key bindings with [zsh](https://github.com/Zulqarnain-cc34/zsh).
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
- [Nvim-compe](https://github.com/hrsh7th/nvim-compe) for Code
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

A window switcher, Application launcher and search engine launcher.
<br> Lots of
features to intergrate rofi more smoothly with 


- [Youtube](https://github.com/pystardust/ytfzf),
- [Surfraw](https://github.com/gotbletu/dotfiles_v2/tree/master/normal_user/rofi/.config/rofi/launchers)
- [Twitch](https://github.com/indeedwatson/rofi-twitch),

A script to manage all of above in one menu. Themes have been used
from [rofi-themes](https://github.com/davatorium/rofi-themes.git) and
[rofi-collection](https://github.com/Murzchnvok/rofi-collection) .

#### Newsboat

Configuration has features

- Vim like key bindings
- integrated with `urlportal.sh` script to open url appropriately
  according to their extension.
- feeds update on cronjob every x minutes in time.

#### Miscellaneous

- Starship Prompt configured with `starship.toml` file.
- Conky light weight System Moniter with [Conky themes](https://github.com/juliojsb/jotack).
- `.Xmodmap` for unbinding and binding keys on a system level.
  package.
- urlportal.sh script to open files depending upon their extensions.

