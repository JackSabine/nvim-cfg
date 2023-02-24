local dap_symbols = {
  ["DapBreakpoint"] = {
    text = "",
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
  },
  ["DapBreadpointRejected"] = {
    text = "",
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
  },
  ["DapStopped"] = {
    text = "ﰲ",
    texthl = "DiagnosticSignWarn",
    linehl = "Visual",
    numhl = "DiagnosticSignWarn",
  },
  ["DapBreakpointCondition"] = {
    text = "",
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
  },
}

for index, value in pairs(dap_symbols) do
  vim.fn.sign_define(index, value)
end
