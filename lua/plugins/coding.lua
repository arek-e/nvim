return {
  {
    'echasnovski/mini.comment',
    version = false,
    config = function ()
      require('mini.comment').setup()
    end
  },
  {
    'echasnovski/mini.pairs',
    version = false,
    config = function ()
      require('mini.pairs').setup()
    end
  },
  {
    'echasnovski/mini.surround',
    version = false,
    config = function ()
      require('mini.surround').setup()
    end
  },
  {
    'm-demare/hlargs.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }
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

  {
    'echasnovski/mini.move',
    enabled = true,
    config = function ()
      require('mini.move').setup()
    end
  },
  { 'mattn/emmet-vim', ft = { 'html', 'css', 'scss', 'xml' } },
  { 'windwp/nvim-ts-autotag' }
}
