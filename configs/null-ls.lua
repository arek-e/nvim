local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes
  b.code_actions.eslint_d,
  b.diagnostics.eslint_d,
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
  b.diagnostics.semgrep.with{ extra_filetypes = {"cs"}, disabled_filetypes = { "python" }}, -- TX, TSX, Ruby, Python, Java, Go  

  -- Dart
  b.formatting.dart_format,

  -- Go
  b.diagnostics.revive,
  b.formatting.golines.with({
    extra_args = {
      "--max-len=180",
      "--base-formatter=gofumpt",
    },
  }),

  -- Python
  -- b.diagnostics.flake8,
  -- b.formatting.yapf
  b.diagnostics.ruff,
  b.formatting.ruff,

  -- other
  -- b.code_actions.gitsigns,
}

null_ls.setup {
  debug = true,
  sources = sources,
}

local gotest = require("go.null_ls").gotest()
null_ls.register(gotest)
