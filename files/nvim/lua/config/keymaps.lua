local set = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ---------------------------------------------------------------- basics ---

set('', '<C-c>', '<ESC>', { remap = true, silent = true })

-- Swap ; and : so commands are one keypress
set({ 'n', 'v' }, ';', ':', { noremap = true, silent = false })
set({ 'n', 'v' }, ':', ';', { noremap = true, silent = false })
set('i', '<C-;>', '<esc>:', opts)
set('n', '<C-;>', ':', { silent = false })

-- Clear search highlight. `i` is an <expr> map so a count still works (3iX<Esc>
-- inserts XXX) -- the old `<cmd>noh<cr><esc>i` version silently ate the count.
set('n', '<Esc>', '<cmd>nohlsearch<cr>', opts)
set('n', 'i', function()
	vim.schedule(function() vim.cmd.nohlsearch() end)
	return 'i'
end, { expr = true })

-- Show whitespace
set('n', '<F3>', '<cmd>set list!<cr>', opts)
set('i', '<F3>', '<C-o><cmd>set list!<cr>', opts)

-- Home row line ends
set({ 'n', 'v', 'o' }, 'H', '^', opts)
set({ 'n', 'v', 'o' }, 'L', '$', opts)

-- Quick throw-away macro replay
set('n', 'Q', '@q', opts)

set('n', '<leader>cd', '<cmd>cd %:p:h<cr>', opts)

-- ------------------------------------------------------------- clipboard ---

set({ 'n', 'v' }, '<leader>p', '"*p', opts)
set({ 'n', 'v' }, '<leader>P', '"*P', opts)
set({ 'n', 'v' }, 'Y', '"*y', opts)

-- Paste over a selection without clobbering the yank register
set('v', 'p', '"_dP', opts)

-- --------------------------------------------------------------- windows ---

set('n', '<M-Up>', '<cmd>resize -2<cr>', opts)
set('n', '<M-Down>', '<cmd>resize +2<cr>', opts)
set('n', '<M-Left>', '<cmd>vertical resize -2<cr>', opts)
set('n', '<M-Right>', '<cmd>vertical resize +2<cr>', opts)

set('n', '<C-l>', '<cmd>bnext<cr>', opts)
set('n', '<C-h>', '<cmd>bprevious<cr>', opts)

set('t', '<esc>', '<C-\\><C-n>', opts)

-- ---------------------------------------------------------------- insert ---

set('i', '<S-CR>', '<ESC>o', opts)
set('i', '<A-S-CR>', '<ESC>O', opts)
set('i', '<C-l>', '<del>', opts)
set('i', '<C-z>', '<C-o>u', opts)

-- Break the undo sequence before a register paste so it can be undone alone
set('i', '<C-r>', '<C-g>u<C-r>', opts)

set({ 'i', 'c' }, '<A-k>', '<Up>')
set({ 'i', 'c' }, '<A-j>', '<Down>')
set({ 'i', 'c' }, '<A-h>', '<Left>')
set({ 'i', 'c' }, '<A-l>', '<Right>')

set('i', '<A-w>', '<C-o>w', opts)
set('i', '<A-e>', '<esc>ea', opts)
set('i', '<A-b>', '<C-o>b', opts)
set('i', '<A-S-w>', '<C-o>W', opts)
set('i', '<A-S-e>', '<esc>Ea', opts)
set('i', '<A-S-b>', '<C-o>B', opts)
set('i', '<A-4>', '<C-o>$', opts)
set('i', '<A-0>', '<C-o>0', opts)

-- Line surgery without leaving insert
set('i', '<C-f>o', '<esc>m9o<esc>kO<esc>`9a', opts)
set('i', '<C-f>j', '<esc>m9jdd`9a', opts)
set('i', '<C-f>k', '<esc>m9kdd`9a', opts)
set('i', '<C-f>J', '<esc>m9o<esc>`9a', opts)
set('i', '<C-f>K', '<esc>m9O<esc>`9a', opts)

-- ---------------------------------------------------------------- visual ---

set('v', '<', '<gv', opts)
set('v', '>', '>gv', opts)

set('n', '<A-j>', '<cmd>m +1<cr>==', opts)
set('n', '<A-k>', '<cmd>m -2<cr>==', opts)
set('v', '<A-j>', ":m '>+1<cr>gv=gv", opts)
set('v', '<A-k>', ":m '<-2<cr>gv=gv", opts)

-- gc/gcc are built in since Nvim 0.10, no comment plugin needed
set('n', '<C-/>', 'gcc', { remap = true })
set('v', '<C-/>', 'gc', { remap = true })
-- Some terminals send <C-_> for ctrl+/
set('n', '<C-_>', 'gcc', { remap = true })
set('v', '<C-_>', 'gc', { remap = true })

-- ----------------------------------------------------------- text objects ---
-- Right-hand-side keys for the pairs you actually type, so vi<key> stays on
-- the home row instead of reaching for ", ' or (.

local pairs_map = {
	m = '"',
	n = "'",
	j = '(',
	u = 'B', -- iB / aB == inside / around { }
}

for key, char in pairs(pairs_map) do
	set('x', 'i' .. key, '<cmd>normal! i' .. char .. '<cr>', opts)
	set('o', 'i' .. key, '<cmd>normal vi' .. char .. '<cr>', opts)
	set('x', 'a' .. key, '<cmd>normal! a' .. char .. '<cr>', opts)
	set('o', 'a' .. key, '<cmd>normal va' .. char .. '<cr>', opts)
end

-- ----------------------------------------------------------- diagnostics ---
-- ] goes forward, [ goes backward -- the old config had these two swapped.
-- vim.diagnostic.goto_next/goto_prev are deprecated and removed in 0.14.

set('n', ']e', function() vim.diagnostic.jump { count = 1, float = true } end, opts)
set('n', '[e', function() vim.diagnostic.jump { count = -1, float = true } end, opts)
set('n', ']E', function()
	vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR, float = true }
end, opts)
set('n', '[E', function()
	vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR, float = true }
end, opts)
set('n', '<leader>d', vim.diagnostic.open_float, opts)
