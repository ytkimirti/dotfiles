local function augroup(name)
	return vim.api.nvim_create_augroup('user_' .. name, { clear = true })
end

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
	group = augroup 'highlight_yank',
	callback = function() (vim.hl or vim.highlight).on_yank { timeout = 150 } end,
})

-- Highlight the 81st character of any line that runs past 80.
-- The old version used the highlight group "ColorColumnu" (typo) and ran once
-- at startup, so it only ever applied to the very first window.
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinNew' }, {
	group = augroup 'overlength',
	callback = function()
		if vim.w.overlength_match then return end
		local ok, id = pcall(vim.fn.matchadd, 'ColorColumn', [[\%81v]], 100)
		if ok then vim.w.overlength_match = id end
	end,
})

-- Jump back to the last cursor position when reopening a file
vim.api.nvim_create_autocmd('BufReadPost', {
	group = augroup 'last_position',
	callback = function(ev)
		if vim.b[ev.buf].last_position_restored then return end
		vim.b[ev.buf].last_position_restored = true
		if vim.bo[ev.buf].filetype:match 'commit' then return end
		local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
		if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(ev.buf) then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Equalize splits when the terminal is resized
vim.api.nvim_create_autocmd('VimResized', {
	group = augroup 'resize_splits',
	callback = function()
		local tab = vim.api.nvim_get_current_tabpage()
		vim.cmd 'tabdo wincmd ='
		vim.api.nvim_set_current_tabpage(tab)
	end,
})

-- q closes scratch/help style windows
vim.api.nvim_create_autocmd('FileType', {
	group = augroup 'close_with_q',
	pattern = {
		'help',
		'man',
		'qf',
		'lspinfo',
		'checkhealth',
		'startuptime',
		'fugitive',
		'gitsigns-blame',
		'query',
	},
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
		vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = ev.buf, silent = true })
	end,
})

-- Create missing parent directories on :w
vim.api.nvim_create_autocmd('BufWritePre', {
	group = augroup 'auto_mkdir',
	callback = function(ev)
		if ev.match:match '^%w%w+://' then return end
		local file = vim.uv.fs_realpath(ev.match) or ev.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
	end,
})

-- Terminal buffers don't want line numbers or a sign column
vim.api.nvim_create_autocmd('TermOpen', {
	group = augroup 'terminal',
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = 'no'
	end,
})
