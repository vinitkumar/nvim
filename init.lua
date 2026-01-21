-- Set leader key BEFORE loading plugins
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  {
    'vinitkumar/fff.nvim',
    branch = 'feat/implement-buffers-support',
    build = "cargo build --release",
    lazy = false,
    keys = {
    }
  },
  {
		"dmmulroy/tsc.nvim",
		lazy = true,
		ft = { "typescript", "typescriptreact" },
		config = function()
			require("tsc").setup({
				bin_name = "tsgo",
				auto_open_qflist = true,
				pretty_errors = false,
				flags = "--noEmit --pretty false",
			})
		end,
	},
  { 'neoclide/coc.nvim', branch = 'master', build = 'npm ci', event = 'BufReadPre' },
  { 'tpope/vim-commentary', keys = { { 'gc', mode = { 'n', 'v' } } } },
  'duane9/nvim-rg',
  'vinitkumar/oscura-vim',
  'vinitkumar/monokai-pro-vim',
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy'
  },
  'sainnhe/everforest',
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPost',
    main = 'ibl',
    opts = {},
  },
  {
    'nvim-tree/nvim-tree.lua',
    cmd = 'NvimTreeToggle',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  { 'kdheepak/lazygit.nvim', cmd = 'LazyGit' },
  {
    "sourcegraph/amp.nvim",
    branch = "main",
    lazy = false,
    opts = { auto_start = true, log_level = "info" },
  },

  -- Treesitter for syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      vim.treesitter.language.register('markdown', 'markdown_inline')
      -- ensure parsers are installed
      local ensure = {
        'lua', 'vim', 'vimdoc', 'javascript', 'typescript', 'tsx', 'python',
        'ruby', 'go', 'rust', 'c', 'cpp', 'json', 'yaml', 'html', 'css',
        'markdown', 'markdown_inline', 'bash', 'ocaml',
      }
      for _, lang in ipairs(ensure) do
        pcall(function() vim.treesitter.start(0, lang) end)
      end
    end,
  },

  -- Treesitter textobjects - disabled until updated for new treesitter API
  -- {
  --   'nvim-treesitter/nvim-treesitter-textobjects',
  --   event = { 'BufReadPost', 'BufNewFile' },
  --   dependencies = { 'nvim-treesitter/nvim-treesitter' },
  -- },

  -- nvim-ufo for better folding
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = 'BufReadPost',
    opts = {
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
    },
    init = function()
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    keys = {
      { 'zR', function() require('ufo').openAllFolds() end, desc = 'Open all folds' },
      { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },
      { 'zK', function() require('ufo').peekFoldedLinesUnderCursor() end, desc = 'Peek fold' },
    },
  },

  -- Harpoon for quick file navigation
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup()

      vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, { desc = 'Harpoon add' })
      vim.keymap.set('n', '<leader>ho', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon menu' })
      vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end, { desc = 'Harpoon 1' })
      vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end, { desc = 'Harpoon 2' })
      vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end, { desc = 'Harpoon 3' })
      vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end, { desc = 'Harpoon 4' })
      vim.keymap.set('n', '<leader>5', function() harpoon:list():select(5) end, { desc = 'Harpoon 5' })
    end,
  },

  -- Spectre for project-wide find/replace
  {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = 'Spectre',
    keys = {
      { '<leader>S', function() require('spectre').toggle() end, desc = 'Toggle Spectre' },
      { '<leader>sw', function() require('spectre').open_visual({ select_word = true }) end, desc = 'Search word' },
      { '<leader>sw', function() require('spectre').open_visual() end, mode = 'v', desc = 'Search selection' },
    },
    opts = {},
  },

  -- Leap for fast motion
  {
    'ggandor/leap.nvim',
    keys = {
      { 's', '<Plug>(leap-forward-to)', mode = { 'n', 'x', 'o' }, desc = 'Leap forward' },
      { 'S', '<Plug>(leap-backward-to)', mode = { 'n', 'x', 'o' }, desc = 'Leap backward' },
      { 'gs', '<Plug>(leap-from-window)', mode = { 'n', 'x', 'o' }, desc = 'Leap from window' },
    },
  },

  -- nvim-surround for surrounding text
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    opts = {},
  },

  -- fidget.nvim for LSP progress notifications
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {},
  },
})


