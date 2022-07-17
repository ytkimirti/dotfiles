require('lspsaga').init_lsp_saga {
	rename_action_quit = "<esc>",
	finder_action_keys = {
		open = "o",
		vsplit = "s",
		split = "i",
		tabe = "t",
		quit = { 'q', '<esc>' },
		scroll_down = "<C-f>",
		scroll_up = "<C-b>",
	},
	code_action_keys = {
		quit = {"q", '<esc>'},
		exec = "<CR>",
	},
}
