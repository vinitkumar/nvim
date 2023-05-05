local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'neovim/nvim-lspconfig' -- LSP
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'williamboman/mason.nvim'
	use 'EdenEast/nightfox.nvim'
  use 'williamboman/mason-lspconfig.nvim'
	use 'habamax/vim-rst'

  use 'glepnir/lspsaga.nvim' -- LSP UIs
  -- use 'L3MON4D3/LuaSnip'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'windwp/nvim-autopairs'
  use 'tpope/vim-fugitive'

	use 'sainnhe/edge'
	use 'sainnhe/gruvbox-material'
  use 'windwp/nvim-ts-autotag'
  use 'folke/zen-mode.nvim'
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use 'akinsho/nvim-bufferline.lua'

  use 'tpope/vim-commentary'
	use 'github/copilot.vim'
	use {
  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use {
			'nvim-tree/nvim-tree.lua',
			requires = {
				'nvim-tree/nvim-web-devicons', -- optional
			},
			config = function()
				require("nvim-tree").setup {}
			end
		}

	-- -- use 'wincent/command-t'
	-- use {
	-- 		'wincent/command-t',
	-- 		run = 'cd lua/wincent/commandt/lib && make',
	-- 		setup = function ()
	-- 						vim.g.CommandTPreferredImplementation = 'lua'
	-- 		end,
	-- 		config = function()
	-- 						require('wincent.commandt').setup()
	-- 		end,
	-- }
	-- use {
	-- 		't-troebst/perfanno.nvim',
	-- 		run = 'cd lua/wincent/commandt/lib && make',
	-- 		config = function()
	-- 			require("perfanno").setup()
	-- 		end,
	-- }
end)

