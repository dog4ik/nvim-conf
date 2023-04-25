vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use {'nvim-telescope/telescope.nvim',tag='0.1.0',
	requires = { { 'nvim-lua/plenary.nvim'}}}
	use ({
		'folke/tokyonight.nvim',
		as = 'tokyonight',
	})
use({
    'rose-pine/neovim',
    as = 'rose-pine',
})
	use ('nvim-treesitter/nvim-treesitter',{run = ':TSUpdate'})
	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		}
	}
	use "nvim-lua/plenary.nvim"
	use 'jose-elias-alvarez/null-ls.nvim'
  use 'ThePrimeagen/vim-be-good'
use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
}
use('mbbill/undotree')
use('tpope/vim-fugitive')
use('theprimeagen/harpoon')
use ('nvim-lualine/lualine.nvim')
use ('windwp/nvim-ts-autotag')
use ('folke/neodev.nvim')
use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
}
use {
  "folke/todo-comments.nvim",
  requires = "nvim-lua/plenary.nvim",
}
use {
  'lewis6991/gitsigns.nvim',
}
use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
end)
