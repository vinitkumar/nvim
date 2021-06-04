" remove all existing autocmds
autocmd!

" initialize plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-commentary'
Plug 'vimwiki/vimwiki'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'mileszs/ack.vim'

"telescope.vim
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'kyazdani42/nvim-web-devicons' " lua

Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'rafcamlet/nvim-luapad'
Plug 'shaunsingh/moonlight.nvim'
Plug 'folke/todo-comments.nvim'

Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'eddyekofo94/gruvbox-flat.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cursorline
set cmdheight=1
set switchbuf=useopen
" Always show tab bar at the top
set showtabline=2
set winwidth=79
" This makes RVM work inside Vim. I have no idea why.
set shell=zsh
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
" set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=10
" Don't make backups at all
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
let mapleader=","
" Fix slow O inserts
:set timeout timeoutlen=1000 ttimeoutlen=100
" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1
" Modelines (comments that set vim options on a per-file basis)
set modeline
set modelines=3
" Turn folding off for real, hopefully
set foldmethod=manual
set nofoldenable
" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces
" If a file is changed outside of vim, automatically reload it without asking
set autoread
" Use the old vim regex engine (version 1, as opposed to version 2, which was
" introduced in Vim 7.3.969). The Ruby syntax highlighting is significantly
" slower with the new regex engine.
set re=1
" Stop SQL language files from doing unholy things to the C-c key
let g:omni_sql_no_default_maps = 1
" Diffs are shown side-by-side not above/below
set diffopt=vertical
" Always show the sign column
set signcolumn=no
" True color mode! (Requires a fancy modern terminal, but iTerm works.)
:set termguicolors
" Write swap files to disk and trigger CursorHold event faster (default is
" after 4000 ms of inactivity)
:set updatetime=200
" Completion options.
"   menu: use a popup menu
"   preview: show more info in menu
:set completeopt=menu,preview
set clipboard+=unnamedplus

autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd FileType javascript setlocal expandtab sw=2 ts=2 sts=2
autocmd FileType json setlocal expandtab sw=2 ts=2 sts=2
autocmd FileType c setlocal expandtab sw=2 ts=2 sts=2
autocmd FileType php setlocal expandtab sw=2 ts=2 sts=2
autocmd BufNewFile,BufReadPost *.jade set filetype=pug
autocmd FileType html setlocal expandtab sw=2 ts=2 sts=2
autocmd FileType less setlocal expandtab sw=2 ts=2 sts=2
autocmd FileType htmldjango setlocal expandtab sw=2 ts=2 sts=2
autocmd FileType css setlocal expandtab sw=2 ts=2 sts=2
autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;
" Don't syntax highlight markdown because it's ften wrong
autocmd! FileType mkd setlocal syn=off
autocmd! BufNewFile,BufRead *.md setlocal ft=
" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Two-space indents in TypeScript
autocmd! FileType typescript set sw=2 sts=2 expandtab
" Automatically write after inactivity in TypeScript
autocmd FileType typescript autocmd CursorHold <buffer> :silent :wa

" Somehow, loading TypeScript .tsx files sometimes invokes the XML file
" type, which messes up the indentation. Force XML indentation to 2 so at
" least it doesn't change TypeScript indentation at random.
autocmd! FileType xml set sw=2 sts=2 expandtab

" Two-space indents in json
autocmd! FileType json set sw=2 sts=2 expandtab

" Remember cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif


" Auto save when focus is lost, so that not code is lost
au FocusLost * :wa

" Python related config
" Run black when on saving a python file
"autocmd BufWritePre *.py execute ':Black'
autocmd BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab fileformat=unix comments=:#\:,:#
" Two-space indents in TypeScript
autocmd! FileType typescript set sw=2 sts=2 expandtab
" Automatically write after inactivity in TypeScript
autocmd FileType typescript autocmd CursorHold <buffer> :silent :wa

" Somehow, loading TypeScript .tsx files sometimes invokes the XML file
" type, which messes up the indentation. Force XML indentation to 2 so at
" least it doesn't change TypeScript indentation at random.
autocmd! FileType xml set sw=2 sts=2 expandtab

autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell
:nnoremap <f5> :!ctags -R<CR>o
:set t_Co=256 " 256 colors
:color grb-lucius
GrbLuciusDarkHighContrast

:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-ale handles TypeScript quickfix, so tell Tsuquyomi not to do it.
let g:tsuquyomi_disable_quickfix = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","


" Find files using Telescope command-line sugar.
map <C-p> :Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nmap <C-b> :Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


map <leader>y "*y
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>
" Can't be bothered to understand ESC vs <c-c> in insert mode
inoremap <c-c> <esc>
" <leader><leader> is more convenient than <c-^>
nnoremap <leader><leader> <c-^>
" Align selected lines
vnoremap <leader>ib :!align<cr>
" Close all other splits
nnoremap <leader>o :only<cr>

set background=dark

au! BufWritePost ~/.config/nvim/init.vim so %

set background=dark
let g:lucius_style  = 'dark'
let g:lucius_contrast  = 'high'
let g:lucius_contrast_bg  = 'high'
let g:lucius_no_term_bg  = 1
set termguicolors
colorscheme gruvbox

lua << EOF
require'lspconfig'.tsserver.setup{
    -- cmd = {
    --   "typescript-language-server",
    --   "--stdio",
    --   "--tsserver-log-file",
    --   "tslog"
    -- },
    on_attach = on_attach,
}
EOF

lua << EOF
--https://github.com/glepnir/galaxyline.nvim
local M = {}
local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = { "LuaTree", "vista" }

 local colors = {
   bg = "#282c34", -- black
   line_bg = "#353644",
   fg = "#abb2bf", -- white

   dark_red = "#be5046",
   dark_yellow = "#d19a66",
   gutter_grey = "#4b5263",
   comment_grey = "#5c6370",

   yellow = "#e5c07b", -- light yellow
   cyan = "#56b6c2", -- cyan
   green = "#98c379", -- green
   orange = "#be5046",
   purple = "#5d4d7a",
   magenta = "#c678dd", -- magenta
   blue = "#61afef", -- blue
   red = "#e06c75", -- light red
 }

 local buffer_not_empty = function()
   if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
     return true
   end
   return false
 end

 M.setup = function()
   gls.left[1] = {
     ViMode = {
       provider = function()
         local mode_color = {
           n = colors.blue,
           i = colors.green,
           [""] = colors.magenta, -- visual block
           v = colors.magenta,
           [""] = colors.magenta,
           V = colors.magenta,
           c = colors.red,
           no = colors.magenta,
           s = colors.orange,
           S = colors.orange,
           [""] = colors.orange, -- select block
           ic = colors.yellow,
           R = colors.purple,
           Rv = colors.purple,
           cv = colors.red,
           ce = colors.red,
           r = colors.cyan,
           rm = colors.cyan,
           ["r?"] = colors.cyan,
           ["!"] = colors.red,
           t = colors.red,
         }
         vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
         return "▊ "
       end,
       highlight = { colors.red, colors.line_bg },
     },
   }
   gls.left[2] = {
     FileIcon = {
       provider = "FileIcon",
       condition = buffer_not_empty,
       highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, colors.line_bg },
     },
   }
   gls.left[3] = {
     FileName = {
       provider = { "FileName" },
       condition = buffer_not_empty,
       highlight = { colors.fg, colors.line_bg },
     },
   }

   gls.left[4] = {
     GitIcon = {
       provider = function()
         return "  "
       end,
       condition = require("galaxyline.provider_vcs").check_git_workspace,
       highlight = { colors.orange, colors.line_bg },
     },
   }
   gls.left[5] = {
     GitBranch = {
       provider = "GitBranch",
       condition = require("galaxyline.provider_vcs").check_git_workspace,
       highlight = { colors.fg, colors.line_bg },
     },
   }

   gls.left[6] = {
    LeftEnd = {
       provider = function()
         return ""
       end,
       separator = " ",
       separator_highlight = { colors.line_bg, colors.line_bg },
       highlight = { colors.bg, colors.line_bg },
     },
   }
   gls.left[7] = {
     DiagnosticError = {
       provider = "DiagnosticError",
       icon = " ",
       highlight = { colors.red, colors.bg },
     },
   }
   gls.left[8] = {
     DiagnosticWarn = {
       provider = "DiagnosticWarn",
       icon = " ",
       highlight = { colors.yellow, colors.bg },
     },
   }
   gls.left[9] = {
     MetalsStatus = {
       provider = function()
         return "  " .. (vim.g["metals_status"] or "")
       end,
       highlight = { colors.line_bg, colors.bg },
     },
   }
   gls.right[1] = {
     FileFormat = {
       provider = "FileFormat",
       separator = " ",
       separator_highlight = { colors.bg, colors.line_bg },
       highlight = { colors.fg, colors.line_bg },
     },
   }
   gls.right[2] = {
     LineInfo = {
       provider = "LineColumn",
       separator = " | ",
       separator_highlight = { colors.blue, colors.line_bg },
       highlight = { colors.fg, colors.line_bg },
     },
   }
   gls.right[3] = {
     ScrollBar = {
       provider = "ScrollBar",
       separator = " | ",
       separator_highlight = { colors.blue, colors.line_bg },
       highlight = { colors.blue, colors.purple },
     },
   }

   gls.short_line_left[1] = {
     BufferType = {
       provider = "FileTypeName",
       separator = "",
       separator_highlight = { colors.purple, colors.bg },
       highlight = { colors.fg, colors.purple },
     },
   }

   gls.short_line_right[1] = {
     BufferIcon = {
       provider = "BufferIcon",
       separator = "",
       separator_highlight = { colors.purple, colors.bg },
       highlight = { colors.fg, colors.purple },
     },
   }
 end

 M.setup()
