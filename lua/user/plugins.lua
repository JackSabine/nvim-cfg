local fn = vim.fn

-- Automatically install packer
--  Installs into ~/.local/share/nvim  .. <this dir vvvvv >
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Packer/plugin-related plugins
  use "wbthomason/packer.nvim"            -- Have packer manage itself
  use "nvim-lua/popup.nvim"               -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"             -- Useful lua functions used ny lots of plugins

  -- My plugins
  use 'adelarsq/vim-matchit'              -- Add more functionality to the `%` key
  use 'preservim/nerdtree'                -- Folder browser plugin
  use 'gyim/vim-boxdraw'                  -- Primitive arrow/box drawer
  use 'rpdelaney/vim-sourcecfg'           -- Syntax highlighting for TF2/CSGO config files
  use 'rstacruz/vim-closer'               -- Automatic bracket closer upon pressing `Enter`

  -- Colorschemes
  use 'tomasiser/vim-code-dark'

  -- cmp plugins
  use "hrsh7th/nvim-cmp"                  -- Completion plugin
  use "hrsh7th/cmp-buffer"                -- buffer completions
  use "hrsh7th/cmp-path"                  -- path completions
  use "hrsh7th/cmp-cmdline"               -- cmdline completions
  use "saadparwaiz1/cmp_luasnip"          -- Snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- Snippets
  use "L3MON4D3/LuaSnip"                  -- Snippet engine
  use "rafamadriz/friendly-snippets"      -- Tons of snippets

	-- LSP
  use "neovim/nvim-lspconfig"             -- enable LSP
  use "williamboman/mason.nvim"           -- simple to use language server installer
  use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)