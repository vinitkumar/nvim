-- =============================================================================
-- options.lua - editor settings
-- =============================================================================
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- UI
vim.opt.title = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.opt.sidescroll = 0
vim.opt.sidescrolloff = 3
vim.opt.showmode = true
vim.opt.showcmd = false
vim.opt.showtabline = 2
vim.opt.signcolumn = "yes"
vim.opt.pumheight = 20
vim.opt.pummaxwidth = 80
vim.opt.pumborder = "rounded"
vim.opt.winborder = "rounded"
vim.opt.termguicolors = true
vim.opt.guifont = "JetBrainsMono Nerd Font:h15"

-- Indent / formatting
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftround = false
vim.opt.textwidth = 80
vim.opt.formatoptions:append("jn")

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.inccommand = "split"

-- Editing
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.opt.hidden = true
vim.opt.joinspaces = false
vim.opt.linebreak = true
vim.opt.modelines = 5
vim.opt.virtualedit = "block"
vim.opt.whichwrap = "b,h,l,s,<,>,[,],~"
vim.opt.wrap = true

-- Persistence
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.updatetime = 300
vim.opt.updatecount = 0
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo//"
vim.opt.viewoptions = "cursor,folds"

-- Splits / buffers
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.switchbuf = "usetab"

-- Folds (ufo overrides foldcolumn/foldlevel on BufReadPost; treesitter expr
-- is the eager fallback for buffers ufo doesn't touch)
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Wildmenu / completion
vim.opt.completeopt = { "menu", "menuone", "popup", "fuzzy", "nearest" }
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildoptions = "pum"
vim.opt.wildcharm = 26
vim.opt.wildignore:append({ "*.o", "*.rej", "*.so", "*/node_modules/*" })

-- Quiet
vim.opt.belloff = "all"
vim.opt.visualbell = true
vim.opt.emoji = false
vim.opt.spellcapcheck = ""
-- A and I dedup'd; was "AIIOTWacot"
vim.opt.shortmess:append("AIOTWacot")

-- listchars / fillchars (single canonical assignment, no later append)
vim.opt.list = true
vim.opt.listchars = {
  nbsp = "⦸",
  extends = "»",
  precedes = "«",
  tab = "▷─",
  trail = "•",
  leadtab = "▷─",
}
vim.opt.fillchars = {
  diff = "╱",
  eob = " ",
  fold = "·",
  foldinner = " ",
  vert = "│",
}
vim.opt.showbreak = "↳ "

-- Misc
vim.opt.suffixes:remove(".h")
