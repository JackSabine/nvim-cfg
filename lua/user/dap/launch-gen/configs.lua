-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

local M = {}

local configs = {
  ["c-cpp-rust"] = {
    type = "cppdbg",
    name = "Launch current C/C++/Rust file",
    request = "launch",
    args = {},
    cwd = "${workspaceFolder}",
    program = "a.out",
    stopAtEntry = true,
  },
  ["python"] = {
    type = "python",
    name = "Launch current Python file",
    request = "launch",
    args = {},
    program = "${file}",
    pythonPath = "${workspaceFolder}/.venv/bin/python",
  },
}

local configByLanguage = {
  ["c"] = configs["c-cpp-rust"],
  ["cpp"] = configs["c-cpp-rust"],
  ["rust"] = configs["c-cpp-rust"],
  ["python"] = configs["python"],
}

function M.getConfig(language)
  return configByLanguage[language]
end

return M
