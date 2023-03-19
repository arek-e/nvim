return {
  {
    "catppuccin/nvim",
    enabled = false,
    name = "catppuccin"
  },
  {
    'uloco/bluloco.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      vim.opt.termguicolors = true
      vim.cmd('colorscheme bluloco')
    end,
  }
}
