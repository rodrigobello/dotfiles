local lspconfig = require'lspconfig'
local completion = require'completion'

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)

local function default_on_attach(client)
  print('Attaching to ' .. client.name)
  completion.on_attach(client)
end

local default_config = {
  on_attach = default_on_attach,
}

-- setup language servers here
-- lspconfig.tsserver.setup(default_config)
--lspconfig.sumneko_lua.setup(default_config)
--lspconfig.jsonls.setup(default_config)
--lspconfig.html.setup(default_config)
--lspconfig.cssls.setup(default_config)
lspconfig.pyright.setup(default_config)
lspconfig.vuels.setup(default_config)
lspconfig.yamlls.setup(default_config)
lspconfig.dockerls.setup(default_config)
