-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

local M = {}

local function __formatJSON(data)
  local command = "echo " .. "'" .. data .. "' | prettier --parser json-stringify --tab-width 4"

  local handle = io.popen(command)
  -- assert(handle ~= nil)
  if handle == nil then
    return data
  else
    return handle:read("*a")
  end
end

local function __readLaunchJSON(resolved_path)
  -- Trim away comment lines
  local data
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

  return data
end

function M.NewLaunchConfig(path, formatOutput)
  local resolved_path = path or (vim.fn.getcwd() .. "/.vscode/launch.json")
  local resolved_fmt = formatOutput or true

  local config = require("user.dap.launch-gen.configs").getConfig(vim.bo.filetype)

  local data
  local encoded_json
  local fileOutHandle

  if config == nil then
    print("No default DAP configuration set for language " .. vim.bo.filetype)
    return
  end

  if vim.loop.fs_stat(resolved_path) then
    -- If file exists, convert its json to a lua table
    data = __readLaunchJSON(resolved_path)
  else
    -- File doesn't exist, so create an empty structure
    data = {}
    data.configurations = {}
  end

  table.insert(data.configurations, config)
  encoded_json = vim.json.encode(data)
  if resolved_fmt then
    -- vim.json.encode outputs all JSON on one line
    -- Use a formatter to make it human-readable
    encoded_json = __formatJSON(encoded_json)
  end

  fileOutHandle = io.open(resolved_path, "w")
  -- assert(fileOutHandle ~= nil)
  if fileOutHandle ~= nil then
    io.output(fileOutHandle)
    io.write(encoded_json)
    io.close(fileOutHandle)
  end
end

return M
