local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local util = require"lspconfig/util"
local lspconfig = require "lspconfig"
vim.diagnostic.config({
  virtual_text = false,
})

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "ruff_lsp"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


lspconfig.gopls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = {"go", "gomod", "gowork", "gotmpl"},
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      }
    },
  },
}

lspconfig.angularls.setup{}
lspconfig.graphql.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "graphql","graphqls", "typescriptreact", "javascriptreact" },
}
