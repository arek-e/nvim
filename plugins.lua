local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup {
        ui = {
          code_action = "󰠠",
        },
        lightbulb = {
          -- enable = true,
          enable_in_insert = false,
          sign = false,
          -- sign_priority = 40,
          virtual_text = true,
        },
      }
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  { "nvim-treesitter/nvim-treesitter-angular" },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },
  {
    "NvChad/nvterm",
    opts = overrides.nvterm,
  },

  {
    "github/copilot.vim",
    lazy = false,
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      ---@diagnostic disable-next-line: redundant-return-value
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      ---@diagnostic disable-next-line: different-requires
      require("rust-tools").setup(opts)
    end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    version = "v0.3.0",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      }
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, { name = "crates" })
      return M
    end,
  },

  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      require("flutter-tools").setup {
        lsp = {
          color = { -- show the derived colours for dart variables
            enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
            background = true, -- highlight the background
            background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
            foreground = false, -- highlight the foreground
            virtual_text = true, -- show the highlight using virtual text
            virtual_text_str = "", -- the virtual text character to highlight
          },
        },
      } -- use defaults
    end,
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    init = function()
      require("core.utils").load_mappings "dap"
    end,
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings "dap_go"
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      require "custom.configs.nvim-jdtls"
    end,
  },
  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- To make a plugin not be loaded
  {
    "NvChad/nvim-colorizer.lua",
    enabled = true,
  },

  {
    "echasnovski/mini.animate",
    version = "*",
    lazy = false,
    config = function()
      require("mini.animate").setup()
    end,
  },
  {
    "echasnovski/mini.indentscope",
    version = "*",
    lazy = false,
    config = function()
      require("mini.indentscope").setup {
        symbol = "╎",
      }
    end,
  },
  {
    "echasnovski/mini.move",
    version = "*",
    lazy = false,
    config = function()
      require("mini.move").setup()
    end,
  },
  {
    "echasnovski/mini.surround",
    version = "*",
    lazy = false,
    config = function()
      require("mini.surround").setup()
    end,
  },
  {
    "glepnir/dbsession.nvim",
    lazy = false,
    cmd = { "SessionSave", "SessionDelete", "SessionLoad" },
    opts = {},
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup {
        use_default_keymaps = false,
      }

      local langs = require("treesj.langs")["presets"]

      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = "*",
        callback = function()
          local opts = { buffer = true }
          if langs[vim.bo.filetype] then
            vim.keymap.set("n", "gS", "<Cmd>TSJSplit<CR>", opts)
            vim.keymap.set("n", "gJ", "<Cmd>TSJJoin<CR>", opts)
          else
            vim.keymap.set("n", "gS", "<Cmd>SplitjoinSplit<CR>", opts)
            vim.keymap.set("n", "gJ", "<Cmd>SplitjoinJoin<CR>", opts)
          end
        end,
      })
    end,
  },
  { "CRAG666/code_runner.nvim", config = true, event = "LspAttach" },
  { "mattn/emmet-vim", ft = { "html", "css", "scss", "xml" } },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "m-demare/hlargs.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  { "stevearc/dressing.nvim", event = "VeryLazy" },
  {
    "hood/popui.nvim",
    disable = false,
    config = function()
      vim.ui.select = require "popui.ui-overrider"
      vim.ui.input = require "popui.input-overrider"
    end,
  },

  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = "90",
    },
  },
  {
    -- WINDOW PICKER
    "s1n7ax/nvim-window-picker",
    keys = "<leader><leader>w",
    version = "v1.*",
    config = function()
      local picker = require "window-picker"
      picker.setup { fg_color = "#000000" }

      vim.keymap.set("n", "<leader><leader>w", function()
        local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(picked_window_id)
      end, { desc = "Pick a window" })
    end,
  },
  {
    -- windows.nvim is more like the traditional <Ctrl-w>_ and <Ctrl-w>|
    "anuvyklack/windows.nvim",
    dependencies = { "anuvyklack/middleclass" },
    keys = { "<C-w>,,", "<C-w>_", "<C-w>|", "<C-w>=" },
    config = function()
      vim.o.winwidth = 1
      vim.o.winminwidth = 0
      vim.o.equalalways = false
      require("windows").setup {
        autowidth = {
          enable = false, -- prevents messing up simrat39/symbols-outline.nvim (e.g. relative width of side-bar was being made larger)
        },
      }

      local function cmd(command)
        return table.concat { "<Cmd>", command, "<CR>" }
      end

      vim.keymap.set("n", "<C-w>,,", cmd "WindowsMaximize")
      vim.keymap.set("n", "<C-w>_", cmd "WindowsMaximizeVertically")
      vim.keymap.set("n", "<C-w>|", cmd "WindowsMaximizeHorizontally")
      vim.keymap.set("n", "<C-w>=", cmd "WindowsEqualize")
    end,
  },
  -- add nvim-ufo
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        enabled = true,
        config = function()
          local builtin = require "statuscol.builtin"
          require("statuscol").setup {
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          }
        end,
      },
    },
    event = "BufReadPost",
    opts = {},
    config = function()
      require "custom.configs.nvim-ufo"
    end,
  },
  --better inline lsp diagnostics
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "BufEnter",
    enabled = false,
    config = function()
      require("lsp_lines").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      require("core.utils").load_mappings "trouble"
    end,
    opts = {
      severity = nil,
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
      vim.diagnostic.config {
        virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
        signs = { severity = { min = vim.diagnostic.severity.HINT } },
        underline = { severity = { min = vim.diagnostic.severity.HINT } },
      }
    end,
  },
  {
    "phaazon/hop.nvim",
    version = "v2", -- optional but strongly recommended
    event = "BufEnter",
    opts = {},
    config = function()
      require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
    end,
  },
  {
    "glepnir/flybuf.nvim",
    cmd = "FlyBuf",
    lazy = false,
    config = function()
      require("flybuf").setup {}
    end,
  },
  {
    "elixir-tools/elixir-tools.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require "elixir"
      local elixirls = require "elixir.elixirls"

      elixir.setup {
        credo = {},
        elixirls = {
          enabled = true,
          settings = elixirls.settings {
            dialyzerEnabled = false,
            enableTestLenses = false,
          },
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings "gopher"
    end,
    build = function(_)
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
}

return plugins
