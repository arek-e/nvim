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

vim.g.copilot_no_tab_map = true
M.copilot = {
   i = {
    ["<M-e>"] = { 'copilot#Accept("<CR>")', "accept copilot suggestion", opts = { expr = true }},
    ["<C-e>"] = { 'copilot#Accept("<CR>")', "accept copilot suggestion", opts = { expr = true }},
  },
}

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

M.git = {
  n = {
  ["<leader>gg"] = {
    function()
      local term = require("nvterm.terminal").new("float")
      vim.api.nvim_chan_send(term.job_id, "lazygit\n")
    end,
    "open Lazygit",
  },
}
}

return M
