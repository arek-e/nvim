local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

opt.timeoutlen = 600

opt.foldcolumn = "1" -- '0' is not bad
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.cmd("au BufEnter * silent! set foldlevelstart = 99")

vim.diagnostic.config({
  virtual_text = false,
})


-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})
