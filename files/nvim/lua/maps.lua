local opts = { noremap = true, silent = true }
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

set({'n', 'v'}, ';', ':', {remap = false, silent = false})
set({'n', 'v'}, ':', ';', {remap = false, silent = false})

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
set("i", "<A-S-CR>", "<ESC>O", opts) -- Newline with S-CR
set("i", "<C-l>", "<del>", opts)
set("i", "<C-;>", "<esc>:", opts)
set("n", "<C-;>", ":", {silent = false})

set({"i", "c"}, "<A-k>", "<Up>")
set({"i", "c"}, "<A-j>", "<Down>")
set({"i", "c"}, "<A-h>", "<Left>")
set({"i", "c"}, "<A-l>", "<Right>")

set("i", "<C-f>o", "<esc>m9o<esc>kO<esc>`9a", opts)

set("i", "<C-f>j", "<esc>m9jdd`9a", opts)
set("i", "<C-f>k", "<esc>m9kdd`9a", opts)
set("i", "<C-f>J", "<esc>m9o<esc>`9a", opts)
set("i", "<C-f>K", "<esc>m9O<esc>`9a", opts)

set("i", "<C-z>", "<C-o>u", opts)

-- Make sure C-R breaks the undo so you can
-- undo just the pasting
set("i", "<C-r>", "<C-g>u<C-r>", opts)

-- Some default vim inser mode mapping
-- C-W delete before cursor
-- C-T C-D [t]ab and [d]el tab
-- C-U delete line before cursor completely
-- C-U delete line before

set("i", "<A-w>", "<C-o>w", opts)
set("i", "<A-e>", "<esc>ea", opts)
set("i", "<A-b>", "<C-o>b", opts)
set("i", "<A-S-w>", "<C-o>W", opts)
set("i", "<A-S-e>", "<esc>Ea", opts)
set("i", "<A-S-b>", "<C-o>B", opts)

set("i", "<A-4>", "<C-o>$", opts)
set("i", "<A-0>", "<C-o>0", opts)



-- Visual --
-- Stay in indent mode
set("v", "<", "<gv", opts)
set("v", ">", ">gv", opts)

-- Move text up and down
set("n", "<A-j>", ":m +1<CR>==", opts)
set("n", "<A-k>", ":m -2<CR>==", opts)
-- set("i", "<A-j>", "<esc>:m .+1<CR>==gi", opts)
-- set("i", "<A-k>", "<esc>:m .-2<CR>==gi", opts)
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

set("n", "<leader>e", '<cmd>edit term://bash<cr>', opts)
set("t", "<esc>", "<C-\\><C-n>", opts)

-- Custom

set('n', '<leader>hh', '<cmd>EcoleHeader<cr>', opts)

-- Nvimtree
set("n", "<C-n>", "<cmd>NvimTreeFocus<cr>", opts)

-- -- Float term
-- local term = require("lspsaga.floaterm")
--
-- -- float terminal also you can pass the cli command in open_float_terminal function
-- set("n", "<A-d>", function()
--     term.open_float_terminal()
-- end, { silent = true,noremap = true })
-- set("t", "<A-d>", function()
--     vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true))
--     term.close_float_terminal()
-- end, { silent = true })


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
set({'n', 'v'}, '<leader>hs', '<cmd>Gitsigns stage_hunk<cr>')
set({'n', 'v'}, '<leader>hr', '<cmd>Gitsigns reset_hunk<cr>')
set('n', '<leader>hS', gs.stage_buffer)
set('n', '<leader>hu', gs.undo_stage_hunk)
set('n', '<leader>hR', gs.reset_buffer)
set('n', '<leader>hp', gs.preview_hunk)
set('n', '<leader>hd', gs.diffthis)
set('n', '<leader>hD', function() gs.diffthis('~') end)


-- Text object
set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
