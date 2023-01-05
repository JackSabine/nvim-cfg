local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

-- Lualine has sections as shown below.

-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+

-- Each sections holds its components e.g. Vim's current mode.

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
}

local spaces = function()
  return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "codedark",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      "NvimTree",
      "TelescopePrompt",
      "packer",
      "toggleterm",
      "alpha",
      "dapui_watches",
      "dapui_breakpoints",
      "dapui_scopes",
      "dapui_console",
      "dapui_stacks",
      "dap-repl"
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { branch },
    lualine_c = { diagnostics, "diff", "filename" },
    lualine_x = { spaces, "encoding", filetype },
    lualine_y = { "progress" },
    lualine_z = { "location" }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
})
