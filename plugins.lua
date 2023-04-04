local overrides = require("custom.configs.overrides")

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

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
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
    "github/copilot.vim",
    lazy = false,
  },

  {
    "simrat39/rust-tools.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    lazy = false,
    config = function ()
      local rt = require("rust-tools")
      rt.setup({
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      })
    end
  },

  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function ()
      require("flutter-tools").setup {} -- use defaults
    end
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui"
    }
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
    enabled = true
  },

  {
    'echasnovski/mini.animate',
    version = '*',
    lazy = false,
    config = function () require('mini.animate').setup() end
  },
  {
    'echasnovski/mini.indentscope',
    version = '*',
    lazy = false,
    config = function ()
      require('mini.indentscope').setup({
        symbol = '╎',
      })
    end
  },
  {
    'echasnovski/mini.sessions',
    version = '*',
    lazy = false,
    config = function ()
      require('mini.sessions').setup()
    end
  },
  {
    'echasnovski/mini.move',
    version = '*',
    lazy = false,
    config = function ()
      require('mini.move').setup()
    end
  },
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require'treesj'.setup {
        use_default_keymaps = false,
      }

      local langs = require'treesj.langs'['presets']

      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = '*',
        callback = function()
          local opts = { buffer = true }
          if langs[vim.bo.filetype] then
            vim.keymap.set('n', 'gS', '<Cmd>TSJSplit<CR>', opts)
            vim.keymap.set('n', 'gJ', '<Cmd>TSJJoin<CR>', opts)
          else
            vim.keymap.set('n', 'gS', '<Cmd>SplitjoinSplit<CR>', opts)
            vim.keymap.set('n', 'gJ', '<Cmd>SplitjoinJoin<CR>', opts)
          end
        end,
      })

    end,
  },
  { 'mattn/emmet-vim', ft = { 'html', 'css', 'scss', 'xml' } },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'm-demare/hlargs.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }
  },

  { "stevearc/dressing.nvim", event = "VeryLazy" },
  {
    'hood/popui.nvim',
    disable = false,
    config = function()
      vim.ui.select = require('popui.ui-overrider')
      vim.ui.input = require('popui.input-overrider')
    end
  },

  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = "90",
    }
  },
  {
    -- WINDOW PICKER
    "s1n7ax/nvim-window-picker",
    keys="<leader><leader>w",
    version = "v1.*",
    config = function()
      local picker = require("window-picker")
      picker.setup({ fg_color = "#000000" })

      vim.keymap.set("n", "<leader><leader>w", function()
        local picked_window_id =
        picker.pick_window() or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(picked_window_id)
      end, { desc = "Pick a window" })
    end
  },
  {
    -- windows.nvim is more like the traditional <Ctrl-w>_ and <Ctrl-w>|
    "anuvyklack/windows.nvim",
    dependencies = { "anuvyklack/middleclass" },
    keys={"<C-w>,,","<C-w>_","<C-w>|","<C-w>="},
    config = function()
      vim.o.winwidth = 1
      vim.o.winminwidth = 0
      vim.o.equalalways = false
      require("windows").setup({
        autowidth = {
          enable = false -- prevents messing up simrat39/symbols-outline.nvim (e.g. relative width of side-bar was being made larger)
        }
      })

      local function cmd(command)
        return table.concat({ "<Cmd>", command, "<CR>" })
      end

      vim.keymap.set("n", "<C-w>,,", cmd "WindowsMaximize")
      vim.keymap.set("n", "<C-w>_", cmd "WindowsMaximizeVertically")
      vim.keymap.set("n", "<C-w>|", cmd "WindowsMaximizeHorizontally")
      vim.keymap.set("n", "<C-w>=", cmd "WindowsEqualize")
    end
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
          local builtin = require("statuscol.builtin")
          require("statuscol").setup(
            {
              relculright = true,
              segments = {
                {text = {builtin.foldfunc}, click = "v:lua.ScFa"},
                {text = {"%s"}, click = "v:lua.ScSa"},
                {text = {builtin.lnumfunc, " "}, click = "v:lua.ScLa"}
              }
            }
          )
        end

      }
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
    event = 'BufEnter',
    config = function()
      require("lsp_lines").setup()
    end,
  },


}

return plugins
