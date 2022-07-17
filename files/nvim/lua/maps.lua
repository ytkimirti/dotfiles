local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

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


-- TODO add these
-- :set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
-- noremap <F3> :set list!<CR>
-- inoremap <F3> <C-o>:set list!<CR>
-- noremap <F3> <C-c>:set list!<CR>

-- Yank --
keymap("n", "<leader>p", '"*p', opts)
keymap("n", "<leader>P", '"*P', opts)
keymap("n", "Y", '"*y', opts)

keymap("n", "<leader>p", '"*p', opts)
keymap("n", "<leader>P", '"*P', opts)
keymap("n", "Y", '"*y', opts)

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

-- Comment

keymap("n", "<leader>/", "gcc", {noremap = true})
keymap("v", "<leader>/", "gc", {noremap = true})

-- Telescope

keymap("n", "<leader>o", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<C-p>", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", opts)
keymap("n", "<leader>gd", "<cmd>Telescope git_bcommits<cr>", opts)
keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts)

keymap("n", "<leader>f", "<cmd>Telescope lsp_document_symbols<cr>", opts)


keymap("n", "<leader>gb", "<cmd>Telescope builtin<cr>", opts) -- Ripgrep
keymap("n", "<leader>gh", "<cmd>Telescope live_grep<cr>", opts) -- Ripgrep

