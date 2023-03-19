return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()

      require("mason").setup()

    end,
  },
  {
      "neovim/nvim-lspconfig",
      config = function ()
        local navic = require("nvim-navic")
        require('mason-lspconfig').setup({
          ensure_installed = {
            -- Replace these with whatever servers you want to install
            'rust_analyzer',
            'tsserver',
          }
        })

        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lsp_attach = function(client, bufnr)
          if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
          end
        end

        local lspconfig = require('lspconfig')
        require('mason-lspconfig').setup_handlers({
          function(server_name)
            lspconfig[server_name].setup({
              on_attach = lsp_attach,
              capabilities = lsp_capabilities,
            })
          end,
        })
      end
  }


}
