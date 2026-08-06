return {
	{
		'L3MON4D3/LuaSnip',
		version = 'v2.*',
		build = 'make install_jsregexp',
		dependencies = { 'ytkimirti/friendly-snippets' },
		config = function()
			local ls = require 'luasnip'
			local s, t, i, f = ls.snippet, ls.text_node, ls.insert_node, ls.function_node
			local types = require 'luasnip.util.types'

			ls.setup {
				history = true,
				updateevents = 'TextChanged,TextChangedI',
				enable_autosnippets = false,
				ext_opts = {
					[types.choiceNode] = { active = { virt_text = { { '●', 'GruvboxOrange' } } } },
					[types.insertNode] = { active = { virt_text = { { '●', 'GruvboxBlue' } } } },
				},
			}

			vim.keymap.set({ 'i', 's' }, '<C-k>', function()
				if ls.choice_active() then ls.change_choice(1) end
			end, { desc = 'Next snippet choice' })

			vim.keymap.set({ 'i', 's' }, '<C-j>', function()
				if ls.choice_active() then ls.change_choice(-1) end
			end, { desc = 'Previous snippet choice' })

			-- Include guard, derived from the file name
			local function guard(_, parent)
				return (parent.snippet.env.TM_FILENAME:upper():gsub('[%.%s%-]', '_'))
			end

			ls.add_snippets('all', {
				s({ trig = 'hprot', desc = 'Header include guard' }, {
					t '#ifndef ',
					f(guard),
					t { '', '', '# define ' },
					f(guard),
					t { '', '', '' },
					i(0),
					t { '', '', '#endif' },
				}),
			})

			require('luasnip.loaders.from_vscode').lazy_load()
		end,
	},

	{
		-- Replaces nvim-cmp and its eight source plugins. Rust fuzzy matcher,
		-- built-in signature help, built-in cmdline completion.
		'saghen/blink.cmp',
		event = { 'InsertEnter', 'CmdlineEnter' },
		version = '1.*', -- release tag => prebuilt binary, no cargo needed
		dependencies = { 'L3MON4D3/LuaSnip' },
		opts = {
			snippets = { preset = 'luasnip' },

			keymap = {
				preset = 'none',
				['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
				['<C-e>'] = { 'hide', 'fallback' },
				-- Only confirms something you actually selected, otherwise a
				-- plain newline. Matches the old cmp `select = false`.
				['<CR>'] = { 'accept', 'fallback' },
				['<C-n>'] = { 'select_next', 'fallback' },
				['<C-p>'] = { 'select_prev', 'fallback' },
				['<Down>'] = { 'select_next', 'fallback' },
				['<Up>'] = { 'select_prev', 'fallback' },
				-- Snippet jump first, doc scroll if there's no snippet active
				['<C-.>'] = { 'snippet_forward', 'scroll_documentation_down', 'fallback' },
				['<C-,>'] = { 'snippet_backward', 'scroll_documentation_up', 'fallback' },
				-- Tab stays a tab
				['<Tab>'] = { 'fallback' },
				['<S-Tab>'] = { 'fallback' },
			},

			appearance = { nerd_font_variant = 'mono' },

			completion = {
				list = { selection = { preselect = false, auto_insert = false } },
				documentation = { auto_show = true, auto_show_delay_ms = 250 },
				ghost_text = { enabled = false },
				menu = { draw = { treesitter = { 'lsp' } } },
			},

			signature = { enabled = true },

			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},

			cmdline = {
				keymap = { preset = 'cmdline' },
				completion = { menu = { auto_show = true } },
			},

			fuzzy = { implementation = 'prefer_rust_with_warning' },
		},
		opts_extend = { 'sources.default' },
	},
}
