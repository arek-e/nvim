local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local sources = {
  b.formatting.prettier,
  b.diagnostics.jsonlint,
  b.formatting.rustywind, -- Tailwindcss
  b.formatting.djlint,

  -- Rust
  b.formatting.rustfmt,

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- Dart
  b.formatting.dart_format,

  -- Python
  b.diagnostics.ruff,
  b.formatting.ruff,

  b.formatting.beautysh,
}

null_ls.setup({
  debug = true,
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   group = augroup,
      --   buffer = bufnr,
      --   callback = function()
      --     vim.lsp.buf.format { bufnr = bufnr }
      --   end,
      -- })
    end
  end,
})