EOF


lua <<EOF
-- https://github.com/nvim-telescope/telescope.nvim
local M = {}

M.setup = function()
  require("telescope").setup({
    defaults = {
      file_ignore_patterns = { "target", "node_modules", "parser.c" },
      prompt_prefix = "❯",
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    },
  })

  require("telescope").load_extension("fzy_native")
end
EOF

lua << EOF
require'lspconfig'.ccls.setup{}
EOF

lua << EOF
require'lspconfig'.pyright.setup{}
EOF

lua << EOF
require'lspconfig'.jedi_language_server.setup{}
EOF

" lua << EOF
"  require('moonlight').set()
" EOF


lua << EOF
require("todo-comments").setup {
  {
    signs = true, -- show icons in the signs column
    -- keywords recognized as todo comments
    keywords = {
      FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "FIX", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    },
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
      before = "", -- "fg" or "bg" or empty
      keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
      after = "fg", -- "fg" or "bg" or empty
    },
    -- list of named colors where we try to extract the guifg from the
    -- list of hilight groups or use the hex color if hl not found as a fallback
    colors = {
      error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
      warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
      info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
      hint = { "LspDiagnosticsDefaultHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    pattern = "(KEYWORDS):",
    -- pattern = "(KEYWORDS)", -- match without the extra colon. You'll likely get false positives
    -- pattern = "-- (KEYWORDS):", -- only match in lua comments
  }
}
EOF


command! Diary VimwikiDiaryIndex
augroup vimwikigroup
    autocmd!
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end

noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"tab management, leader-t to generate a new tab and Control-t to switch
"between them
noremap <Leader>t :<C-u>tabnew<CR>
nmap <C-t> :tabNext<CR>
nmap <leader>ev :vsplit $MYVIMRC<CR>



" Change these if you want
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

" I find the numbers disctracting
let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1


" Jump though hunks
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)
nmap <leader>gJ 9999<leader>gJ
nmap <leader>gK 9999<leader>gk


if has('nvim')
  set inccommand=nosplit
endif

" treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "java" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "Swift" },  -- list of language that will be disabled
  },
}
EOF