-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}

require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
    lualine_b = { 'filename', 'branch' },
    lualine_c = {
      '%=', --[[ add your center components here in place of this comment ]]
    },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}


-- require('lualine').setup {
--   options = {
--     icons_enabled = true,
--     theme = 'everforest',
--     disabled_filetypes = {
--       statusline = {},
--       winbar = {},
--     },
--     ignore_focus = {},
--     always_divide_middle = true,
--     always_show_tabline = true,
--     globalstatus = true,
--     refresh = {
--       statusline = 1000,
--     }
--   },
--   sections = {
--     lualine_a = {'mode'},
--     lualine_b = {'branch', 'diff', 'diagnostics'},
--     lualine_c = {'filename'},
--     lualine_x = {'encoding', 'fileformat', 'filetype'},
--     lualine_y = {'progress'},
--     lualine_z = {'location'}
--   },
--   inactive_sections = {
--     lualine_a = {},
--     lualine_b = {},
--     lualine_c = {'filename'},
--     lualine_x = {'location'},
--     lualine_y = {},
--     lualine_z = {}
--   },
--   tabline = {},
--   winbar = {},
--   inactive_winbar = {},
--   extensions = {}
-- }


vim.wo.number = true
vim.wo.relativenumber = true


vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'


vim.g.loaded_netrw  = 1
vim.g.loaded_netrwPlugin = 1


-- indent
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.shell = 'sh'

-- clipboard
vim.opt.clipboard = { "unnamed", "unnamedplus" }


vim.opt.foldlevelstart = 99 -- start unfolded
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.formatoptions = vim.opt.formatoptions + 'j' -- remove comment leader when joining comment lines
vim.opt.formatoptions = vim.opt.formatoptions + 'n' -- smart auto-indenting inside numbered lists
vim.opt.guifont = 'JetBrains Mono:h18'

if vim.g.neovide then
  vim.o.guifont = "JetBrains Mono:h14"

  -- Optional but sensible Neovide tuning
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_refresh_rate = 120
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.8
end


vim.opt.hidden = true -- allows you to hide buffers with unsaved changes without being prompted
vim.opt.inccommand = 'split' -- live preview of :s results
vim.opt.ignorecase = true -- ignore case in searches
vim.opt.joinspaces = false -- don't autoinsert two spaces after '.', '?', '!' for join command
vim.opt.lazyredraw = true -- don't bother updating screen during macro playback
vim.opt.linebreak = true -- wrap long lines at characters in 'breakat'
vim.opt.listchars = {
  nbsp = '⦸', -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  extends = '»', -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes = '«', -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  tab = '▷⋯', -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + MIDLINE HORIZONTAL ELLIPSIS (U+22EF, UTF-8: E2 8B AF)
  trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
}

vim.opt.modelines = 5 -- scan this many lines looking for modeline
vim.opt.number = true -- show line numbers in gutter
vim.opt.pumheight = 20 -- max number of lines to show in pop-up menu
vim.opt.relativenumber = true -- show relative numbers in gutter
vim.opt.scrolloff = 3 -- start scrolling 3 lines before edge of viewport

