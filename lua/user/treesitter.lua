local configs = require("nvim-treesitter.configs")

configs.setup {
  -- A list of parser names or "all"
  ensure_installed = "all",

  -- Installs parsers synchronously (only applies to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "" },

  -- Allow nvim-autopairs to hook into treesitter
  autopairs = {
    enable = true
  },

  highlight = {
    -- false will disable the whole extension
    enable = true,

    -- Disable treesitter for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB (can be whatever we want)
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      else
        return false
      end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,

  },
  indent = { enable = true, disable = { "yaml" } },

  -- rainbow = {
  --   enable = true,
  --   -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
  --   extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  --   max_file_lines = nil, -- Do not enable for files with more than n lines, int
  --   -- colors = {}, -- table of hex strings
  --   -- termcolors = {} -- table of colour name strings
  -- },

  -- We are using numToStr/Comment.nvim and integrating with treesitter, so follow this guide
  -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring#commentnvim
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
