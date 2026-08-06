return {
	{
		-- Was pinned to a commit from 2022 for reasons lost to history.
		'lewis6991/gitsigns.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		opts = {
			signs = {
				add = { text = '▎' },
				change = { text = '▎' },
				delete = { text = '' },
				topdelete = { text = '' },
				changedelete = { text = '▎' },
				untracked = { text = '▎' },
			},
			on_attach = function(bufnr)
				local gs = require 'gitsigns'
				local function map(mode, lhs, rhs, desc, extra)
					local o = { buffer = bufnr, silent = true, desc = desc }
					if extra then o = vim.tbl_extend('force', o, extra) end
					vim.keymap.set(mode, lhs, rhs, o)
				end

				-- expr maps so ]c / [c keep their built-in meaning in diff mode
				map('n', ']c', function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function() gs.nav_hunk 'next' end)
					return '<Ignore>'
				end, 'Next hunk', { expr = true })

				map('n', '[c', function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.nav_hunk 'prev' end)
					return '<Ignore>'
				end, 'Previous hunk', { expr = true })

				map({ 'n', 'v' }, '<leader>hs', '<cmd>Gitsigns stage_hunk<cr>', 'Stage hunk')
				map({ 'n', 'v' }, '<leader>hr', '<cmd>Gitsigns reset_hunk<cr>', 'Reset hunk')
				map('n', '<leader>hS', gs.stage_buffer, 'Stage buffer')
				map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo stage hunk')
				map('n', '<leader>hR', gs.reset_buffer, 'Reset buffer')
				map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
				map('n', '<leader>hb', function() gs.blame_line { full = true } end, 'Blame line')
				map('n', '<leader>hd', gs.diffthis, 'Diff this')
				map('n', '<leader>hD', function() gs.diffthis '~' end, 'Diff against HEAD~')
				map({ 'o', 'x' }, 'ih', '<cmd>Gitsigns select_hunk<cr>', 'Select hunk')
			end,
		},
	},

	{
		'tpope/vim-fugitive',
		cmd = { 'G', 'Git', 'Gdiffsplit', 'Gread', 'Gwrite', 'Glog', 'Gblame' },
		keys = {
			{ '<leader>gg', '<cmd>Git<cr>', desc = 'Fugitive status' },
		},
	},
}
