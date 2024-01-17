local status, packer = pcall(require, 'packer')
if (not status) then
    print('Packer is not installed')
    return
end

if vim.loader then
    vim.loader.enable()
end

-- load the required useins
vim.cmd [[ packadd packer.nvim]]

packer.startup(function (use)
  use 'wbthomason/packer.nvim'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use {'neoclide/coc.nvim', branch = 'master', run = 'npm ci'}
  use 'vimwiki/vimwiki'
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-commentary'
  use 'navarasu/onedark.nvim'
  -- colorsheme
  use 'p00f/alabaster.nvim'
  use 'gruvbox-community/gruvbox'
  use 'rose-pine/neovim'
end)


-- vim base config

vim.wo.number = true
vim.wo.relativenumber = true

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'


-- indent
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.shell = 'zsh'


-- search
vim.opt.inccommand = 'split'
vim.opt.hlsearch = true
vim.opt.wrap = true

-- swap
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- tabs and spaces
vim.opt.showmode = true
vim.opt.shiftwidth = 2
vim.opt.showtabline = 2
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.backspace = { 'start', 'eol', 'indent' }


-- don't read node_modules path
vim.opt.wildignore:append { '*/node_modules/*' }

-- UI
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildmode = longest,list
vim.opt.wildoptions = 'pum'
vim.opt.list = true
-- vim.opt.listchars = 'tab:› ,eol:¬,trail:⋅,nbsp:␣'
vim.opt.listchars = {
  eol = ""
}
vim.opt.updatetime = 300


-- Custom utils written by me
function switchBackgroundAndColorScheme()
  local mac_ui_mode = vim.fn.system('defaults read -g AppleInterfaceStyle')
  mac_ui_mode = mac_ui_mode:gsub('%s+', '') -- trim whitespace
  if mac_ui_mode == 'Dark' then
    -- vim.cmd('colorscheme gruvbox')
    -- vim.opt.background = 'dark'
    -- local onedark = require('onedark');
    -- onedark.setup {
    --   style = 'warm'
    -- }
    vim.cmd('colorscheme rose-pine')
    vim.opt.background = 'dark'
  -- onedark.load();
  else
    vim.cmd('colorscheme peachpuff')
    vim.opt.background = 'light'
  end
end

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

-- AutoCMDs to run our custom commands
vim.cmd('autocmd FocusGained,BufEnter * lua switchBackgroundAndColorScheme()')
vim.cmd('autocmd BufWritePre * lua StripTrailingWhitespace()')
vim.cmd("autocmd BufNewFile ~/vimwiki/diary/*.wiki :silent 0r !~/.vim/bin/generate-vimwiki-diary-template '%'")


-- AutoCMDs for file and tabstops
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.md',
  command = 'set filetype=markdown sts=4 shiftwidth=4',
})

vim.api.nvim_create_autocmd({'BufReadPost','BufNewFile'}, {
  pattern = {'*.md','*.txt','COMMIT_EDITMSG'},
  command = 'set wrap linebreak nolist spell spelllang=en_us complete+=kspell',
})

vim.api.nvim_create_autocmd({'BufReadPost','BufNewFile'}, {
  pattern = {'.html','*.txt','*.md','*.adoc'},
  command = 'set spell spelllang=en_us',
})

vim.api.nvim_create_autocmd({'BufWinEnter','FileType'}, {
  pattern = {'*.md','*.wiki'},
  command = 'colorscheme naysayer88',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gitcommit',
  command = 'setlocal spell textwidth=72',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'javascript',
  command = 'setlocal expandtab sw=2 ts=2 sts=2',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'typescript','json','c','html','htmldjango'},
  command = 'setlocal expandtab sw=2 ts=2 sts=2',
})

vim.api.nvim_create_autocmd({'BufNewFile','BufReadPost'}, {
  pattern = '*.tsx',
  command = 'set filetype=typescript.tsx',
})

vim.api.nvim_create_autocmd({'BufNewFile','BufReadPost'}, {
  pattern = {'*.yaml','*.yml'},
  command = 'set filetype=yaml',
})
vim.api.nvim_create_autocmd({'BufNewFile' ,'BufRead'}, {
  pattern = "*.md",
  command = "set filetype=markdown sts=4 shiftwidth=4",
})

vim.api.nvim_create_autocmd({"BufReadPost","BufNewFile"}, {
  pattern = {"*.md","*.txt","COMMIT_EDITMSG"},
  command = "set wrap linebreak nolist spell spelllang=en_us complete+=kspell",
})

vim.api.nvim_create_autocmd({"BufReadPost","BufNewFile"}, {
  pattern = {".html","*.txt","*.md","*.adoc"},
  command = "set spell spelllang=en_us",
})

vim.api.nvim_create_autocmd({"BufWinEnter","FileType"}, {
  pattern = {"*.md","*.wiki"},
  command = "colorscheme naysayer88",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  command = "setlocal spell textwidth=72",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "javascript",
  command = "setlocal expandtab sw=2 ts=2 sts=2",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"typescript","json","c","html","htmldjango"},
  command = "setlocal expandtab sw=2 ts=2 sts=2",
})

vim.api.nvim_create_autocmd({"BufNewFile","BufReadPost"}, {
  pattern = "*.tsx",
  command = "set filetype=typescript.tsx",
})

vim.api.nvim_create_autocmd({"BufNewFile","BufReadPost"}, {
  pattern = {"*.yaml","*.yml"},
  command = "set filetype=yaml",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  command = "setlocal ts=2 sts=2 sw=2 expandtab",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "typescript",
  callback = function()
    vim.api.nvim_command("silent wa")
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'yaml',
  command = 'setlocal ts=2 sts=2 sw=2 expandtab',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'typescript',
  callback = function()
    vim.api.nvim_command('silent wa')
  end
})


vim.fn.setenv('FZF_DEFAULT_COMMAND', 'rg --files --hidden')

-- Mapping
-- We start mapping here

vim.g.mapleader = ","
local keymap = vim.keymap


keymap.set('n', '<C-p>', ':Files<CR>')
keymap.set('n', '<C-b>', ':Buffers<CR>')
keymap.set('n', '<C-c>', ':Commits<CR>')
keymap.set('n', '<C-t>', ':tabNext<CR>')
keymap.set('n', '<C-e>', ':CocDiagnostics<CR>')
keymap.set('n', '<leader>gd', '<Plug>(coc-definition)')
keymap.set('n', '<leader>gy', '<Plug>(coc-type-definition)')
keymap.set('n', '<leader>gd', '<Plug>(coc-references)')
keymap.set('n', '<leader>gi', '<Plug>(coc-implementation)')
keymap.set('n', '<leader>h', ':<C-u>split<CR>')
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


-- Git signs
local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

gitsigns.setup({
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = {
      hl = "GitSignsChange",
      text = "▎",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
})
