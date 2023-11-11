-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function cmd(command)
  return table.concat({ "<Cmd>", command, "<CR>" })
end

-- Configure Lspsaga keymaps
vim.keymap.set("n", "gd", "<cmd>lua vim.cmd('Lspsaga peek_definition')<cr>", { desc = "peek definition" })
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { desc = "lsp declaration" })
vim.keymap.set("n", "gh", "<cmd>lua vim.cmd('Lspsaga finder')<cr>", { desc = "Saga finder" })
vim.keymap.set("n", "K", "<cmd>lua vim.cmd('Lspsaga hover_doc')<cr>", { desc = "lsp saga hover" })
vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.cmd('Lspsaga code_action')<cr>", { desc = "code action" })
vim.keymap.set("n", "<leader>cr", "<cmd>lua vim.cmd('Lspsaga rename')<cr>", { desc = "rename" })
vim.keymap.set("n", "<leader>o", "<cmd>lua vim.cmd('Lspsaga outline')<cr>", { desc = "outline" })
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", { desc = "lsp implementation" })
vim.keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { desc = "lsp signature_help" })
vim.keymap.set("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", { desc = "Format document" })

vim.keymap.set("n", "<C-w>z", cmd("WindowsMaximize"))
vim.keymap.set("n", "<C-w>_", cmd("WindowsMaximizeVertically"))
vim.keymap.set("n", "<C-w>|", cmd("WindowsMaximizeHorizontally"))
vim.keymap.set("n", "<C-w>=", cmd("WindowsEqualize"))

vim.keymap.set("n", "<C-h>", cmd("TmuxNavigateLeft"), { desc = "TmuxNavigateLeft" })
vim.keymap.set("n", "<C-l>", cmd("TmuxNavigateRight"), { desc = "TmuxNavigateRight" })
vim.keymap.set("n", "<C-j>", cmd("TmuxNavigateDown"), { desc = "TmuxNavigateDown" })
vim.keymap.set("n", "<C-k>", cmd("TmuxNavigateUp"), { desc = "TmuxNavigateUp" })
