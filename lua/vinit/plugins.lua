vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-commentary'
    use {'nvim-treesitter/nvim-treesitter',  run = ':TSUpdate' }
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/popup.nvim'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'mrnugget/vim-interestingwords'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'ful1e5/onedark.nvim'
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'

    use {
      'nvim-lualine/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
end)
