vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'vimwiki/vimwiki'
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use {'nvim-treesitter/nvim-treesitter',  run = ':TSUpdate' }
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
    use 'nvim-lua/popup.nvim'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'ful1e5/onedark.nvim'
    use 'petertriho/cmp-git'
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
end)
