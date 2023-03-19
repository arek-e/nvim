return {
  'akinsho/bufferline.nvim',
  event = "BufReadPre",
  enabled = true,
  dependencies = {'nvim-tree/nvim-web-devicons' },
  config = function ()
    require("bufferline").setup({
      options = {
        separator_style = "padded_slant",
        -- separator_style = 'none',
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = {'close'}
        },
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          if context.buffer:current() then
            return ''
          end

          local icon = level:match("error") and " " or ""
          return " " .. icon .. " " .. count
          -- return ''
        end,

      },
    })
  end
}
