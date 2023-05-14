-- Packer related config & installed plugins
local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'neovim/nvim-lspconfig' -- LSP
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'williamboman/mason.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'habamax/vim-rst'
  use 'glepnir/lspsaga.nvim' -- LSP UIs
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
	use 'nvim-treesitter/nvim-treesitter-context'
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'windwp/nvim-autopairs'
  use 'tpope/vim-fugitive'
  use 'sainnhe/edge'
  use 'sainnhe/gruvbox-material'
  use 'windwp/nvim-ts-autotag'
  use 'folke/zen-mode.nvim'
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use 'akinsho/nvim-bufferline.lua'
  use 'tpope/vim-commentary'
  use 'github/copilot.vim'
  use {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
    config = function()
      require("nvim-tree").setup {
				sort_by = "case_sensitive",
				view = {
					width = 30,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
				},
			}
    end
  }

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
vim.opt.tabstop = 2
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

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
vim.opt.background = 'dark'
vim.cmd('colorscheme edge')
require("nvim-tree").setup()



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
-- keymap.set('n', '<C-l>', ':CommandTGit<CR>', { noremap = true, silent = true })
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
