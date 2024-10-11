require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

require('mason').setup({})

vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'vrn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
    vim.keymap.set('n', 'vca', vim.lsp.buf.code_action, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
  end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp = require('lspconfig')

local border = {
  border = "rounded"
}
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, border)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, border)
require("lspconfig.ui.windows").default_options.border = "rounded"

local default_setup = function(server)
  lsp[server].setup({
    capabilities = lsp_capabilities,
  })
end

local lua_setup = function()
  lsp.lua_ls.setup({
    capabilities = lsp_capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT'
        },
        diagnostics = {
          globals = { 'vim' },
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

local tsserver_setup = function()
  lsp.ts_ls.setup({
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
  ensure_installed = { 'ts_ls', 'rust_analyzer', 'gopls' },
  handlers = {
    default_setup,
    lua_ls = lua_setup,
    ts_ls = tsserver_setup,
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
  float = { border = "rounded" },
})

require('nvim-ts-autotag').setup({
  opts = {
    -- Defaults
    enable_close = true,          -- Auto close tags
    enable_rename = true,         -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing </
  },
})
