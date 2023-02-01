local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with({ extra_args = { "--tab-width", "4" } }),
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.stylua.with({
      extra_args = {
        "--indent-type", "Spaces",
        "--quote-style", "AutoPreferDouble",
        "--column-width", "100",
        "--call-parentheses", "Always",
        "--indent_width", "2",
      },
    }),
    formatting.clang_format.with({
      extra_args = { "--style", "{BasedOnStyle: llvm, IndentWidth: 4, ColumnLimit: 0}" },
    }),
    formatting.beautysh.with({
      extra_args = { "--indent-size", "2", "--force-function-style", "fnpar" }
    }),
    -- diagnostics.flake8
  },
})
