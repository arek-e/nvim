local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "scss" } }, -- so prettier works only on these filetypes
  b.code_actions.eslint_d,
  b.formatting.rome,
  b.diagnostics.jsonlint,
  b.formatting.rustywind, -- Tailwindcss
  b.formatting.djlint,

  -- Rust
  b.formatting.rustfmt,

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- C#
  b.formatting.csharpier,
  b.diagnostics.semgrep.with {
    extra_filetypes = { "cs" },
    disabled_filetypes = { "python", "go" },
    extra_args = { "--config", "auto" },
  }, -- TX, TSX, Ruby, Python, Java, Go

  -- Dart
  b.formatting.dart_format,

  -- Go
  b.formatting.gofumpt,
  b.formatting.goimports_reviser,
  b.formatting.golines,
  b.diagnostics.revive,
  -- b.formatting.gofumpt,
  -- b.formatting.golines.with({
  --   extra_args = {
  --     "--max-len=180",
  --     "--base-formatter=gofumpt",
  --   },
  -- }),

  -- Python
  b.diagnostics.ruff,
  b.formatting.ruff,

  -- other
  -- b.code_actions.gitsigns,
}

null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   group = augroup,
      --   buffer = bufnr,
      --   callback = function()
      --     vim.lsp.buf.format { bufnr = bufnr }
      --   end,
      -- })
    end
  end,
}
