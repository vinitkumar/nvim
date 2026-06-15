# Neovim Configuration

![nvim screenshot](./nvim.png)

This repository contains a Lua-based Neovim configuration with a small `init.lua` entrypoint and focused modules under `lua/config/`. It is tuned for native Neovim LSP features, lazy-loaded plugins, VimR on macOS, and a local light/dark colorscheme setup.

## Entry Point

`init.lua` loads these modules in order:

- `config.globals`
- `config.options`
- `config.lazy`
- `config.autocmds`
- `config.keymaps`
- `config.lsp`

## Layout

- `init.lua` bootstraps the config
- `lua/config/globals.lua` sets leader keys and disables built-in providers/netrw
- `lua/config/lazy.lua` bootstraps `lazy.nvim`
- `lua/config/options.lua` sets core editor options
- `lua/config/autocmds.lua` defines colorscheme switching and filetype-specific behavior
- `lua/config/keymaps.lua` defines custom mappings
- `lua/config/lsp.lua` enables Neovim's built-in LSP clients and turns on native LSP features on attach
- `colors/` contains local colorscheme files

## Plugin Manager

The configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim). If it is not installed, `lua/config/lazy.lua` clones the stable branch into Neovim's data directory on startup.

## Plugins

The current `lua/config/plugins.lua` declares these plugins:

