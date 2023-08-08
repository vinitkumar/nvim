-- Packer related config & installed plugins
local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'neovim/nvim-lspconfig' -- LSP
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'glepnir/lspsaga.nvim' -- LSP UIs
  use "rebelot/kanagawa.nvim"
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'windwp/nvim-autopairs'
  use 'tpope/vim-fugitive'
  use 'windwp/nvim-ts-autotag'
  use 'tpope/vim-commentary'
  use {
    'github/copilot.vim',
    config = function ()
      vim.g.copilot_enabled = true
    end
  }
  use 'RRethy/nvim-base16'
  use 'mhinz/vim-startify'
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'norcalli/nvim-colorizer.lua'
end)

vim.cmd("autocmd!")

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.breakindent = true

vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.shell = 'zsh'

vim.opt.inccommand = 'split'
vim.opt.hlsearch = true

vim.opt.wrap = false -- No Wrap lines

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.shiftwidth = 2
vim.opt.expandtab = true  -- expand tabs into spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.api.nvim_command('autocmd VimResized * :wincmd =')

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = "set nopaste"
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups


vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0 -- adds pseudo transparency to a floating window
vim.opt.wildoptions = 'pum'

-- We are going to use a random base16-colorscheme for some days, So commenting this out
-- function switchBackgroundAndColorScheme()
--   local m = vim.fn.system("defaults read -g AppleInterfaceStyle")
--   m = m:gsub("%s+", "") -- trim whitespace
--   if m == "Dark" then
--     kanagawaTheme()
--     vim.cmd("colorscheme catppuccin-macchiato")
--     vim.o.background = "dark"
--   else
--     vim.cmd("colorscheme catppuccin-latte")
--     vim.o.background = "light"
--   end
-- end

-- vim.cmd('autocmd FocusGained,BufEnter * lua switchBackgroundAndColorScheme()')

function kanagawaTheme()
  require('kanagawa').setup({
      compile = false,             -- enable compiling the colorscheme
      undercurl = true,            -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true},
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,         -- do not set background color
      dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
      terminalColors = true,       -- define vim.g.terminal_color_{0,17}
      colors = {                   -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors) -- add/modify highlights
          return {}
      end,
      theme = "wave",              -- Load "wave" theme when 'background' option is not set
      background = {               -- map the value of 'background' option to a theme
          dark = "wave",           -- try "dragon" !
          light = "lotus"
      },
  })
end


vim.g.mapleader = ","
local keymap = vim.keymap

-- split settings
keymap.set('n', '<Leader>h', ':<C-u>split<CR>', { noremap = true, silent = true })
keymap.set('n', '<Leader>v', ':<C-u>vsplit<CR>', { noremap = true, silent = true })

-- tab settings
keymap.set('n', '<Leader>t', ':<C-u>tabnew<CR>', { noremap = true, silent = true })
keymap.set('n', '<C-t>', ':tabNext<CR>', { noremap = true, silent = true })

-- Up and Down Mapping
keymap.set('n', '<CR>', 'G', { noremap = true, silent = true })
keymap.set('n', '<BS>', 'gg', { noremap = true, silent = true })

keymap.set('n', '<C-p>', ':Telescope find_files<CR>', { noremap = true, silent = true })
keymap.set('n', '<C-b>', ':Telescope buffers<CR>', { noremap = true, silent = true })
keymap.set('n', '<C-c>', ':Telescope git_commits<CR>', { noremap = true, silent = true })
keymap.set('n', '<C-e>', ':Telescope diagnostics bufnr=0<CR>', { noremap = true, silent = true })
keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

vim.opt.clipboard:append { 'unnamedplus' }

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>n', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua  vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end


-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

require'lspconfig'.pyright.setup{}


local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
    null_ls.builtins.diagnostics.fish
  }
})


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

vim.cmd('autocmd BufWritePre * lua StripTrailingWhitespace()')
-- Show space and tab characters
vim.opt.list = true
vim.opt.listchars = 'tab:› ,eol:¬,trail:⋅,nbsp:␣'


-- Get base16 themes from colorscheme files

