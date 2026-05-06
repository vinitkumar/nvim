vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2

vim.opt.clipboard = { "unnamed", "unnamedplus" }

vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.formatoptions:append("jn")

vim.opt.belloff = "all"
vim.opt.emoji = false
vim.opt.hidden = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.joinspaces = false
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = {
  nbsp = "⦸",
  extends = "»",
  precedes = "«",
  tab = "▷─",
  trail = "•",
}
vim.opt.fillchars = {
  diff = "╱",
  eob = " ",
  fold = "·",
  vert = "│",
}

vim.opt.modelines = 5
vim.opt.number = true
vim.opt.pumheight = 20
vim.opt.pummaxwidth = 80
vim.opt.relativenumber = true
vim.opt.scrolloff = 3

vim.opt.shiftround = false
vim.opt.shiftwidth = 2
vim.opt.shortmess:append("AIIOTWacot")
vim.opt.showbreak = "↳ "
vim.opt.showcmd = false
vim.opt.sidescroll = 0
vim.opt.sidescrolloff = 3
vim.opt.smartcase = true
vim.opt.spellcapcheck = ""
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.suffixes:remove(".h")
vim.opt.swapfile = false
vim.opt.switchbuf = "usetab"
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.textwidth = 80
vim.opt.signcolumn = "yes"
vim.opt.completeopt = { "menu", "menuone", "popup", "fuzzy", "nearest" }
vim.opt.updatetime = 300
vim.opt.updatecount = 0
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo//"
vim.opt.viewoptions = "cursor,folds"
vim.opt.virtualedit = "block"
vim.opt.visualbell = true
vim.opt.whichwrap = "b,h,l,s,<,>,[,],~"
vim.opt.wildcharm = 26
vim.opt.wildignore:append({ "*.o", "*.rej", "*.so", "*/node_modules/*" })
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.writebackup = false

vim.opt.cursorline = true
vim.opt.backup = false
vim.opt.showmode = true
vim.opt.showtabline = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.hlsearch = true
vim.opt.wrap = true
vim.opt.wildoptions = "pum"
vim.opt.pumborder = "rounded"
vim.opt.winborder = "rounded"

vim.opt.fillchars:append({ foldinner = " " })
vim.opt.listchars:append({ leadtab = "▷─" })

vim.opt.guifont = "JetBrainsMono Nerd Font:h15"
