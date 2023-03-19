return {
  { "nvim-lua/plenary.nvim" },
  {
    "folke/which-key.nvim",
    keys = { '<space>' },
    config = function ()
      require('which-key').setup({
        window = {
          border   = 'rounded',
          position = 'bottom',
          margin   = { 1, 0, 1, 0 },
          padding  = { 2, 2, 2, 2 },
          winblend = 0
        },
        icons = {
          breadcrumb = '»',
          separator  = '➡  ',
          group      = ' ',
        },
        plugins = {
          marks     = false,
          registers = false,
          spelling = {
            enabled     = false,
            suggestions = 20,
          },
        },
        presets = {
          operators    = false,
          motions      = false,
          text_objects = false,
          windows      = true,
          nav          = true,
          z            = true,
          g            = true,
        },
        key_labels = {
          ['<space>'] = 'SPC',
          ['<cr>']    = 'RET',
          ['<tab>']   = 'TAB',
        },
      })
    end
  },
  {
    'folke/trouble.nvim',
    enabled = true,
    cmd = { 'Trouble' },
    config = function ()
      require('trouble').setup({
        auto_open    = false,
        auto_close   = true,
        padding      = false,
        height       = 5,
        signs        = { error = '', warning = '', hint = '', information = '', other = '', },
        track_cursor = true,

        action_keys = {
          close          = 'q',
          cancel         = '<esc>',
          refresh        = 'r',
          jump           = { '<cr>', '<tab>' },
          jump_close     = { 'o' },
          toggle_mode    = 'm',
          toggle_preview = 'P',
          hover          = 'K',
          preview        = 'p',
          close_folds    = { 'zM', 'zm' },
          open_folds     = { 'zR', 'zr' },
          toggle_fold    = { 'zA', 'za' },
          previous       = 'k',
          next           = 'j'
        },
      })
    end
  },
  {
    'echasnovski/mini.sessions',
    version = false,
    config = function ()
      require('mini.sessions').setup()
    end
  },
  { "NvChad/nvim-colorizer.lua" },
}
