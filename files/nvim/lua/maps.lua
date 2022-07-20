local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap
local set = vim.keymap.set

keymap("", "C-c", "<ESC>", opts) -- C-c same as ESC

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
-- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

vim.cmd('set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<')
set('n', '<F3>', '<esc><cmd>set list!<cr>', {})
set('i', '<F3>', '<C-o><cmd>set list!<cr>', {})

-- Yank --
set("n", "<leader>p", '"*p', {})
set("n", "<leader>P", '"*P', {})
set("n", "Y", '"*y', {})

set("v", "<leader>p", '"*p', {})
set("v", "<leader>P", '"*P', {})
set("v", "Y", '"*y', {})

-- Resizing --
keymap("n", "<M-Up>", ":resize -2<CR>", opts)
keymap("n", "<M-Down>", ":resize +2<CR>", opts)
keymap("n", "<M-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<M-Right>", ":vertical resize +2<CR>", opts)

keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
-- Navigate buffers

keymap("n", "<A-j>", ":m +1<CR>==", opts)
keymap("n", "<A-k>", ":m -2<CR>==", opts)

-- Insert --
keymap("i", "<S-CR>", "<ESC>o", opts) -- Newline with S-CR

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Comment (doesn't work for some reason?!?!?)

set("n", "<C-/>", "gcc", {})
set("v", "<C-/>", "gc", {})

-- Telescope

keymap("n", "<leader>o", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>b", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<C-p>", "<cmd>Telescope find_files<cr>", opts)

keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", opts)
keymap("n", "<leader>gd", "<cmd>Telescope git_bcommits<cr>", opts)
keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts)
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", opts)

keymap("n", "<leader>f", "<cmd>Telescope lsp_document_symbols<cr>", opts)


keymap("n", "<leader>tb", "<cmd>Telescope builtin<cr>", opts)
keymap("n", "<leader>to", "<cmd>Telescope old_files<cr>", opts)
keymap("n", "<leader>tg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>tm", "<cmd>Telescope marks<cr>", opts)

-- Custom
keymap("n", "<leader>as", "<cmd>EnableAutoSave<cr>", opts) -- Ripgrep
keymap("n", "<leader>h", "<cmd>nop<cr>", opts)

-- Nvimtree
keymap("n", "<C-n>", "<cmd>NvimTreeFocus<cr>", opts)

-- Float term

local term = require("lspsaga.floaterm")

-- float terminal also you can pass the cli command in open_float_terminal function
vim.keymap.set("n", "<A-d>", function()
    term.open_float_terminal()
end, { silent = true,noremap = true })
vim.keymap.set("t", "<A-d>", function()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true))
    term.close_float_terminal()
end, { silent = true })


