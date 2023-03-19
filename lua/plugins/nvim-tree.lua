return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  version = 'nightly',
  config = function ()
    require("nvim-tree").setup({
      view = {
        centralize_selection = false,
        cursorline = true,
        debounce_delay = 15,
        width = 30,
        hide_root_folder = false,
        side = "right",
        preserve_window_proportions = false,
        number = true,
        relativenumber = true,
        signcolumn = "yes",
      },
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true
      },
    })
  end

}
