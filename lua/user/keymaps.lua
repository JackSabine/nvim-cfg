local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Aliasing property
local keymap = vim.api.nvim_set_keymap

-- Remap comma as leader key
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

-- Resize pane with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

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
