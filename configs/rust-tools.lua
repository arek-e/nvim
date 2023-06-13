local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilites = require("plugins.configs.lspconfig").capabilities

local options = {
  server = {
    on_attach = on_attach,
    capabilites = capabilites,
  },
}

return options
