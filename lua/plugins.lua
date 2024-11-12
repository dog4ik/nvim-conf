return {
  -- Themes
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    lazy = true,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require "configs/themes/rose-pine"
    end
  },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "slugbyte/lackluster.nvim", name = "lackluster", lazy = true },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require "configs.lualine"
    end
  },
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    config = function() 
      require "configs.telescope"
    end
  },
  -- lsp stuff
  {
    {
      "neovim/nvim-lspconfig", 
      lazy = false,
      config = function()
        require "configs.lsp"
      end
    },

    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      opts = {},
    },
    "williamboman/mason-lspconfig.nvim" ,

    -- Autocompletion
    "hrsh7th/nvim-cmp" ,
    "hrsh7th/cmp-buffer" ,
    "hrsh7th/cmp-path" ,
    "saadparwaiz1/cmp_luasnip" ,
    "hrsh7th/cmp-nvim-lsp" ,
    "hrsh7th/cmp-nvim-lua" ,

    -- Snippets
    "L3MON4D3/LuaSnip" ,
    "rafamadriz/friendly-snippets" ,

    {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "configs.null_ls"
      end
    },

    {
      "folke/neodev.nvim",
      opts = {},
      ft = "lua"
    },

    -- Diagnostics
    {
      "folke/trouble.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    }
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function() 
      require "configs.treesitter"
    end
  },
  "windwp/nvim-ts-autotag",
  "nvim-treesitter/nvim-treesitter-refactor",

  -- debugger
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require "configs.debugger"
    end,
    ft = "rust",
  },
  -- git
  { 
    "lewis6991/gitsigns.nvim",
    config = function() 
      require "configs.gitsigns"
    end
  },
  { 
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gs", vim.cmd.Git, desc = "Toggle vim fugitive" },
    }
  },
  -- misc
  {
    'saecki/crates.nvim',
    tag = 'stable',
    opts = {
      null_ls = {
        enabled = true,
        name = "crates.nvim"
      }
    },
    event = "BufEnter Cargo.toml",
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle undo tree" },
    }
  },
  -- navigation
  {
    'stevearc/oil.nvim',
    lazy = false,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() 
      require "configs.oil"
    end
  }
}
