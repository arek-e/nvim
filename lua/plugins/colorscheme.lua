return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  -- add bluloco theme
  {
    "uloco/bluloco.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      require("bluloco").setup({
        transparent = true,
        italics = true,
      })
    end,
  },

  -- Configure LazyVim to load gruvbox
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "bluloco",
  --   },
  -- },
}
