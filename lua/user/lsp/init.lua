local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("user.lsp.mason")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")

local illuminate_ok, illuminate = pcall(require, "illuminate")
if not illuminate_ok then
  return
end

illuminate.configure({
  delay = 200,
  filetypes_denylist = {
    "gitcommit",
    "markdown",
    "plaintex",
    "qf",
    "help",
    "man",
    "lspinfo",
    "dap-repl",
    "dapui_watches",
    "dapui_breakpoints",
    "dapui_scopes",
    "dapui_console",
    "dapui_stacks",
    "dap-repl",
    "NvimTree",
    "TelescopePrompt",
    "packer",
    "toggleterm",
    "alpha",
  },
})
