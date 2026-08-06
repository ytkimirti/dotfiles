return {
	{
		'nvim-telescope/telescope.nvim',
		cmd = 'Telescope',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function() return vim.fn.executable 'make' == 1 end,
			},
			'nvim-telescope/telescope-ui-select.nvim',
		},
		keys = {
			{ '<leader>o', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
			{ '<leader>b', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
			{ '<leader>gb', '<cmd>Telescope git_branches<cr>', desc = 'Git branches' },
			{ '<leader>gs', '<cmd>Telescope git_status<cr>', desc = 'Git status' },
			{ '<leader>f', '<cmd>Telescope lsp_document_symbols<cr>', desc = 'Document symbols' },
			{ '<leader>F', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', desc = 'Workspace symbols' },
			{ '<leader>tb', '<cmd>Telescope builtin<cr>', desc = 'Telescope builtins' },
			{ '<leader>to', '<cmd>Telescope oldfiles<cr>', desc = 'Recent files' },
			{ '<leader>tg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
			{ '<leader>tm', '<cmd>Telescope marks<cr>', desc = 'Marks' },
			{ '<leader>tc', '<cmd>Telescope colorscheme<cr>', desc = 'Colorschemes' },
			{ '<leader>th', '<cmd>Telescope help_tags<cr>', desc = 'Help tags' },
			{ '<leader>tk', '<cmd>Telescope keymaps<cr>', desc = 'Keymaps' },
			{ 'gd', '<cmd>Telescope lsp_definitions<cr>', desc = 'Definitions' },
			{ '<leader>i', '<cmd>Telescope lsp_implementations<cr>', desc = 'Implementations' },
			{ '<leader>r', '<cmd>Telescope lsp_references<cr>', desc = 'References' },
		},
		opts = function()
			local actions = require 'telescope.actions'
			return {
				defaults = {
					prompt_prefix = '  ',
					selection_caret = ' ',
					path_display = { 'truncate' },
					sorting_strategy = 'ascending',
					layout_config = { prompt_position = 'top', horizontal = { preview_width = 0.55 } },
					mappings = {
						i = {
							['<C-j>'] = actions.move_selection_next,
							['<C-k>'] = actions.move_selection_previous,
							['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
							['<esc>'] = actions.close,
						},
					},
					vimgrep_arguments = {
						'rg',
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--smart-case',
						'--hidden',
						'--glob=!.git/',
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						find_command = { 'rg', '--files', '--hidden', '--glob=!.git/' },
					},
					colorscheme = { enable_preview = true },
				},
				extensions = {
					['ui-select'] = { require('telescope.themes').get_dropdown {} },
				},
			}
		end,
		config = function(_, opts)
			local telescope = require 'telescope'
			telescope.setup(opts)
			pcall(telescope.load_extension, 'fzf')
			pcall(telescope.load_extension, 'ui-select')
		end,
	},
}