| Plugin | Notes |
| --- | --- |
| [vinitkumar/fff.nvim](https://github.com/vinitkumar/fff.nvim) | Lazy-loaded on non-Linux systems for files, buffers, and Git files; built with `cargo build --release`; pinned to branch `feat/implement-buffers-support` |
| [dmmulroy/tsc.nvim](https://github.com/dmmulroy/tsc.nvim) | Lazy-loaded for TypeScript buffers, configured to run `tsgo --noEmit --pretty false` |
| [tpope/vim-commentary](https://github.com/tpope/vim-commentary) | Comment operator on `gc` |
| [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Custom "bubbles" statusline theme with native diagnostics/progress segments |
| [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | Dependency for lualine and nvim-tree |
| [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Loaded via `ibl` on `BufReadPost` |
| [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | `:NvimTreeToggle` file tree |
| [kdheepak/lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | `:LazyGit` integration |
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Starts Tree-sitter on file buffers and registers `markdown_inline` as `markdown` |
| [brenoprata10/nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors) | Background color previews, including Tailwind and variable usage |
| [kevinhwang91/nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) | Folding with Tree-sitter/indent providers |
| [kevinhwang91/promise-async](https://github.com/kevinhwang91/promise-async) | `nvim-ufo` dependency |
| [MagicDuck/grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) | Search and replace UI |
| [vimwiki/vimwiki](https://github.com/vimwiki/vimwiki) | Wiki and diary support, lazy-loaded for vimwiki filetype and Vimwiki commands |
| [ggandor/leap.nvim](https://github.com/ggandor/leap.nvim) | Motion plugin mapped on `s`, `S`, and `gs` |
| [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround) | Surround text objects |
| [j-hui/fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP progress UI |
| [vinitkumar/lanciabones.nvim](https://github.com/vinitkumar/lanciabones.nvim) | Primary colorscheme, loaded eagerly with high priority |
| [rktjmp/lush.nvim](https://github.com/rktjmp/lush.nvim) | `lanciabones.nvim` dependency |
| [zenbones-theme/zenbones.nvim](https://github.com/zenbones-theme/zenbones.nvim) | `lanciabones.nvim` dependency |

## Colorschemes

`lua/config/autocmds.lua` loads `lanciabones`, which renders light and dark variants based on `vim.o.background`.

Background selection works like this:

- `NVIM_BACKGROUND=dark` or `NVIM_BACKGROUND=light` overrides everything
- on macOS, the config reads `AppleInterfaceStyle` and follows the system appearance
- elsewhere, the default is `dark`

The repo also ships a `colors/` directory with local colorscheme files.

## Options

The current defaults from `lua/config/options.lua` include:

- line numbers and relative line numbers enabled
- UTF-8 encodings
- system clipboard via `unnamed` and `unnamedplus`
- GUI font set to `Berka Mono Closer Narrow:h18`
- 2-space indentation with `expandtab`
- `textwidth = 80`
- `termguicolors = true`
- Tree-sitter folding via `foldexpr`
- completion popup borders via `pumborder=rounded`
- floating window borders via `winborder=rounded`
- native popup completion tuned with `completeopt = menu,menuone,popup,fuzzy,nearest`
- `pummaxwidth = 80`
- persistent undo in `stdpath("data") .. "/undo//"`
- `cursorline`, `hlsearch`, `wrap`, and `wildmenu` enabled
- `swapfile`, `backup`, and `writebackup` disabled
- `list` enabled by default with visible tab/trailing/extends markers
- `splitbelow` and `splitright` enabled

## Autocommands

The config defines these behaviors in `lua/config/autocmds.lua`:

- strip trailing whitespace before write, except for binary buffers and diff files
- re-evaluate background/colorscheme on `FocusGained`
- for `~/vimwiki/diary/*.wiki`, insert a template from `~/.vim/bin/generate-vimwiki-diary-template`
- for `*.md`, force `markdown` filetype and set `softtabstop`/`shiftwidth` to 4
- for `*.md`, `*.txt`, `*.adoc`, `*.html`, and `COMMIT_EDITMSG`, enable wrap, linebreak, spell, and `kspell` completion
- for `gitcommit`, enable spelling and set `textwidth = 72`
- for `javascript`, `typescript`, `json`, `c`, `html`, and `htmldjango`, enforce 2-space indentation
- for `*.tsx`, force `filetype=typescript.tsx`
- for `*.yaml` and `*.yml`, force `filetype=yaml`
- for `yaml`, enforce 2-space indentation

## LSP

`lua/config/lsp.lua` enables Neovim's built-in LSP for:

- Ruby LSP: `ruby-lsp` with root markers `Gemfile`, `.ruby-version`, and `.git`
- TypeScript LSP: `typescript-language-server --stdio`
- Lua LSP: `lua-language-server`
- OCaml: resolves `$(opam var prefix)/bin/ocamllsp` lazily when an OCaml buffer opens, with root markers `.opam`, `dune-project`, and `.git`
- Pyright: `pyright-langserver --stdio`

On `LspAttach`, the config also enables these Neovim 0.12 native features when the server supports them:

- auto-triggered native LSP completion
- code lens display and execution
- linked editing ranges
- rounded diagnostic floats

## Keymaps

The current custom mappings from `lua/config/keymaps.lua` are:

| Mode | Mapping | Action |
| --- | --- | --- |
| Normal | `<C-p>` | Linux: `require("fzf-lua").files()`, otherwise lazy-load `fff.nvim` and call `require("fff").find_files()` |
| Normal | `<C-b>` | Linux: `require("fzf-lua").buffers()`, otherwise lazy-load `fff.nvim` and call `require("fff").buffers()` |
| Normal | `<C-h>` | Linux: `require("fzf-lua").git_files()`, otherwise lazy-load `fff.nvim` and call `require("fff").git_files()` |
| Normal | `<C-c>` | `:NvimTreeToggle<CR>` |
| Normal | `<C-t>` | `:tabNext<CR>` |
| Normal | `<C-e>` | open buffer diagnostics in the location list |
| Normal | `<C-g>` | `:LazyGit<CR>` |
| Normal | `<leader>S` | open `grug-far` search and replace |
| Normal/Visual | `<leader>sw` | open `grug-far` prefilled with word or selection |
| Normal | `<leader>gd` | native LSP definition |
| Normal | `<leader>gy` | native LSP type definition |
| Normal | `<leader>gr` | native LSP references |
| Normal | `<leader>gi` | native LSP implementation |
| Normal | `<leader>h` | horizontal split |
| Normal | `<leader>lr` | `:LspRestart` |
| Normal | `<leader>lw` | native workspace diagnostics |
| Normal | `<leader>v` | vertical split |
| Normal | `<leader>t` | new tab |
| Normal | `<leader>dt` | insert `strftime("%c")` |
| Normal | `<leader>rn` | rename symbol |
| Normal | `<leader>ca` | code action |
| Normal | `<CR>` | go to end of file (`G`) |
| Normal | `<BS>` | go to start of file (`gg`) |
| Normal | `<j>` | display-line down (`gj`) |
| Normal | `<k>` | display-line up (`gk`) |
| Normal | `zR` | open all folds with `nvim-ufo` |
| Normal | `zM` | close all folds with `nvim-ufo` |
| Normal | `zK` | preview folded lines with `nvim-ufo` |
| Normal/Visual/Operator | `s` | Leap forward |
| Normal/Visual/Operator | `S` | Leap backward |
| Normal/Visual/Operator | `gs` | Leap from window |
| Normal | `grx` | run native LSP code lens |
| Normal | `K` | hover documentation |
| Insert | `<Tab>` | native popup next item or literal tab |
| Insert | `<S-Tab>` | native popup previous item or literal shifted tab |
| Insert | `<CR>` | native popup confirm when an item is selected, otherwise newline |

Leader is `,`.

## Requirements

Based on the current config, these external tools are expected:

- Neovim with Lua config support and `vim.lsp.config` / `vim.lsp.enable`
- `git` to bootstrap `lazy.nvim`
- `fzf-lua` available on Linux if you use the Linux-only finder keymaps
- `cargo` to build `fff.nvim` on non-Linux systems
- `lazygit` for `:LazyGit`
- `ruby-lsp` for Ruby
- `typescript-language-server` for JavaScript and TypeScript
- `lua-language-server` for Lua
- `opam` and `ocamllsp` for the OCaml LSP
- `pyright-langserver` for Python
- `tsgo` for `tsc.nvim`
- `~/.vim/bin/generate-vimwiki-diary-template` if you use vimwiki diary creation

## Installation

```bash
git clone https://github.com/vinitkumar/nvim ~/.config/nvim
nvim
```

On first launch, `lazy.nvim` bootstraps itself and installs the configured plugins.
