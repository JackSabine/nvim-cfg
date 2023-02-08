local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<CR>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
  -- disable the WhichKey popup for certain buf types and file types
  disable = {
    buftypes = {},
    filetypes = {},
  },
}

local leader_opts = {
  mode = "n", -- NORMAL mode
  prefix = "<Leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local leader_mappings = {
  -- ["a"] = { "<cmd>Alpha<CR>", "Alpha" },
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({previewer = false}))<CR>",
    "Buffers",
  },
  ["c"] = { '"+y', "Clipboard Yank" },
  -- d: dap
  ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
  ["E"] = { "<cmd>NvimTreeFindFile<CR>", "Find File" },
  ["f"] = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "Find Files" },
  ["F"] = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", "Find Text" },
  -- g: git
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  -- l: lsp
  -- p: packer
  -- ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<CR>", "Projects" },
  -- ["q"] = { "<cmd>q!<CR>", "Quit" },
  -- s: search
  -- t: terminal
  ["v"] = { '"+p', "Clipboard Paste" },
  ["V"] = { '"+P', "Clipboard Paste" },
  -- ["w"] = { "<cmd>w!<CR>", "Save" },
  --
  -- ["<Leader>"] = { "<Esc>", "Escape" },

  d = {
    name = "Debug",
    t = {
      "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>",
      "Toggle Breakpoint",
    },
    T = {
      "<cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint()<cr>",
      "Set Conditional Breakpoint",
    },
    x = {
      "<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>",
      "Clear All Breakpoints",
    },
    b = { "<cmd>lua require('dap').step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
    C = { "<cmd>lua require('dap').run_to_cursor()<cr>", "Run To Cursor" },
    d = { "<cmd>lua require('dap').disconnect()<cr>", "Disconnect" },
    g = { "<cmd>lua require('dap').session()<cr>", "Get Session" },
    i = { "<cmd>lua require('dap').step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require('dap').step_over()<cr>", "Step Over" },
    u = { "<cmd>lua require('dap').step_out()<cr>", "Step Out" },
    p = { "<cmd>lua require('dap').pause()<cr>", "Pause" },
    r = { "<cmd>lua require('dap').repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require('dap').continue()<cr>", "Start" },
    q = { "<cmd>lua require('dap').close()<cr>", "Quit" },
    U = { "<cmd>lua require('dapui').toggle({reset = true})<cr>", "Toggle UI" },
  },
  g = {
    name = "Git",
    -- g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require('gitsigns').next_hunk()<CR>", "Next Hunk" },
    k = { "<cmd>lua require('gitsigns').prev_hunk()<CR>", "Prev Hunk" },
    l = { "<cmd>lua require('gitsigns').blame_line({ full = false })<CR>", "Blame" },
    L = { "<cmd>lua require('gitsigns').blame_line({ full = true })<CR>", "Blame Full" },
    p = { "<cmd>lua require('gitsigns').preview_hunk()<CR>", "Preview Hunk" },
    -- r = { "<cmd>lua require('gitsigns').reset_hunk()<CR>", "Reset Hunk" },
    -- R = { "<cmd>lua require('gitsigns').reset_buffer()<CR>", "Reset Buffer" },
    -- s = { "<cmd>lua require('gitsigns').stage_hunk()<CR>", "Stage Hunk" },
    -- u = { "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", "Undo Stage Hunk" },
    o = { "<cmd>Telescope git_status<CR>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
    d = { "<cmd>Gitsigns diffthis HEAD<CR>", "Diff" },
  },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    f = { "<cmd>lua vim.lsp.buf.format({async=true})<CR>", "Format" },
    h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
    H = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
    -- i = { "<cmd>LspInfo<CR>", "Info" },
    -- I = { "<cmd>LspInstallInfo<CR>", "Installer Info" },
    j = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next Diagnostic" },
    k = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Prev Diagnostic" },
    l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
    q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    R = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
    s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols" },
    t = { "<cmd>lua ToggleFormatOnSave()<CR>", "Toggle Format on Save augroup" },
    w = { "<cmd>Telescope diagnostics bufnr=0<CR>", "Document Diagnostics" },
    W = { "<cmd>Telescope diagnostics<CR>", "Workspace Diagnostics" },
    z = {
      "<cmd>lua vim.diagnostic.open_float(0, { scope = 'line', border = 'rounded'})<CR>",
      "Diagnostic",
    },
  },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<CR>", "Compile" },
    i = { "<cmd>PackerInstall<CR>", "Install" },
    s = { "<cmd>PackerSync<CR>", "Sync" },
    S = { "<cmd>PackerStatus<CR>", "Status" },
    u = { "<cmd>PackerUpdate<CR>", "Update" },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<CR>", "Find Help" },
    M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
    R = { "<cmd>Telescope registers<CR>", "Registers" },
    k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
    C = { "<cmd>Telescope commands<CR>", "Commands" },
  },
  t = {
    name = "Terminal",
    n = { "<cmd>lua _NODE_TOGGLE()<CR>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<CR>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<CR>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<CR>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<CR>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["p"] = { '"0p', "Paste Last Yank" },
  ["P"] = { '"0P', "Paste Last Yank" },
  ["d"] = { '"_d', "Black Hole Delete" },
  ["D"] = { '"_D', "Black Hole Delete" },
  ["<C-x>"] = { "<cmd>Bdelete<CR>", "Close Buffer" },
  ["<M-x>"] = { "<cmd>Bdelete!<CR>", "Force Close Buffer" },
  ["<C-l>"] = { "<cmd>bnext<CR>", "Next Buffer" },
  ["<C-h>"] = { "<cmd>bprevious<CR>", "Prev Buffer" },
  ["<C-n>"] = {
    "<cmd>lua vim.opt.relativenumber = not(vim.opt.relativenumber:get())<CR>",
    "Toggle Relative Number",
  },
  -- <CR> is mapped in markdown files by jghauser/follow-md-links.nvim
  ["<BS>"] = { "<cmd>:edit #<CR>", "Return to previous file" },
}

which_key.setup(setup)
which_key.register(leader_mappings, leader_opts)
which_key.register(mappings, opts)
