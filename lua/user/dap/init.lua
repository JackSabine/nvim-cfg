local dap_ok, _ = pcall(require, "dap")
if not dap_ok then
  return
end

require("user.dap.symbols")
require("user.dap.persistent-breakpoints")
require("user.dap.dapui")

require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp", "rust" } })

require("user.dap.adapters")
require("user.dap.launch-gen")
