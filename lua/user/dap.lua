local status_ok_dap, dap = pcall(require, "dap")
if not status_ok_dap then
  return
end

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
}

for index, value in pairs(dap_symbols) do
  vim.fn.sign_define(index, value)
end

----------------------------------------
--            DAP Projects            --
----------------------------------------
local status_ok_dap_projects, dap_projects = pcall(require, "nvim-dap-projects")
if status_ok_dap_projects then
  -- nvim-dap-projects will clobber all dap.adapters data
  -- https://github.com/ldelossa/nvim-dap-projects/blob/f319ffd99c6c8a0b930bcfc4bee0c751ffbf5808/lua/nvim-dap-projects.lua#L23
  dap_projects.search_project_config()
end

-- Table of global DAP adapter configs (overridable by settings found by nvim-dap-projects)
local global_dap_adapter_configs = {
  cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
  },
}

-- If a local DAP adapter config isn't given, add the entry to dap.adapters
for key, value in pairs(global_dap_adapter_configs) do
  if dap.adapters[key] == nil then
    dap.adapters[key] = value
  end
end

----------------------------------------
--               DAPUI                --
----------------------------------------
local status_ok_dap_ui, dapui = pcall(require, "dapui")
if status_ok_dap_ui then
  dapui.setup()

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end

  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end

  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end
