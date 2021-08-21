vim.cmd [[packadd packer.nvim]]


return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-commentary'
    use 'vimwiki/vimwiki'
    use 'mileszs/ack.vim'
    -- use 'chriskempson/base16-vim'
    use {'nvim-treesitter/nvim-treesitter',  run = ':TSUpdate' }
    use 'tpope/vim-fugitive'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'folke/todo-comments.nvim'
    use 'hrsh7th/nvim-compe'
    use 'vinitkumar/base16-nvim'
    use 'yggdroot/indentline'
    use 'arcticicestudio/nord-vim'
    use 'romainl/vim-qf'
end)
