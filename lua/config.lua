vim.g.loaded_matchparen  =  1

local opt = vim.opt

opt.history = 10000
opt.expandtab = true
opt.tabstop = 2
opt.colorcolumn = "120"
opt.shiftwidth = 2
opt.softtabstop = 2
opt.autoindent = true
opt.laststatus = 2
opt.showmatch = true
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.cursorline = true
opt.cmdheight = 1
opt.mouse = "a"
opt.showtabline = 2
opt.winwidth = 79
opt.shell = "zsh"
opt.scrolloff = 10
opt.backup = false
opt.writebackup = false
opt.backspace = 'indent,eol,start'
opt.showcmd = true
opt.splitright = true
opt.splitbelow = true
opt.termguicolors = true
opt.background = "dark"
opt.inccommand = "nosplit"
opt.completeopt="menu,menuone,noselect"

opt.list = true
opt.listchars      = {
  nbsp                 = '⦸',                              -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  extends              = '»',                              -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes             = '«',                              -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  tab                  = '▷┅',                             -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
  trail                = '•',                              -- BULLET (U+2022, UTF-8: E2 80 A2)
}

opt.modelines = 5
opt.number = true
opt.pumblend = 10
opt.relativenumber = true
opt.scrolloff = 3


vim.cmd('filetype indent plugin on')
-- vim.cmd('colorscheme gruvbox8_soft')
vim.cmd('syntax on')
vim.g.mapleader = ","
if vim.fn.filereadable('/usr/local/bin/python3') == 1 then
  -- Avoid search, speeding up start-up.
  vim.g.python3_host_prog = '/usr/local/bin/python3'
end

