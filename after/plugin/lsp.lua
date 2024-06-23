require("neodev").setup({
	-- add any options here, or leave empty to use the default settings
})

require('mason').setup({})

vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>') 

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', 'vrn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', 'vca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp = require('lspconfig')

local default_setup = function(server)
  lsp[server].setup({
    capabilities = lsp_capabilities,
  })
end

local lua_setup = function ()
  lsp.lua_ls.setup({
    capabilities = lsp_capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT'
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = {
            vim.env.VIMRUNTIME,
          }
        }
      }
    }
  })
end

local tsserver_setup = function ()
  lsp.tsserver.setup({
    capabilities = lsp_capabilities,
    settings = {
      typescript = {
        format = {
          enable = false,
        }
      },
      javascript = {
        format = {
          enable = false,
        }
      }
    },
    on_attach = function(client, _)
      client.server_capabilities.documentFormattingProvider = false
    end
  })
end


require('mason-lspconfig').setup({
  ensure_installed = {'tsserver', 'rust_analyzer'},
  handlers = {
    default_setup,
    lua_ls = lua_setup,
    tsserver = tsserver_setup,
  },
})

local cmp = require('cmp')

local cmp_select = { behavior = cmp.SelectBehavior.Select }

local cmp_mappings = cmp.mapping.preset.insert({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		-- { name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
  },
  mapping = cmp_mappings,
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

vim.diagnostic.config({
	virtual_text = true,
  signs = false,
})

require('nvim-ts-autotag').setup({
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing </
  },
})
