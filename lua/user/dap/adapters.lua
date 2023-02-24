local dap = require("dap")

local adapter_configs = {
  cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
  },
  python = {
    type = "executable",
    command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
    args = { "-m", "debugpy.adapter" },
  },
}

for adapter, config in pairs(adapter_configs) do
  dap.adapters[adapter] = config
end
