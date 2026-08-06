return {
	{ 'nvim-lua/plenary.nvim', lazy = true },

	{ 'tpope/vim-surround', event = 'VeryLazy' },

	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		opts = { check_ts = true },
	},

	{
		'nvim-tree/nvim-tree.lua',
		cmd = { 'NvimTreeFocus', 'NvimTreeToggle', 'NvimTreeFindFile', 'NvimTreeFindFileToggle' },
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		keys = {
			{ '<C-n>', '<cmd>NvimTreeFocus<cr>', desc = 'File tree' },
			{ '<leader>n', '<cmd>NvimTreeFindFileToggle<cr>', desc = 'Reveal file in tree' },
		},
		opts = {
			respect_buf_cwd = true,
			sync_root_with_cwd = true,
			sort = { sorter = 'case_sensitive' },
			view = { adaptive_size = true },
			renderer = { group_empty = true },
			filters = { dotfiles = false, git_ignored = false },
			update_focused_file = { enable = true },
		},
		init = function()
			-- nvim-tree wants netrw gone before it loads
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
	},

	{
		-- harpoon2 is the maintained branch; the old harpoon.mark / harpoon.ui
		-- API on master is dead.
		'ThePrimeagen/harpoon',
		branch = 'harpoon2',
		dependencies = { 'nvim-lua/plenary.nvim' },
		keys = function()
			local keys = {
				{ '<leader>a', function() require('harpoon'):list():add() end, desc = 'Harpoon add' },
				{
					'<leader>e',
					function()
						local h = require 'harpoon'
						h.ui:toggle_quick_menu(h:list())
					end,
					desc = 'Harpoon menu',
				},
			}
			for i = 1, 4 do
				table.insert(keys, {
					'<leader>' .. i,
					function() require('harpoon'):list():select(i) end,
					desc = 'Harpoon file ' .. i,
				})
			end
			return keys
		end,
		config = function() require('harpoon'):setup {} end,
	},
}