vim.opt.shiftround = false -- don't always indent by multiple of shiftwidth
vim.opt.shiftwidth = 2 -- spaces per tab (when shifting)
vim.opt.shortmess = vim.opt.shortmess + 'A' -- ignore annoying swapfile messages
vim.opt.shortmess = vim.opt.shortmess + 'I' -- no splash screen
vim.opt.shortmess = vim.opt.shortmess + 'O' -- file-read message overwrites previous
vim.opt.shortmess = vim.opt.shortmess + 'T' -- truncate non-file messages in middle
vim.opt.shortmess = vim.opt.shortmess + 'W' -- don't echo "[w]"/"[written]" when writing
vim.opt.shortmess = vim.opt.shortmess + 'a' -- use abbreviations in messages eg. `[RO]` instead of `[readonly]`
vim.opt.shortmess = vim.opt.shortmess + 'c' -- completion messages
vim.opt.shortmess = vim.opt.shortmess + 'o' -- overwrite file-written messages
vim.opt.shortmess = vim.opt.shortmess + 't' -- truncate file messages at start
vim.opt.showbreak = '↳ ' -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
vim.opt.showcmd = false -- don't show extra info at end of command line
vim.opt.sidescroll = 0 -- sidescroll in jumps because terminals are slow
vim.opt.sidescrolloff = 3 -- same as scrolloff, but for columns
vim.opt.smartcase = true -- don't ignore case in searches if uppercase characters present
vim.opt.spellcapcheck = '' -- don't check for capital letters at start of sentence
vim.opt.splitbelow = true -- open horizontal splits below current window
vim.opt.splitright = true -- open vertical splits to the right of the current window
vim.opt.suffixes = vim.opt.suffixes - '.h' -- don't sort header files at lower priority
vim.opt.swapfile = false -- don't create swap files
vim.opt.switchbuf = 'usetab' -- try to reuse windows/tabs when switching buffers
vim.opt.synmaxcol = 200 -- don't bother syntax highlighting long lines
vim.opt.tabstop = 2 -- spaces per tab
vim.opt.termguicolors = true -- use guifg/guibg instead of ctermfg/ctermbg in terminal
vim.opt.textwidth = 80 -- automatically hard wrap at 80 columns
vim.opt.signcolumn = 'yes' -- always show sign column
vim.opt.updatetime = 2000 -- CursorHold interval
vim.opt.updatecount = 0 -- update swapfiles every 80 typed chars
vim.opt.viewoptions = 'cursor,folds' -- save/restore just these (with `:{mk,load}view`)
vim.opt.virtualedit = 'block' -- allow cursor to move where there is no text in visual block mode
vim.opt.visualbell = true -- stop annoying beeping for non-error errors
vim.opt.whichwrap = 'b,h,l,s,<,>,[,],~' -- allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line boundaries
vim.opt.wildcharm = 26 -- ('<C-z>') substitute for 'wildchar' (<Tab>) in macros
vim.opt.wildignore = vim.opt.wildignore + '*.o,*.rej,*.so' -- patterns to ignore during file-navigation
vim.opt.wildignore:append { '*/node_modules/*' }
vim.opt.wildmenu = true -- show options as list when switching buffers etc
vim.opt.wildmode = 'longest:full,full' -- shell-like autocomplete to unambiguous portion
vim.opt.writebackup = false -- don't keep backups after writing

-- UI
vim.opt.cursorline = true
vim.opt.backup = false
vim.opt.showmode = true
vim.opt.showtabline = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.hlsearch = true
vim.opt.wrap = true
vim.opt.wildoptions = 'pum'


function StripTrailingWhitespace()
  if not vim.bo.binary and vim.bo.filetype ~= 'diff' then
    vim.cmd('normal! mz')
    vim.cmd('normal! Hmy')
    if vim.bo.filetype == 'mail' then
      -- Preserve space after e-mail signature separator
      vim.cmd('%s/\\(^--\\)\\@<!\\s\\+$//e')
    else
      vim.cmd('%s/\\s\\+$//e')
    end
    vim.cmd('normal! \'yz<Enter>')
    vim.cmd('normal! `z')
  end
end


-- Custom utils written by me
local current_bg = nil

local function macos_is_dark()
  local out = vim.fn.system('defaults read -g AppleInterfaceStyle 2>/dev/null')
  out = (out or ''):gsub('%s+', '')
  return out == 'Dark'
end

local function switch_background_and_colorscheme()
  local dark = macos_is_dark()
  local bg = dark and 'dark' or 'light'
  if bg == current_bg then return end
  current_bg = bg

  vim.opt.background = bg
  if dark then
    vim.cmd.colorscheme('sorbet')
  else
    vim.cmd.colorscheme('gruvbox8_soft')
  end
end

-- Create autogroup for all user autocmds
local user_augroup = vim.api.nvim_create_augroup('user_autocmds', { clear = true })

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  group = user_augroup,
  callback = switch_background_and_colorscheme,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = user_augroup,
  callback = StripTrailingWhitespace,
})

