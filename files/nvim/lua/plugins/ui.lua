return {
	{ 'nvim-tree/nvim-web-devicons', lazy = true },

	{
		'nvim-lualine/lualine.nvim',
		event = 'VeryLazy',
		opts = {
			options = {
				theme = 'gruvbox',
				globalstatus = true,
				section_separators = '',
				component_separators = '|',
			},
			sections = {
				lualine_c = { { 'filename', path = 1 } },
				lualine_x = { 'diagnostics', 'filetype' },
			},
		},
	},

	{
		-- Replaces ap/vim-buftabline. <C-h>/<C-l> still cycle buffers.
		'akinsho/bufferline.nvim',
		event = 'VeryLazy',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			options = {
				diagnostics = 'nvim_lsp',
				show_close_icon = false,
				show_buffer_close_icons = false,
				offsets = {
					{ filetype = 'NvimTree', text = 'Files', highlight = 'Directory' },
				},
			},
		},
	},

	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		opts = {
			preset = 'helix',
			delay = 400,
			spec = {
				{ '<leader>t', group = 'telescope' },
				{ '<leader>h', group = 'git hunk' },
				{ '<leader>g', group = 'git' },
				{ '<leader>x', group = 'diagnostics' },
				{ '<leader>l', group = 'lsp' },
			},
		},
		keys = {
			{ '<leader>?', function() require('which-key').show { global = false } end, desc = 'Buffer keymaps' },
		},
	},

	{
		'j-hui/fidget.nvim',
		event = 'LspAttach',
		opts = {
			notification = { window = { winblend = 0 } },
		},
	},

	{ 'dstein64/vim-startuptime', cmd = 'StartupTime' },
}
