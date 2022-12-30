local servers_autoinstall = {
  "sumneko_lua",
  "pyright",
  "jsonls",
  "clangd",
}

local servers_noinstall = {
}

local servers = {}

for i = 1, #servers_autoinstall do
  servers[i] = servers_autoinstall[i]
end

for i = 1, #servers_noinstall do
  servers[#servers_autoinstall + i] = servers_noinstall[i]
end

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "",
      package_pending = "",
      package_uninstalled = "",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

-- Provide mason-specific settings (UI, logs)
require("mason").setup(settings)

-- Specify which packages should be installed by mason-lspconfig
require("mason-lspconfig").setup({
  ensure_installed = servers_autoinstall,
  automatic_installation = { exclude = servers_noinstall },
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

-- Prepare to set up each LSP server listed in this file
for _, server in pairs(servers) do
  -- Use generic on_attach and capabilities defined in user.lsp.handlers
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  -- Get server name only ("mylsp@nightly" -> "mylsp" OR "mylsp" -> "mylsp" (no-op))
  server = vim.split(server, "@")[1]

  -- Check if a specific user.lsp.settings.<server> file exists
  local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
  if require_ok then
    -- Given that the file exists, insert those options
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  -- Finally, call setup for the LSP
  lspconfig[server].setup(opts)
end
