---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}


-- keymap('n', '<leader>os', '<cmd>lua require("mini.sessions").select()<cr>', { desc = "Open session window" })
-- more keybinds!
M.mini = {
  n = {
    ["<leader>os"] = {"<cmd>lua require('mini.sessions').select()<cr>", "open sessions" }
  }
}

return M
