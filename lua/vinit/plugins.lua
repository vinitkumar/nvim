vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use {'nvim-treesitter/nvim-treesitter',  run = ':TSUpdate' }
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'folke/lsp-colors.nvim'
    use 'nvim-lua/popup.nvim'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'mrnugget/vim-interestingwords'
    use 'hrsh7th/cmp-vsnip'
    use 'windwp/nvim-autopairs'
    use 'hrsh7th/vim-vsnip'
    use 'ful1e5/onedark.nvim'
    use 'davidsierradz/cmp-conventionalcommits'
    use 'petertriho/cmp-git'
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icons
      },
      tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    use {
      'nvim-lualine/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
end)
