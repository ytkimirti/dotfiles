return {
	{
		-- ellisonleao/gruvbox.nvim is the maintained Lua port. morhetz/gruvbox
		-- (the old vimscript one) has been unmaintained since 2021.
		'ellisonleao/gruvbox.nvim',
		lazy = false,
		priority = 1000,
		opts = {
			contrast = 'medium', -- "hard" | "" | "soft"
			bold = false,
			italic = {
				strings = false,
				comments = true,
				folds = true,
				emphasis = true,
				operators = false,
			},
			terminal_colors = true,
			transparent_mode = false, -- flip to true to let the terminal bg show through
		},
		config = function(_, opts)
			require('gruvbox').setup(opts)
			vim.cmd.colorscheme 'gruvbox'
		end,
	},
}
