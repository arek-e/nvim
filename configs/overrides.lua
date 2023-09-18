local M = {}

M.cmp = function(_, opts)
  local format_kinds = opts.formatting.format
  opts.formatting.format = function(entry, item)
    format_kinds(entry, item) -- add icons
    return require("tailwindcss-colorizer-cmp").formatter(entry, item)
  end
end

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",

    "go",
    "gomod",
    "gowork",
    "gosum",

    "dockerfile",

    "json",
    "json5",
    "jsonc",
  },
  highlight = { enable = true },
  indent = { enable = true },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "angular-language-server",
    "js-debug-adapter",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- Docker
    "dockerfile-language-server",
    "docker-compose-language-service",
    "hadolint",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.lspconfig = {
  -- servers = {
  --   tailwindcss = {
  --     filetypes_exclude = { "markdown" },
  --   },
  --   ---@type lspconfig.options.tsserver
  --   tsserver = {
  --     keys = {
  --       { "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
  --       { "<leader>cR", "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
  --     },
  --     settings = {
  --       typescript = {
  --         format = {
  --           indentSize = vim.o.shiftwidth,
  --           convertTabsToSpaces = vim.o.expandtab,
  --           tabSize = vim.o.tabstop,
  --         },
  --       },
  --       javascript = {
  --         format = {
  --           indentSize = vim.o.shiftwidth,
  --           convertTabsToSpaces = vim.o.expandtab,
  --           tabSize = vim.o.tabstop,
  --         },
  --       },
  --       completions = {
  --         completeFunctionCalls = true,
  --       },
  --     },
  --   },
  --   gopls = {
  --     keys = {
  --       -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
  --       { "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
  --     },
  --     settings = {
  --       gopls = {
  --         gofumpt = true,
  --         codelenses = {
  --           gc_details = false,
  --           generate = true,
  --           regenerate_cgo = true,
  --           run_govulncheck = true,
  --           test = true,
  --           tidy = true,
  --           upgrade_dependency = true,
  --           vendor = true,
  --         },
  --         hints = {
  --           assignVariableTypes = true,
  --           compositeLiteralFields = true,
  --           compositeLiteralTypes = true,
  --           constantValues = true,
  --           functionTypeParameters = true,
  --           parameterNames = true,
  --           rangeVariableTypes = true,
  --         },
  --         analyses = {
  --           fieldalignment = true,
  --           nilness = true,
  --           unusedparams = true,
  --           unusedwrite = true,
  --           useany = true,
  --         },
  --         usePlaceholders = true,
  --         completeUnimported = true,
  --         staticcheck = true,
  --         directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
  --         semanticTokens = true,
  --       },
  --     },
  --   },
  --   jsonls = {
  --     -- lazy-load schemastore when needed
  --     on_new_config = function(new_config)
  --       new_config.settings.json.schemas = new_config.settings.json.schemas or {}
  --       vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
  --     end,
  --     settings = {
  --       json = {
  --         format = {
  --           enable = true,
  --         },
  --         validate = { enable = true },
  --       },
  --     },
  --   },
  -- },
  -- setup = {
  --   --#region tailwindcss
  --   tailwindcss = function(_, opts)
  --     local tw = require "lspconfig.server_configurations.tailwindcss"
  --     --- @param ft string
  --     opts.filetypes = vim.tbl_filter(function(ft)
  --       return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
  --     end, tw.default_config.filetypes)
  --   end,
  --   --#endregion
  --
  --   --#region Typescript
  --   tsserver = function(_, opts)
  --     require("typescript").setup { server = opts }
  --     return true
  --   end,
  --   --#endregion
  --
  --   --#region GO
  --   gopls = function(_, opts)
  --     -- workaround for gopls not supporting semanticTokensProvider
  --     -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
  --     require("plugins.configs.lspconfig").on_attach(function(client, _)
  --       if client.name == "gopls" then
  --         if not client.server_capabilities.semanticTokensProvider then
  --           local semantic = client.config.capabilities.textDocument.semanticTokens
  --           client.server_capabilities.semanticTokensProvider = {
  --             full = true,
  --             legend = {
  --               tokenTypes = semantic.tokenTypes,
  --               tokenModifiers = semantic.tokenModifiers,
  --             },
  --             range = true,
  --           }
  --         end
  --       end
  --     end)
  --     -- end workaround
  --   end,
  --   --#endregion
  -- },
}

return M
