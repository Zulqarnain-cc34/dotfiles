<div align="center">
  <img src="../assets/neovim.svg" width="72" alt="Neovim logo"><br><br>
  <h1>Neovim</h1>
  <p><em>A full IDE, lazy-loaded to stay quick.</em></p>
  <a href="https://github.com/neovim/neovim"><img src="https://img.shields.io/badge/upstream-neovim%2Fneovim-57A143?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/neovim/neovim/stargazers"><img src="https://img.shields.io/github/stars/neovim/neovim?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/neovim-0.11%2B-57A143?style=flat-square&labelColor=1a1b26" alt="neovim 0.11+">
  <img src="https://img.shields.io/badge/license-Apache--2.0-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
  <br><br>
  <img src="../screenshots/dashboard.png" width="82%" alt="Neovim dashboard">
</div>

> Built on **[Neovim](https://neovim.io)** — thanks to the Neovim contributors. ❤️

A full IDE on **Neovim 0.12**, managed by **[lazy.nvim](https://github.com/folke/lazy.nvim)** and built on modern-native foundations — the built-in LSP client (`vim.lsp.config`/`vim.lsp.enable`), Tree-sitter's `main` branch, and [blink.cmp](https://github.com/saghen/blink.cmp) completion. [snacks.nvim](https://github.com/folke/snacks.nvim) provides the picker, file explorer, notifier, terminal and dashboard in one place. Colorscheme is **onedark**; leader key is `m`.

Nothing here is a starter framework — it's a hand-rolled config, kept close to Neovim's native APIs so it stays maintainable without rebuilds.

## Requirements

| Need | For |
|------|-----|
| **Neovim ≥ 0.11** (0.12 recommended) | native `vim.lsp.config`/`enable`, Tree-sitter `main` |
| **git**, a **C compiler**, **[tree-sitter CLI](https://github.com/tree-sitter/tree-sitter)** | plugin install + compiling Tree-sitter parsers (`pacman -S tree-sitter-cli`) |
| A **Nerd Font** (FiraCode Nerd Font here) | icons in the UI, statusline, picker |
| **ripgrep** + **fd** | the snacks picker (files / live grep) |
| **LSP servers** on `PATH` (no mason) | `lua_ls`, `pyrefly`, `bashls`, `clangd`, `ts_ls`, `html`, `graphql`, `sqls`, `dockerls`, `vimls`, `jsonls` |
| **Formatters / linters** (optional) | `prettier`, `shfmt`, `markdownlint` wired now; `stylua`/`isort`/`black`/`gofumpt`/`shellcheck`/`eslint`/`flake8` activate when installed |

## Structure

```
init.lua            → require("init")
lua/
  init.lua          load order: plugins → general → settings → mappings → config → autocommands
  plugins.lua       lazy.nvim plugin specs
  general.lua       vim options
  settings.lua      globals + colorscheme
  mappings.lua      keybindings (leader = m)
  config.lua        LSP server activation
  autocommands.lua  autocmds (F9 file-runners, cursor restore, …)
  lsp/              17 per-server configs (vim.lsp.config + vim.lsp.enable)
  plugins/          9 plugin configs (lualine, bufferline, conform, lint, …)
  colors/           local palette used by the devicons overrides
```

## Key subsystems

- **LSP** — native client, no framework wrapper. Servers are configured per-file in `lua/lsp/*` and must be on `PATH`. `jsonls` loads lazily on the first json file (with [schemastore](https://github.com/b0o/schemastore.nvim) schemas) to keep startup fast.
- **Completion** — [blink.cmp](https://github.com/saghen/blink.cmp) (lsp / path / snippets / buffer) + [friendly-snippets](https://github.com/rafamadriz/friendly-snippets).
- **Formatting** — [conform.nvim](https://github.com/stevearc/conform.nvim), manual via `m lf` (LSP fallback). Wired for `shfmt` (`-i 4`), `prettier`, and `stylua`/`isort`/`black`/`gofumpt` once installed.
- **Linting** — [nvim-lint](https://github.com/mfussenegger/nvim-lint) on read/write/insert-leave. `markdownlint` active; others activate when installed.
- **Treesitter** — [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) **`main` branch**: parsers compile via the `tree-sitter` CLI; highlighting starts per-filetype. Run `:TSUpdate` after install.

## 🔌 Plugins

**Core / LSP / Completion** — [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), [schemastore.nvim](https://github.com/b0o/schemastore.nvim), [lazydev.nvim](https://github.com/folke/lazydev.nvim), [blink.cmp](https://github.com/saghen/blink.cmp)

**Formatting & Linting** — [conform.nvim](https://github.com/stevearc/conform.nvim), [nvim-lint](https://github.com/mfussenegger/nvim-lint)

**Treesitter** — [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter), [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag), [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim)

**UI** — [snacks.nvim](https://github.com/folke/snacks.nvim) (picker / explorer / notifier / terminal / dashboard), [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim), [bufferline.nvim](https://github.com/akinsho/bufferline.nvim), [which-key.nvim](https://github.com/folke/which-key.nvim), [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons), [nvim-scrollbar](https://github.com/petertriho/nvim-scrollbar), [nvim-colorizer.lua](https://github.com/catgoose/nvim-colorizer.lua), [smear-cursor.nvim](https://github.com/sphamba/smear-cursor.nvim)

**Themes** — [onedark.nvim](https://github.com/navarasu/onedark.nvim) (active), [tokyonight.nvim](https://github.com/folke/tokyonight.nvim), [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) + [styler.nvim](https://github.com/folke/styler.nvim) (per-filetype themes)

**Git** — [neogit](https://github.com/NeogitOrg/neogit), [diffview.nvim](https://github.com/sindrets/diffview.nvim)

**Editing & Markdown** — [smart-paste.nvim](https://github.com/nemanjamalesija/smart-paste.nvim), [markview.nvim](https://github.com/OXY2DEV/markview.nvim), [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim), [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)

**Diagnostics** — [trouble.nvim](https://github.com/folke/trouble.nvim)

**Session & Remote** — [persistence.nvim](https://github.com/folke/persistence.nvim), [remote-nvim.nvim](https://github.com/amitds1997/remote-nvim.nvim) (uses [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim))

**Utilities** — [plenary.nvim](https://github.com/nvim-lua/plenary.nvim), [nui.nvim](https://github.com/MunifTanjim/nui.nvim), [vim-startuptime](https://github.com/dstein64/vim-startuptime)

## Notable keybindings

Leader = `m`. The `m l…` family is LSP, `m f…` is the snacks picker, `m x…` is Trouble.

| Key | Action |
|-----|--------|
| `m ld` / `m lD` | go to definition / declaration |
| `m li` / `m ly` | implementation / type definition |
| `m la` / `m le` | code action / rename |
| `m lf` | format (conform, LSP fallback) |
| `m ll` / `m ln` / `m lp` | diagnostics float / next / prev |
| `Ctrl-s` | find files (picker) |
| `m fg` / `m fb` / `m fl` | grep / buffers / recent |
| `m fh` / `m fm` / `m fr` | help / marks / registers |
| `m xx` / `m xr` | diagnostics / LSP references (Trouble) |
| `F9` | run current file (python / c / cpp / node / bash / ts) |
| `Alt-d` | toggle terminal (snacks) |
