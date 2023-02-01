local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

local languageservers_autoinstall = {
  "sumneko_lua",
  "pyright",
  "jsonls",
  "clangd",
}

local languageservers_noinstall = {
}

local nonlanguageservers = {
  "prettier",
  "black",
  "stylua",
  "clang-format",
  "beautysh",
}

local languageservers = {}

for i = 1, #languageservers_autoinstall do
  languageservers[i] = languageservers_autoinstall[i]
end

for i = 1, #languageservers_noinstall do
  languageservers[#languageservers_autoinstall + i] = languageservers_noinstall[i]
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
mason.setup(settings)

for _, v in pairs(nonlanguageservers) do
  if not require("mason-registry").is_installed(v) then
    vim.cmd(":MasonInstall " .. v)
  end
end

-- Specify which packages should be installed by mason-lspconfig
require("mason-lspconfig").setup({
  ensure_installed = languageservers_autoinstall,
  automatic_installation = { exclude = languageservers_noinstall },
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

-- Prepare to set up each LSP server listed in this file
for _, server in pairs(languageservers) do
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
