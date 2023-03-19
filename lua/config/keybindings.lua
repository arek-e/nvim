vim.g.mapleader = " "

local keymap = vim.keymap.set

keymap('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')
keymap('n', '<leader>E', '<cmd>NvimTreeFindFile<cr>')
keymap('i', 'jk', '<Esc>')
keymap('n', '<leader>os', '<cmd>lua require("mini.sessions").select()<cr>', { desc = "Open session window" })
keymap('n', '<M-Left>', '<cmd>bprevious<cr>')
keymap('n', '<M-Right>', '<cmd>bnext<cr>')

local function toggle_diagnostics()
  local diagnostics_on = require("lsp_lines").toggle()
  if diagnostics_on then
    vim.diagnostic.config({
      virtual_text = false,
    })
  else
    vim.diagnostic.config({
      virtual_text = { spacing = 4, prefix = " ●" },
    })
  end
end

keymap("n", "<Leader>ui", toggle_diagnostics, { desc = "Toggle [i]nline diagnostic type" })

