return {
  {
    'echasnovski/mini.animate',
    version = false,
    config = function () require('mini.animate').setup() end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function ()
      require('indent_blankline').setup({
        show_current_context = true,
        show_current_context_start = true,
      })
    end
  },
  {
    'echasnovski/mini.indentscope',
    version = false,
    config = function ()
      require('mini.indentscope').setup({
        symbol = '╎',
      })
    end
  },
  { -- Highlights the word under the cursor
    'echasnovski/mini.cursorword',
    version = false,
    config = function ()
      require('mini.cursorword').setup()
    end
  },
  -- {
  --   "giusgad/pets.nvim",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "giusgad/hologram.nvim"
  --   },
  --   config = function()
  --     require("pets").setup({ })
  --   end,
  -- },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function ()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          -- local gs = package.loaded.gitsigns
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end,
        signs = {
          add          = { text = "│" },
          change       = { text = "│" },
          delete       = { text = "─" },
          topdelete    = { text = "▾" },
          changedelete = { text = "│" },
          untracked    = { text = "│" },
        },
        diff_opts = {
          internal = true,
        },
        preview_config = {
          border   = 'rounded',
          style    = 'minimal',
          relative = 'cursor',
          row      = 0,
          col      = 1
        }
      })
    end
  },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  {
    'lewis6991/satellite.nvim',
    enabled = true,
    event = 'VeryLazy',
    config = function ()
      require('satellite').setup()
    end
  },
  {
    'lewis6991/hover.nvim',
    enabled = true,
    event = 'LspAttach',
    require = 'nvim-lspconfig',
    config = function()
      require('hover').setup {
        init = function()
          -- Require providers
          require('hover.providers.lsp')
          require('hover.providers.man')
        end,
        preview_opts = {
          border = 'rounded',
        },
        title = true
      }
      vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
    end
  },
  {
    'hood/popui.nvim',
    disable = false,
    config = function()
      vim.ui.select = require('popui.ui-overrider')
      vim.ui.input = require('popui.input-overrider')
    end
  },
}
