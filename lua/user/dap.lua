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

----------------------------------------
--       Persistent Breakpoints       --
----------------------------------------
local status_ok_pbreakpt, pbreakpt = pcall(require, "persistent-breakpoints")
if status_ok_pbreakpt then
  pbreakpt.setup({
    load_breakpoints_event = { "BufReadPost" },
  })
end

----------------------------------------
--            DAP Projects            --
----------------------------------------

-- DAP Projects, by default, will look in each project's root for a lua file with one of the following name patterns:
-- ./.nvim-dap/nvim-dap.lua
-- ./.nvim-dap.lua
-- ./.nvim/nvim-dap.lua

local status_ok_dap_projects, dap_projects = pcall(require, "nvim-dap-projects")
if status_ok_dap_projects then
  -- nvim-dap-projects will clobber all dap.adapters data
  -- https://github.com/ldelossa/nvim-dap-projects/blob/f319ffd99c6c8a0b930bcfc4bee0c751ffbf5808/lua/nvim-dap-projects.lua#L23
  dap_projects.search_project_config()
end

-- DAP adapter configs
-- These can be overriden with settings found by nvim-dap-projects
local global_dap_adapter_configs = {
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

-- TODO:
-- Auto-generate/append to dictionary if possible
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

local function formatJSON(data)
  local command = "echo " .. "'" .. data .. "' | prettier --parser json-stringify --tab-width 4"

  local handle = io.popen(command)
  assert(handle ~= nil)
  return handle:read("*a")
end

function NewLaunchConfig(path, formatOutput)
  local resolved_path = path or (vim.fn.getcwd() .. "/launch.json")
  local resolved_fmt = formatOutput or true
  local data
  local config = {
    foobar = "hello",
  }

  -- Check if file already exists
  if vim.loop.fs_stat(resolved_path) then
    -- If file exists, parse it and convert the JSON structure to a table

    -- Insert non-comment lines to a string array `lines`
    local lines = {}
    for line in io.lines(resolved_path) do
      if not vim.startswith(vim.trim(line), "//") then
        table.insert(lines, line)
      end
    end

    -- Convert string array to a newline-delimited string
    local contents = table.concat(lines, "\n")
    if contents ~= "" then
      -- Convert string to table
      data = vim.json.decode(contents)
    end

    if data == nil or data == vim.NIL then
      data = {}
    end

    if data.configurations == nil then
      data.configurations = {}
    end
  else
    -- File doesn't exist, so create an empty structure
    data = {}
    data.configurations = {}
  end

  -- Add a pre-determined config to the table
  table.insert(data.configurations, config)
  local json = vim.json.encode(data)
  if resolved_fmt then
    json = formatJSON(json)
  end

  local outfile = io.open(resolved_path, "w")
  assert(outfile ~= nil)
  io.output(outfile)
  io.write(json)
  io.close(outfile)
end
