-- Packer related config & installed plugins
local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end


if vim.loader then
  vim.loader.enable()
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
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'vimwiki/vimwiki'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'
  -- makes nvim lua stuff much better

  use({
         "hinell/lsp-timeout.nvim",
        requires={ "neovim/nvim-lspconfig" },
        setup = function()
            vim.g["lsp-timeout-config"] = {
                -- ...
            }
        end
  })
  use 'gruvbox-community/gruvbox'
  use 'mhinz/vim-startify'
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
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
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
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

function switchBackgroundAndColorScheme()
  local m = vim.fn.system("defaults read -g AppleInterfaceStyle")
  m = m:gsub("%s+", "") -- trim whitespace
  if m == "Dark" then
    vim.cmd("colorscheme gruvbox")
    vim.o.background = "dark"
  else
    vim.cmd("colorscheme gruvbox")
    vim.o.background = "light"
  end
end

vim.cmd('autocmd FocusGained,BufEnter * lua switchBackgroundAndColorScheme()')

vim.g.mapleader = ","
local keymap = vim.keymap

keymap.set('n', '<Leader>z', ':ZenMode<CR>', { noremap = true, silent = true })
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
keymap.set('n', '<Leader>g', ':Telescope live_grep<CR>', { noremap = true, silent = true })
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

-- Define the Grep command
vim.cmd([[
  command! -complete=dir -nargs=+ Grep silent grep <args>
        \| redraw!
        \| copen
]])


vim.cmd('autocmd BufWritePre * lua StripTrailingWhitespace()')
vim.cmd('au BufRead,BufNewFile *.pique setfiletype pique')
-- Show space and tab characters
vim.opt.list = true
vim.opt.listchars = 'tab:› ,eol:¬,trail:⋅,nbsp:␣'