vim.api.nvim_create_autocmd('BufNewFile', {
  group = user_augroup,
  pattern = vim.fn.expand('~') .. '/vimwiki/diary/*.wiki',
  callback = function()
    vim.cmd("silent 0r !~/.vim/bin/generate-vimwiki-diary-template '%'")
  end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = user_augroup,
  pattern = '*.md',
  callback = function()
    vim.bo.filetype = 'markdown'
    vim.bo.softtabstop = 4
    vim.bo.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  group = user_augroup,
  pattern = { '*.md', '*.txt', 'COMMIT_EDITMSG' },
  callback = function()
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.list = false
    vim.wo.spell = true
    vim.bo.spelllang = 'en_us'
    vim.opt_local.complete:append('kspell')
  end,
})

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  group = user_augroup,
  pattern = { '.html', '*.txt', '*.md', '*.adoc' },
  callback = function()
    vim.wo.spell = true
    vim.bo.spelllang = 'en_us'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = user_augroup,
  pattern = 'gitcommit',
  callback = function()
    vim.wo.spell = true
    vim.bo.textwidth = 72
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = user_augroup,
  pattern = { 'javascript', 'typescript', 'json', 'c', 'html', 'htmldjango' },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
  end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPost' }, {
  group = user_augroup,
  pattern = '*.tsx',
  callback = function()
    vim.bo.filetype = 'typescript.tsx'
  end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPost' }, {
  group = user_augroup,
  pattern = { '*.yaml', '*.yml' },
  callback = function()
    vim.bo.filetype = 'yaml'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = user_augroup,
  pattern = 'yaml',
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end,
})


-- Keymaps
local keymap = vim.keymap



keymap.set('n', '<C-p>', function() require('fff').find_files() end, { desc = 'Find files' })
keymap.set('n', '<C-b>', function() require('fff').buffers() end, { desc = 'Find files' })
keymap.set('n', '<C-h>', function() require('fff').git_files() end, { desc = 'Find Git files for Commit' })
keymap.set('n', '<C-c>', ':NvimTreeToggle<CR>')
keymap.set('n', '<C-t>', ':tabNext<CR>')
keymap.set('n', '<C-e>', ':CocDiagnostics<CR>')
keymap.set('n', '<C-g>', ':LazyGit<CR>')
keymap.set('n', '<leader>gd', '<Plug>(coc-definition)')
keymap.set('n', '<leader>gy', '<Plug>(coc-type-definition)')
keymap.set('n', '<leader>gr', '<Plug>(coc-references)')
keymap.set('n', '<leader>gi', '<Plug>(coc-implementation)')
keymap.set('n', '<leader>h', ':<C-u>split<CR>')
keymap.set('n', '<leader>z', ':<C-u>Goyo<CR>')
keymap.set('n', '<leader>v', ':<C-u>vsplit<CR>')
keymap.set('n', '<leader>t', ':<C-u>tabnew<CR>')
keymap.set('n', '<leader>dt', 'i<C-r>=strftime("%c")<CR>', { noremap = true, silent = true })


keymap.set('n', '<CR>', 'G')
keymap.set('n', '<BS>', 'gg')
keymap.set('n', '<j>', 'gj')
keymap.set('n', '<k>', 'gk')


local function check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }

keymap.set("i", "<Tab>",
    function()
        if vim.fn['coc#pum#visible']() == 1 then
            return vim.fn['coc#pum#next'](1)
        end
        if check_back_space() then
            return vim.fn['coc#refresh']()
        end
        return "<Tab>"
    end
    , opts)
keymap.set("i", "<S-Tab>", function()
        if vim.fn['coc#pum#visible']() == 1 then
            return vim.fn['coc#pum#prev'](1)
        end
        return "<S-Tab>"
end, opts)
keymap.set("i", "<CR>", function()
        if vim.fn['coc#pum#visible']() == 1 then
            return vim.fn['coc#pum#confirm']();
        end
       return "\r"
end, opts)


vim.lsp.config("sorbet", {
  cmd = { "srb", "tc", "--lsp" },
  filetypes = { "ruby" },
  root_markers = { "Gemfile", ".git" },
})
vim.lsp.enable("sorbet")

-- OCaml LSP configuration
local opam_switch_prefix = vim.fn.system("opam var prefix"):gsub('\n', '')
local ocamllsp_bin = opam_switch_prefix .. "/bin/ocamllsp"

vim.lsp.config("ocamllsp", {
  cmd = { ocamllsp_bin },
  filetypes = { "ocaml", "ocamlinterface" },
  root_markers = { ".opam", "dune-project", ".git" },
})
vim.lsp.enable("ocamllsp")
