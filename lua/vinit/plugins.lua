vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-commentary'
    -- use '/usr/local/opt/fzf'
    -- use 'junegunn/fzf.vim'
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'vimwiki/vimwiki'
    use 'mileszs/ack.vim'
    -- use 'jremmen/vim-ripgrep'
    -- use 'chriskempson/base16-vim'
    use {'nvim-treesitter/nvim-treesitter',  run = ':TSUpdate' }
    use 'tpope/vim-fugitive'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/popup.nvim'
    -- use 'hrsh7th/nvim-compe'
    -- switch to nvim-cmp
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'

    use 'vinitkumar/base16-nvim'
    use 'nvim-lua/plenary.nvim'
    use 'yggdroot/indentline'
    use "rebelot/kanagawa.nvim"
    use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function() require'nvim-tree'.setup {} end
    }
    -- Lua
    use {
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }
    use 'olimorris/onedarkpro.nvim'
    use 'EdenEast/nightfox.nvim'
    use 'folke/tokyonight.nvim'
    use 'folke/todo-comments.nvim'
    use 'wakatime/vim-wakatime'
    use {
      'nvim-lualine/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

end)
