return{
    {"SmiteshP/nvim-navic"},

    {
      "m4xshen/smartcolumn.nvim",
      opts = {
        colorcolumn = "90",
      }
    },

    {
      -- WINDOW PICKER
      "s1n7ax/nvim-window-picker",
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
      dependencies = "kevinhwang91/promise-async",
      event = "BufReadPost",
      opts = {},

      init = function()
        -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
        vim.keymap.set("n", "zR", function()
          require("ufo").openAllFolds()
        end)
        vim.keymap.set("n", "zM", function()
          require("ufo").closeAllFolds()
        end)
      end,
    },

    --better inline lsp diagnostics
    {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require("lsp_lines").setup()
      end,
    }
  }
