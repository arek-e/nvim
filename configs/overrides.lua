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
    "vue",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "go",
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

    "gopls",

    -- rusty
    "rust-analyzer",
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

M.nvterm = {
  terminals = {
    shell = vim.o.shell,
    list = {},
    type_opts = {
      float = {
        relative = "editor",
        row = 0.05,
        col = 0.05,
        width = 0.9,
        height = 0.8,
        border = "single",
      },
      horizontal = { location = "rightbelow", split_ratio = 0.3 },
      vertical = { location = "rightbelow", split_ratio = 0.5 },
    },
  },
}

return M
