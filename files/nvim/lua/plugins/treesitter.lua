-- nvim-treesitter's `master` branch is frozen (it only exists for Nvim 0.11
-- backwards compatibility). `main` is the rewrite and requires Nvim 0.12+,
-- which is what we're on. The two branches share no API.

local ENSURE = {
	'bash',
	'c',
	'css',
	'diff',
	'dockerfile',
	'fish',
	'git_config',
	'git_rebase',
	'gitcommit',
	'gitignore',
	'go',
	'gomod',
	'html',
	'javascript',
	'jsdoc',
	'json', -- jsonc has no parser of its own, it reuses this one
	'lua',
	'luadoc',
	'make',
	'markdown',
	'markdown_inline',
	'python',
	'query',
	'regex',
	'rust',
	'toml',
	'tsx',
	'typescript',
	'vim',
	'vimdoc',
	'yaml',
}

local function installed_parsers()
	local set = {}
	local dir = vim.fn.stdpath 'data' .. '/site/parser'
	local ok, iter = pcall(vim.fs.dir, dir)
	if not ok then return set end
	for name in iter do
		set[(name:gsub('%.%w+$', ''))] = true
	end
	return set
end

return {
	{
		'nvim-treesitter/nvim-treesitter',
		branch = 'main',
		lazy = false,
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter').setup {
				install_dir = vim.fn.stdpath 'data' .. '/site',
			}

			-- Only reach for the network when something is actually missing.
			-- The `main` branch shells out to the tree-sitter CLI to compile
			-- parsers (`master` used cc directly), so bail out loudly rather
			-- than emitting one ENOENT per parser.
			local have = installed_parsers()
			local missing = vim.tbl_filter(function(p) return not have[p] end, ENSURE)
			if #missing > 0 then
				if vim.fn.executable 'tree-sitter' == 0 then
					vim.schedule(function()
						vim.notify(
							('nvim-treesitter: %d parsers missing but the `tree-sitter` CLI is not on $PATH.\nInstall it with: brew install tree-sitter-cli'):format(#missing),
							vim.log.levels.WARN
						)
					end)
				else
					pcall(function() require('nvim-treesitter').install(missing) end)
				end
			end

			-- On `main` you turn highlighting on yourself; there is no
			-- `highlight = { enable = true }` option any more.
			vim.api.nvim_create_autocmd('FileType', {
				group = vim.api.nvim_create_augroup('user_treesitter', { clear = true }),
				callback = function(ev)
					if vim.bo[ev.buf].buftype ~= '' then return end
					-- Fails silently for filetypes with no parser installed.
					pcall(vim.treesitter.start, ev.buf)
				end,
			})
		end,
	},

	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		branch = 'main',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		event = { 'BufReadPost', 'BufNewFile' },
		config = function()
			require('nvim-treesitter-textobjects').setup {
				select = {
					lookahead = true,
					selection_modes = {
						['@parameter.outer'] = 'v',
						['@function.outer'] = 'V',
						['@class.outer'] = '<c-v>',
					},
					include_surrounding_whitespace = false,
				},
				move = { set_jumps = true },
			}

			local select = require 'nvim-treesitter-textobjects.select'
			local move = require 'nvim-treesitter-textobjects.move'

			-- `an`/`in` and `aj`/`ij` are deliberately absent: those are the
			-- quote and paren objects in config/keymaps.lua, which used to
			-- silently shadow the treesitter versions defined here.
			local objects = {
				f = 'function',
				c = 'class',
				a = 'parameter',
				i = 'conditional',
				l = 'loop',
			}

			for key, obj in pairs(objects) do
				for _, kind in ipairs { 'inner', 'outer' } do
					local lhs = (kind == 'inner' and 'i' or 'a') .. key
					local capture = '@' .. obj .. '.' .. kind
					vim.keymap.set({ 'x', 'o' }, lhs, function()
						select.select_textobject(capture, 'textobjects')
					end, { desc = kind .. ' ' .. obj, silent = true })
				end
			end

			vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
				move.goto_next_start('@function.outer', 'textobjects')
			end, { desc = 'Next function', silent = true })
			vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
				move.goto_previous_start('@function.outer', 'textobjects')
			end, { desc = 'Previous function', silent = true })
			vim.keymap.set({ 'n', 'x', 'o' }, ']a', function()
				move.goto_next_start('@parameter.inner', 'textobjects')
			end, { desc = 'Next parameter', silent = true })
			vim.keymap.set({ 'n', 'x', 'o' }, '[a', function()
				move.goto_previous_start('@parameter.inner', 'textobjects')
			end, { desc = 'Previous parameter', silent = true })
		end,
	},
}
