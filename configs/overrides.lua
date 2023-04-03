local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "scss",
    "rust",
    "regex",
    "sql",
    "c_sharp",
    "dart",
    "dockerfile",
    "gitignore",
    "java",
    "json",
    "javascript",
    "prisma",
    "python",
    "svelte",
    "toml",
    "yaml",
    "yuck",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
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
    "deno",
    "prettier",
    "rustywind",
    "jsonlint",
    "json-lsp",
    "eslint_d",
    "angular-language-server",
    "djlint",

    -- C#
    "csharpier",
    "csharp-language-server",

    -- rusty
    "rust_analyzer",
    "rustfmt",
    "codelldb",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },
  view = {
    adaptive_size = false,
    side = "right",
    width = 30,
    hide_root_folder = false,
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

M.telescope = {
  extensions_list = { "themes", "terms", "flutter" },
}

return M
