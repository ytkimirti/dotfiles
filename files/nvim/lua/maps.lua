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

set({'i', 'n', 'v'}, '<esc>', '<esc><cmd>noh<cr>', {silent = true})
set({'n'}, 'i', '<cmd>noh<cr><esc>i', {silent= true})
-- I have no idea for a better approach to this, above line doesn't work
--vim.cmd('map <esc> <esc>:noh<cr>')
--vim.cmd('map i <>:noh<cr>')
--vim.cmd('map c :noh<cr>')

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

-- Insert --
keymap("i", "<S-CR>", "<ESC>o", opts) -- Newline with S-CR

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m +1<CR>==", opts)
keymap("n", "<A-k>", ":m -2<CR>==", opts)
keymap("i", "<A-j>", "<esc>:m .+1<CR>==gi", opts)
keymap("i", "<A-k>", "<esc>:m .-2<CR>==gi", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Replacing with p doesn't override the yank register
keymap("v", "p", '"_dP', opts)

-- Comment
set("n", "<C-/>", "gcc", {remap = true})
set("v", "<C-/>", "gc", {remap = true})

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
-- TODO: Fix autosave error
keymap("n", "<leader>as", "<cmd>EnableAutoSave<cr>", opts)

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


-- Gitsigns

local ok, gs = pcall(require, "gitsigns")
if not ok then return end

set('n', ']c', function()
	if vim.wo.diff then return ']c' end
	vim.schedule(function() gs.next_hunk() end)
	return '<Ignore>'
end, {expr=true})

set('n', '[c', function()
	if vim.wo.diff then return '[c' end
	vim.schedule(function() gs.prev_hunk() end)
	return '<Ignore>'
end, {expr=true})

-- Actions
set({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
set({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
set('n', '<leader>hS', gs.stage_buffer)
set('n', '<leader>hu', gs.undo_stage_hunk)
set('n', '<leader>hR', gs.reset_buffer)
set('n', '<leader>hp', gs.preview_hunk)
set('n', '<leader>hd', gs.diffthis)
set('n', '<leader>hD', function() gs.diffthis('~') end)

-- Text object
set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

