local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Aliasing property
local keymap = vim.api.nvim_set_keymap

-- Remap comma as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Modes
--   n: normal_mode
--   i: insert_mode
--   v: visual_mode
--   x: visual_block_mode
--   t: term_mode
--   c: command_mode

------------------
--    Normal    --
------------------

-- Better pane navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize pane with arrows
keymap("n", "<C-Up>",     ":resize -2<CR>", opts)
keymap("n", "<C-Down>",   ":resize +2<CR>", opts)
keymap("n", "<C-Left>",   ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>",  ":vertical resize +2<CR>", opts)

-- Copy/Paste to system register (X11 clipboard)
keymap("n", "<Leader>c", '"+y', opts)
keymap("n", "<Leader>v", '"+p', opts)
keymap("n", "<Leader>V", '"+P', opts)

-- Paste from yank instead of volatile register
keymap("n", "<Leader>p", "\"0p", opts)
keymap("n", "<Leader>P", "\"0P", opts)

-- Close current buffer
keymap("n", "<C-x>", ":Bdelete<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)
keymap("n", "<S-h>", "<cmd>bprevious<CR>", opts)

-- Quick nohighlight mapping
keymap("n", "<Leader>h", ":noh<CR>", opts)

-- Replace words with content of yank register
keymap("n", "<Leader>rw", "diw\"0P", opts)
keymap("n", "<Leader>rW", "diW\"0P", opts)

-- nvim-tree binds
keymap("n", "<Leader>t", ":NvimTreeToggle<CR>", opts)
keymap("n", "<Leader>f", ":NvimTreeFindFile<CR>", opts)

-- Telescope binds
keymap("n", "<C-t>", "<cmd>lua require('telescope.builtin').find_files({hidden=true})<CR>", opts)
keymap("n", "<M-t>", "<cmd>lua require('telescope.builtin').resume()<CR>", opts)
keymap("n", "<C-g>", "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)

-- Switch between tabs
keymap("n", "<Leader>.", ":tabp<CR>", opts)
keymap("n", "<Leader>/", ":tabn<CR>", opts)

-- Add line above or below the cursor
keymap("n", "oo", "o<Esc>", opts)
keymap("n", "OO", "O<Esc>", opts)

-- Faster scrolling in normal
keymap("n", "<C-e>", "4<C-e>", opts)
keymap("n", "<C-y>", "4<C-y>", opts)

-- Use regex characters whenever searching (very magic)
keymap("n", "/", "/\\v", opts)

-- Center the pattern search in the buffer
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

-- Toggle between relative and absolute numbers
function NumberToggle()
  if vim.opt.relativenumber:get() then
    vim.opt.relativenumber = false
  else
    vim.opt.relativenumber = true
  end
end

keymap("n", "<C-n>", "<cmd>lua NumberToggle()<CR>", opts)

------------------
--    Insert    --
------------------

-- Two commas -> <Esc>
keymap("i", "<Leader>,", "<Esc>", opts)

------------------
--    Visual    --
------------------

-- Two commas -> <Esc>
keymap("v", "<Leader>,", "<Esc>", opts)

-- Faster scrolling in visual
keymap("v", "<C-e>", "4<C-e>", opts)
keymap("v", "<C-y>", "4<C-y>", opts)

-- Stay in indent mode when changing block indentation
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- When pasting over other text, put deleted text in black hole reg
keymap("v", "p", '"_dP', opts)

------------------
-- Visual Block --
------------------

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Paste from yank instead of volatile register
keymap("x", "<Leader>p", '"0p', opts)
keymap("x", "<Leader>P", '"0P', opts)

-- Faster scrolling in visual block
keymap("x", "<C-e>", "4<C-e>", opts)
keymap("x", "<C-y>", "4<C-y>", opts)

------------------
--   Terminal   --
------------------

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

function Set_LSP_Keymaps(bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gl",
    '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "rounded"})<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

  Set_Format_Keymap(bufnr)
end

function Set_Format_Keymap(bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-f>", "<cmd>lua vim.lsp.buf.format({async=true})<CR>", opts)
end

function Set_Gitsigns_Keyamps(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, options)
    options = options or {}
    options.buffer = bufnr
    vim.keymap.set(mode, l, r, options)
  end

  -- Navigation
  map('n', ']c', function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end, { expr = true })

  map('n', '[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end, { expr = true })

  -- Actions
  -- map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
  -- map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
  -- map('n', '<leader>hS', gs.stage_buffer)
  -- map('n', '<leader>hu', gs.undo_stage_hunk)
  -- map('n', '<leader>hR', gs.reset_buffer)
  map('n', '<leader>hp', gs.preview_hunk)
  map('n', '<leader>hb', function() gs.blame_line { full = false } end)
  map('n', '<leader>hB', function() gs.blame_line { full = true } end)
  -- map('n', '<leader>tb', gs.toggle_current_line_blame)
  map('n', '<leader>hd', gs.diffthis)
  map('n', '<leader>hD', function() gs.diffthis('~') end)
  -- map('n', '<leader>td', gs.toggle_deleted)

  -- Text object
  map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end
