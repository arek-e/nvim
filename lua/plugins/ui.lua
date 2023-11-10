return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  { "rmehri01/onenord.nvim" },

  { "catppuccin/nvim" },

  { "lunarvim/Onedarker.nvim" },

  {
    "uloco/bluloco.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      require("bluloco").setup({
        style = "auto", -- "auto" | "dark" | "light"
        transparent = true,
        italics = true,
        terminal = vim.fn.has("gui_running") == 1, -- bluoco colors are enabled in gui terminals per default.
        guicursor = true,
      })
    end,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "tokyoknight",
    },
  },
}
