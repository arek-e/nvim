local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local util = require "lspconfig/util"
local lspconfig = require "lspconfig"

local present, _ = pcall(require, "lsp_lines")
if present then
  vim.diagnostic.config {
    virtual_text = false,
  }
end

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "ruff_lsp", "tailwindcss" }

-- local ts_servers = { "astro" } --volar
-- for _, lsp in ipairs(ts_servers) do
--   lspconfig[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     filetypes = { "typescript", "javascript", "astro", "tsx", "javascriptreact", "typescriptreact", "vue", "json" },
--     init_options = {
--       typescript = {
--         -- tsdk = '/path/to/.npm/lib/node_modules/typescript/lib'
--         tsdk = "/usr/local/lib/node_modules/typescript/lib",
--       },
--     },
--   }
-- end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

lspconfig.angularls.setup {}
lspconfig.graphql.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "graphql", "graphqls", "typescriptreact", "javascriptreact" },
}
