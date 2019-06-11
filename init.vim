  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-commentary'
Plug 'w0rp/ale'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'
Plug 'lifepillar/vim-solarized8'

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
call plug#end()

" Load Plug plugin and define the plugins to be used
" General settings
source ~/.vim/parts/general.vim
" UI settings, deals with theme, font etc
source ~/.vim/parts/ui.vim
" All autocmds are here.
source ~/.vim/parts/autocmd.vim
" Plugin specific tunings are here
source ~/.vim/parts/pluginconf.vim
source ~/.config/nvim/coc_conf.vim
" All the mappings are done here
source ~/.vim/parts/mappings.vim
" some misc plugins/ functions picked/borrowed from the Internets
source ~/.vim/parts/misc.vim


set rtp+=/usr/local/opt/fzf
au! BufWritePost ~/.vim/parts/general.vim  so %
au! BufWritePost ~/.vim/parts/ui.vim  so %
au! BufWritePost ~/.vim/parts/autocmd.vim  so %
au! BufWritePost ~/.vim/parts/pluginconf.vim  so %
au! BufWritePost ~/.vim/parts/mappings.vim  so %

au! BufWritePost ~/.config/nvim/init.vim so %


set guifont=Inconsolata-g:h15
