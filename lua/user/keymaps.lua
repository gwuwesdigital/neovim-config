local opts = { noremap = true, silent = true }

local expr_opts = { expr = true, noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Managing copy and pasting using register
keymap("x", "<leader>p", [["_dP]], opts)
keymap("", "<leader>y", [["+y]], opts)
keymap("n", "<leader>Y", [["+Y]], opts)
keymap("", "<leader>d", [["_d]], opts)

-- Disable Ctrl+f and Ctrl+b to scroll full screen
keymap("", "<C-f>", "<Nop>", opts)
keymap("", "<C-b>", "<Nop>", opts)

-- Disable Shift+K to open document
keymap("n", "K", "<Nop>", opts)

-- Disable jumping to the next occurrence when matching current word
keymap("n", "*", "<cmd>keepjumps normal! mi*`i<cr>", opts)

-- Navigate inside a buffer
keymap("n", "J", "mzJ`z", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "''", "''zz", opts)
keymap("n", "'y", "'yzz", opts)
keymap("n", "'h", "'hzz", opts)
keymap("n", "'n", "'nzz", opts)
keymap("n", "``", "``zz", opts)
keymap("n", "`y", "`yzz", opts)
keymap("n", "`h", "`hzz", opts)
keymap("n", "`n", "`nzz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Turn Markdown Previewer On/Off
keymap("", "<F6>", "<Plug>MarkdownPreview", opts)
keymap("", "<F7>", "<Plug>MarkdownPreviewStop", opts)

-- Visual --
-- Move commands up and down with J and K
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
