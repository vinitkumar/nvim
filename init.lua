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
  use 'tpope/vim-commentary'
  use 'github/copilot.vim'
  use {
    "tinted-theming/tinted-vim",
    config = function()
      vim.cmd.colorscheme 'base16-bright'
    end,
  }
  use 'duane9/nvim-rg'
  use 'craftzdog/solarized-osaka.nvim'

end)

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

-- clipboad
vim.opt.clipboard = 'unnamedplus'

vim.opt.foldlevelstart = 99 -- start unfolded
vim.opt.foldmethod = 'indent' -- not as cool as syntax, but faster
vim.opt.foldtext = 'v:lua.wincent.foldtext()'
vim.opt.formatoptions = vim.opt.formatoptions + 'j' -- remove comment leader when joining comment lines
vim.opt.formatoptions = vim.opt.formatoptions + 'n' -- smart auto-indenting inside numbered lists
vim.opt.guifont = 'Source Code Pro Light:h13'
vim.opt.hidden = true -- allows you to hide buffers with unsaved changes without being prompted
vim.opt.inccommand = 'split' -- live preview of :s results
vim.opt.ignorecase = true -- ignore case in searches
vim.opt.joinspaces = false -- don't autoinsert two spaces after '.', '?', '!' for join command
vim.opt.laststatus = 2 -- always show status line
vim.opt.lazyredraw = true -- don't bother updating screen during macro playback
vim.opt.linebreak = true -- wrap long lines at characters in 'breakat'
vim.opt.list = true -- show whitespace
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


vim.opt.shell = 'sh' -- shell to use for `!`, `:!`, `system()` etc.
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
vim.opt.smarttab = true -- <tab>/<BS> indent/dedent in leading whitespace
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
vim.opt.wildmenu = true -- show options as list when switching buffers etc
vim.opt.wildmode = 'longest:full,full' -- shell-like autocomplete to unambiguous portion
vim.opt.writebackup = false -- don't keep backups after writing


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


require("solarized-osaka").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  transparent = true, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
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


-- Custom utils written by me
function SwitchBackgroundAndColorScheme()
  -- We want the background to change based on the system's UI mode
  -- Works with MacOS only at the moment
  local mac_ui_mode = vim.fn.system('defaults read -g AppleInterfaceStyle')
  mac_ui_mode = mac_ui_mode:gsub('%s+', '') -- trim whitespace
  if mac_ui_mode == 'Dark' then
    vim.opt.background = 'dark'
    vim.cmd("colorscheme solarized-osaka")
  else
    vim.opt.background = 'light'
    vim.cmd("colorscheme solarized-osaka-day")
  end
end

local opts = {}

vim.cmd('autocmd FocusGained,BufEnter * lua SwitchBackgroundAndColorScheme()')
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
keymap.set('n', '<C-g>', ':LazyGit<CR>')
keymap.set('n', '<leader>gd', '<Plug>(coc-definition)')
keymap.set('n', '<leader>gy', '<Plug>(coc-type-definition)')
keymap.set('n', '<leader>gd', '<Plug>(coc-references)')
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

