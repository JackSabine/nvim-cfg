-- :help options
local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 1,                           -- space in the neovim command line for displaying messages
  timeoutlen = 300,                        -- # ms between multi-key macros
  textwidth = 0,                           -- auto-newline at x chars
  wrap = true,                             -- prefer to wrap lines instead of trail to the right
  scrolloff = 2,                           -- # lines above/below when scrolling
  sidescrolloff = 2,                       -- # lines side to side when scrolling horizontally
  autoread = true,                         -- update buffer with external changes
  history = 200,                           -- save last 200 commands
  encoding = "utf-8",                      -- internal encoding
  fileencoding = "utf-8",                  -- encoding written to a file
  shell = bash,                            -- shell used by :! commands
  cursorline = true,                       -- highlight cursor line underneath the cursor horizontally
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = true,                         -- show things like -- INSERT --
  showtabline = 2,                         -- always show tabs
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = true,                         -- creates a swapfile
  undofile = true,                         -- enable persistent undo
  writebackup = false,                     -- if a file is being edited by another program, it is not allowed to be edited
  numberwidth = 4,                         -- set number line-number column width
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time

  termguicolors = false,                    -- use more terminal colors (colorschemes will be more accurate!)

-- Line numbers and columns
  relativenumber = true,
  number = true,
  ruler = true,

-- Better searching settings
  hlsearch = true,
  incsearch = true,
  ignorecase = true,
  smartcase = true,
  magic = true,
  showmatch = true,

-- Nobody likes bells...
  errorbells = false,
  visualbell = false,
--  t_vb = "",


-- configure backspace so it acts as it should act
  backspace = eol,start,indent,
--  t_BE= "",

-- <TAB> -> 2 spaces
  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2
}

vim.opt.shortmess:append "c"
vim.opt.iskeyword:append "-"                    -- treat - as a keyword
vim.opt.whichwrap:append "<,>,[,],h,l"

for k, v in pairs(options) do
  vim.opt[k] = v
end