-- List of available base16 themes
local themes = {
  '3024',
  'apathy',
  'apprentice',
  'ashes',
  'atelier-cave',
  'atelier-cave-light',
  'atelier-dune',
  'atelier-dune-light',
  'atelier-estuary',
  'atelier-estuary-light',
  'atelier-forest',
  'atelier-forest-light',
  'atelier-heath',
  'atelier-heath-light',
  'atelier-lakeside',
  'atelier-lakeside-light',
  'atelier-plateau',
  'atelier-plateau-light',
  'atelier-savanna',
  'atelier-savanna-light',
  'atelier-seaside',
  'atelier-seaside-light',
  'atelier-sulphurpool',
  'atelier-sulphurpool-light',
  'atlas',
  'ayu-dark',
  'ayu-light',
  'ayu-mirage',
  'bespin',
  'black-metal',
  'black-metal-bathory',
  'black-metal-burzum',
  'black-metal-dark-funeral',
  'black-metal-gorgoroth',
  'black-metal-immortal',
  'black-metal-khold',
  'black-metal-marduk',
  'black-metal-mayhem',
  'black-metal-nile',
  'black-metal-venom',
  'blueforest',
  'blueish',
  'brewer',
  'bright',
  'brogrammer',
  'brushtrees',
  'brushtrees-dark',
  'catppuccin',
  'catppuccin-frappe',
  'catppuccin-latte',
  'catppuccin-macchiato',
  'catppuccin-mocha',
  'chalk',
  'circus',
  'classic-dark',
  'classic-light',
  'codeschool',
  'colors',
  'cupcake',
  'cupertino',
  'da-one-black',
  'da-one-gray',
  'da-one-ocean',
  'da-one-paper',
  'da-one-sea',
  'da-one-white',
  'danqing',
  'darcula',
  'darkmoss',
  'darktooth',
  'darkviolet',
  'decaf',
  'default-dark',
  'default-light',
  'dirtysea',
  'dracula',
  'edge-dark',
  'edge-light',
  'eighties',
  'embers',
  'emil',
  'equilibrium-dark',
  'equilibrium-gray-dark',
  'equilibrium-gray-light',
  'equilibrium-light',
  'espresso',
  'eva',
  'eva-dim',
  'evenok-dark',
  'everforest',
  'flat',
  'framer',
  'fruit-soda',
  'gigavolt',
  'github',
  'google-dark',
  'google-light',
  'gotham',
  'grayscale-dark',
  'grayscale-light',
  'greenscreen',
  'gruber',
  'gruvbox-dark-hard',
  'gruvbox-dark-medium',
  'gruvbox-dark-pale',
  'gruvbox-dark-soft',
  'gruvbox-light-hard',
  'gruvbox-light-medium',
  'gruvbox-light-soft',
  'gruvbox-material-dark-hard',
  'gruvbox-material-dark-medium',
  'gruvbox-material-dark-soft',
  'gruvbox-material-light-hard',
  'gruvbox-material-light-medium',
  'gruvbox-material-light-soft',
  'hardcore',
  'harmonic-dark',
  'harmonic-light',
  'heetch',
  'heetch-light',
  'helios',
  'hopscotch',
  'horizon-dark',
  'horizon-light',
  'horizon-terminal-dark',
  'horizon-terminal-light',
  'human',
  'humanoid-dark',
	'humanoid-light',
	'ia-dark',
	'ia-light',
	'icy',
	'irblack',
	'isotope',
	'kanagawa',
	'katy',
	'kimber',
	'lime',
	'macintosh',
	'marrakesh',
	'materia',
	'material',
	'material-darker',
	'material-lighter',
	'material-palenight',
	'material-vivid',
	'mellow-purple',
	'mexico-light',
	'mocha',
	'monokai',
	'mountain',
	'nebula',
	'nord',
	'nova',
	'ocean',
	'oceanicnext',
	'one-light',
	'onedark',
	'outrun-dark',
	'pandora',
	'papercolor-dark',
	'papercolor-light',
	'paraiso',
	'pasque',
	'phd',
	'pico',
	'pinky',
	'pop',
	'porple',
	'primer-dark',
	'primer-dark-dimmed',
	'primer-light',
	'purpledream',
	'qualia',
	'railscasts',
	'rebecca',
	'rose-pine',
	'rose-pine-dawn',
	'rose-pine-moon',
	'sagelight',
	'sakura',
	'sandcastle',
	'seti',
	'shades-of-purple',
	'shadesmear-dark',
	'shadesmear-light',
	'shapeshifter',
	'silk-dark',
	'silk-light',
	'snazzy',
	'solarflare',
	'solarflare-light',
	'solarized-dark',
	'solarized-light',
	'spaceduck',
	'spacemacs',
	'standardized-dark',
	'standardized-light',
	'stella',
	'still-alive',
	'summercamp',
	'summerfruit-dark'
}



-- Pick random theme
math.randomseed(os.time())
local theme = themes[math.random(#themes)]

-- Load colorscheme
vim.cmd('colorscheme base16-'..theme)
