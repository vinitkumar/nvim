vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-commentary'
    use '/usr/local/opt/fzf'
    use 'junegunn/fzf.vim'
    use 'vimwiki/vimwiki'
    use 'mileszs/ack.vim'
    -- use 'jremmen/vim-ripgrep'
    -- use 'chriskempson/base16-vim'
    use {'nvim-treesitter/nvim-treesitter',  run = ':TSUpdate' }
    use 'tpope/vim-fugitive'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/popup.nvim'
    use 'hrsh7th/nvim-compe'
    use 'vinitkumar/base16-nvim'
    use 'yggdroot/indentline'
end)
