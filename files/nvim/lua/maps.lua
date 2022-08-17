local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local set = vim.keymap.set

set("", "<C-c>", "<ESC>", {remap = true, silent = true}) -- C-c same as ESC

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
-- set("n", "<C-h>", "<C-w>h", opts)
-- set("n", "<C-j>", "<C-w>j", opts)
-- set("n", "<C-k>", "<C-w>k", opts)
-- set("n", "<C-l>", "<C-w>l", opts)

set('n', ';', ':', {remap = false, silent = false})
set('n', ':', ';', {remap = false, silent = false})

vim.cmd('set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<')
set('n', '<F3>', '<esc><cmd>set list!<cr>', {})
set('i', '<F3>', '<C-o><cmd>set list!<cr>', {})

set({'i', 'n', 'v'}, '<esc>', '<esc><cmd>noh<cr>', {silent = true})
set({'n'}, 'i', '<cmd>noh<cr><esc>i', {silent= true})

-- Yank --
set("n", "<leader>p", '"*p', opts)
set("n", "<leader>P", '"*P', opts)
set("n", "Y", '"*y', opts)

set("v", "<leader>p", '"*p', opts)
set("v", "<leader>P", '"*P', opts)
set("v", "Y", '"*y', opts)

-- Resizing --
set("n", "<M-Up>", ":resize -2<CR>", opts)
set("n", "<M-Down>", ":resize +2<CR>", opts)
set("n", "<M-Left>", ":vertical resize -2<CR>", opts)
set("n", "<M-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
set("n", "<S-l>", ":bnext<CR>", opts)
set("n", "<S-h>", ":bprevious<CR>", opts)

-- Insert --
set("i", "<S-CR>", "<ESC>o", opts) -- Newline with S-CR

-- Visual --
-- Stay in indent mode
set("v", "<", "<gv", opts)
set("v", ">", ">gv", opts)

-- Move text up and down
set("n", "<A-j>", ":m +1<CR>==", opts)
set("n", "<A-k>", ":m -2<CR>==", opts)
set("i", "<A-j>", "<esc>:m .+1<CR>==gi", opts)
set("i", "<A-k>", "<esc>:m .-2<CR>==gi", opts)
set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Replacing with p doesn't override the yank register
set("v", "p", '"_dP', opts)

-- Comment
set("n", "<C-/>", "gcc", {remap = true})
set("v", "<C-/>", "gc", {remap = true})

-- Telescope

set("n", "<leader>o", "<cmd>Telescope find_files<cr>", opts)
set("n", "<leader>b", "<cmd>Telescope buffers<cr>", opts)

set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", opts)
set("n", "<leader>f", "<cmd>Telescope lsp_document_symbols<cr>", opts)
set("n", "<leader>F", "<cmd>Telescope lsp_workspace_symbols<cr>", opts)

set("n", "<leader>tb", "<cmd>Telescope builtin<cr>", opts)
set("n", "<leader>to", "<cmd>Telescope oldfiles<cr>", opts)
set("n", "<leader>tg", "<cmd>Telescope live_grep<cr>", opts)
set("n", "<leader>tm", "<cmd>Telescope marks<cr>", opts)

-- Custom

set('n', '<leader>hh', '<cmd>EcoleHeader<cr>', opts)

-- TODO: Fix autosave error
set("n", "<leader>as", "<cmd>EnableAutoSave<cr>", opts)

-- Nvimtree
set("n", "<C-n>", "<cmd>NvimTreeFocus<cr>", opts)

-- Float term
local term = require("lspsaga.floaterm")

-- float terminal also you can pass the cli command in open_float_terminal function
set("n", "<A-d>", function()
    term.open_float_terminal()
end, { silent = true,noremap = true })
set("t", "<A-d>", function()
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

