return {
  {
    -- WINDOW PICKER
    "s1n7ax/nvim-window-picker",
    keys = "<leader><leader>w",
    version = "v1.*",
    config = function()
      local picker = require("window-picker")
      picker.setup({ fg_color = "#000000" })

      vim.keymap.set("n", "<leader><leader>w", function()
        local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(picked_window_id)
      end, { desc = "Pick a window" })
    end,
  },
  {
    "anuvyklack/windows.nvim",
    dependencies = { "anuvyklack/middleclass", "anuvyklack/animation.nvim" },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
  },
}
