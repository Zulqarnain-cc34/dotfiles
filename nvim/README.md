<div align="center">
  <img src="../assets/neovim.svg" width="72" alt="Neovim logo"><br><br>
  <h1>Neovim</h1>
  <p><em>A full IDE, lazy-loaded to stay quick.</em></p>
  <a href="https://github.com/neovim/neovim"><img src="https://img.shields.io/badge/upstream-neovim%2Fneovim-57A143?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/neovim/neovim/stargazers"><img src="https://img.shields.io/github/stars/neovim/neovim?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-Apache--2.0-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
  <br><br>
  <img src="../screenshots/dashboard.png" width="82%" alt="Neovim dashboard">
</div>

> Built on **[Neovim](https://neovim.io)** — thanks to the Neovim contributors. ❤️

A full IDE on **Neovim 0.12**, managed by **[lazy.nvim](https://github.com/folke/lazy.nvim)** and built on modern-native foundations: the built-in LSP client (`vim.lsp.config`/`vim.lsp.enable`), Tree-sitter's `main` branch, and [blink.cmp](https://github.com/saghen/blink.cmp) completion. [snacks.nvim](https://github.com/folke/snacks.nvim) provides the picker, file explorer, notifier, terminal and dashboard in one place. The colorscheme is **onedark**; the leader key is `m`.

Config lives under [`lua/`](lua): `init.lua` loads `plugins → general → settings → mappings → config → autocommands`, with LSP servers in `lua/lsp/` and plugin configs in `lua/plugins/`.

## Key subsystems

- **LSP** — native client, no framework wrapper. Servers are configured per-file in `lua/lsp/*` via `vim.lsp.config[...]` + `vim.lsp.enable(...)` and are expected on `PATH` (no mason): `lua_ls`, `pyrefly`, `bashls`, `clangd`, `ts_ls`, `html`, `graphql`, `sqls`, `dockerls`, `vimls`, and `jsonls` (loaded lazily on the first json file, with [schemastore](https://github.com/b0o/schemastore.nvim) schemas).
- **Completion** — [blink.cmp](https://github.com/saghen/blink.cmp) (lsp / path / snippets / buffer), with [friendly-snippets](https://github.com/rafamadriz/friendly-snippets).
- **Formatting** — [conform.nvim](https://github.com/stevearc/conform.nvim), manual via `m lf` (falls back to LSP formatting). Wired for `shfmt`, `prettier`, and `stylua`/`isort`/`black`/`gofumpt` once those are installed.
- **Linting** — [nvim-lint](https://github.com/mfussenegger/nvim-lint) on read/write/insert-leave. `markdownlint` is active; `shellcheck`/`flake8`/`eslint` activate when installed.
- **Treesitter** — [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) **`main` branch**: parsers are compiled via the `tree-sitter` CLI (`pacman -S tree-sitter-cli`) and highlighting starts per-filetype. Run `:TSUpdate` after install.

## 🔌 Plugins

**Core / LSP / Completion** — [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), [schemastore.nvim](https://github.com/b0o/schemastore.nvim), [lazydev.nvim](https://github.com/folke/lazydev.nvim), [blink.cmp](https://github.com/saghen/blink.cmp)

**Formatting & Linting** — [conform.nvim](https://github.com/stevearc/conform.nvim), [nvim-lint](https://github.com/mfussenegger/nvim-lint)

**Treesitter** — [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter), [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag), [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim)

**UI** — [snacks.nvim](https://github.com/folke/snacks.nvim) (picker / explorer / notifier / terminal / dashboard), [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim), [bufferline.nvim](https://github.com/akinsho/bufferline.nvim), [which-key.nvim](https://github.com/folke/which-key.nvim), [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons), [nvim-scrollbar](https://github.com/petertriho/nvim-scrollbar), [nvim-colorizer.lua](https://github.com/catgoose/nvim-colorizer.lua), [smear-cursor.nvim](https://github.com/sphamba/smear-cursor.nvim)

**Themes** — [onedark.nvim](https://github.com/navarasu/onedark.nvim) (active), [tokyonight.nvim](https://github.com/folke/tokyonight.nvim), [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) + [styler.nvim](https://github.com/folke/styler.nvim) (per-filetype themes)

**Git** — [neogit](https://github.com/NeogitOrg/neogit), [diffview.nvim](https://github.com/sindrets/diffview.nvim)

**Editing & Markdown** — [smart-paste.nvim](https://github.com/nemanjamalesija/smart-paste.nvim), [markview.nvim](https://github.com/OXY2DEV/markview.nvim), [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim), [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)

**Diagnostics** — [trouble.nvim](https://github.com/folke/trouble.nvim), [diaglist.nvim](https://github.com/onsails/diaglist.nvim)

**Session & Remote** — [persistence.nvim](https://github.com/folke/persistence.nvim), [remote-nvim.nvim](https://github.com/amitds1997/remote-nvim.nvim) (uses [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim))

**Utilities** — [plenary.nvim](https://github.com/nvim-lua/plenary.nvim), [nui.nvim](https://github.com/MunifTanjim/nui.nvim), [structlog.nvim](https://github.com/Tastyep/structlog.nvim), [vim-startuptime](https://github.com/dstein64/vim-startuptime)

## Notable keybindings

Leader = `m`. The `m l…` family is LSP, `m f…` is the snacks picker, `m x…`/`m d…` is Trouble.

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
| `Alt-d` | toggle terminal (snacks) |
