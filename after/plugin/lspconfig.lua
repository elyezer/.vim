local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')

lspconfig.bashls.setup{capabilities = capabilities}
lspconfig.dockerls.setup{capabilities = capabilities}
lspconfig.jsonls.setup {capabilities = capabilities}
lspconfig.pyright.setup{capabilities = capabilities}
lspconfig.vimls.setup{capabilities = capabilities}
lspconfig.yamlls.setup{capabilities = capabilities}
lspconfig.sumneko_lua.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
