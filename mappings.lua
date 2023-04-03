---@type MappingsTable
local M = {}

local function cmd(command)
  return table.concat({ "<cmd>", command, "<cr>" })
end

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

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

M.mini = {
  n = {
    ["<leader>os"] = {cmd "lua require('mini.sessions').select()", "open sessions" }
  }
}


M.diagnostics = {
  n = {
    ["<leader>ll"] = {toggle_diagnostics, "toggle LSP lines"}
  }
}

return M
