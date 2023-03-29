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
        "--indent-type",
        "Spaces",
        "--quote-style",
        "AutoPreferDouble",
        "--column-width",
        "100",
        "--call-parentheses",
        "Always",
        "--indent-width",
        "2",
      },
    }),
    formatting.clang_format.with({
      extra_args = {
        "--style",
        "file:.clang-format",
        -- One day, hopefully, this will be a valid argument for clang-format
        -- In the meantime, create a "default" .clang-format in your home or root dir
        -- clang-format will search parent dirs for this file
        --
        -- Create the file with this (must have clang-format-15 installed through apt/LLVM releases):
        -- `clang-format-15 --style="{ BasedOnStyle: llvm, AccessModifierOffset: -4, AlignAfterOpenBracket: BlockIndent, AllowAllArgumentsOnNextLine: false, AllowShortBlocksOnASingleLine: false, AllowShortFunctionsOnASingleLine: false, AllowShortIfStatementsOnASingleLine: false, AllowShortLoopsOnASingleLine: false, AllowAllParametersOfDeclarationOnNextLine: false, BinPackArguments: false, BinPackParameters: false, BreakConstructorInitializers: BeforeComma, IndentWidth: 4}" --dump-config > ~/.clang-format`
        -- "--fallback-style",
        -- "{"
        --   .. "BasedOnStyle: llvm,"
        --   .. "AccessModifierOffset: -4,"
        --   .. "AlignAfterOpenBracket: BlockIndent,"
        --   .. "AllowAllArgumentsOnNextLine: false,"
        --   .. "AllowShortBlocksOnASingleLine: false,"
        --   .. "AllowShortFunctionsOnASingleLine: false,"
        --   .. "AllowShortIfStatementsOnASingleLine: false,"
        --   .. "AllowShortLoopsOnASingleLine: false,"
        --   .. "AllowAllParametersOfDeclarationOnNextLine: false,"
        --   .. "BinPackArguments: false,"
        --   .. "BinPackParameters: false,"
        --   .. "BreakConstructorInitializers: BeforeComma,"
        --   .. "IndentWidth: 4,"
        --   .. "}",
      },
    }),
    formatting.beautysh.with({
      extra_args = { "--indent-size", "2", "--force-function-style", "fnpar" },
    }),
    -- diagnostics.flake8
  },
})
