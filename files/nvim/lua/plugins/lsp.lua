-- Servers mason installs and keeps up to date for you. Kept deliberately
-- short because this machine is short on disk -- anything you `:MasonInstall`
-- later is picked up automatically by mason-lspconfig's automatic_enable.
local MASON_SERVERS = {
	'lua_ls',
	'vtsls', -- TypeScript / JavaScript
	'jsonls',
	'cssls',
	'html',
	'bashls',
}

-- Servers we enable only when the binary is already on $PATH, so nothing here
-- costs disk and :checkhealth stays quiet about the ones you don't have.
-- This is what was broken before: the old config called vim.lsp.enable() on
-- ten servers, none of which were installed.
local IF_AVAILABLE = {
	'clangd',
	'gopls',
	'rust_analyzer',
	'pyright',
	'basedpyright',
	'ruff',
	'zls',
	'taplo',
	'yamlls',
	'marksman',
	'dockerls',
	'emmet_ls',
	'fish_lsp',
	'tailwindcss',
	'eslint',
}

return {
	{ 'mason-org/mason.nvim', cmd = 'Mason', opts = { ui = { border = 'rounded' } } },

	{
		'neovim/nvim-lspconfig',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			'mason-org/mason.nvim',
			'mason-org/mason-lspconfig.nvim',
			'saghen/blink.cmp',
		},
		config = function()
			-- ---------------------------------------------------- diagnostics ---
			vim.diagnostic.config {
				severity_sort = true,
				update_in_insert = false,
				underline = { severity = { min = vim.diagnostic.severity.WARN } },
				float = { border = 'rounded', source = 'if_many' },
				virtual_text = { spacing = 2, prefix = '●', source = 'if_many' },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = '󰅚 ',
						[vim.diagnostic.severity.WARN] = '󰀪 ',
						[vim.diagnostic.severity.INFO] = '󰋽 ',
						[vim.diagnostic.severity.HINT] = '󰌶 ',
					},
				},
			}

			-- --------------------------------------------------- capabilities ---
			vim.lsp.config('*', {
				capabilities = require('blink.cmp').get_lsp_capabilities(),
			})

			-- ------------------------------------------ per-server overrides ---
			vim.lsp.config('lua_ls', {
				settings = {
					Lua = {
						-- These three used to sit outside the `Lua` table, so
						-- lua_ls ignored all of them.
						runtime = { version = 'LuaJIT' },
						diagnostics = { globals = { 'vim' } },
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME, '${3rd}/luv/library' },
						},
						telemetry = { enable = false },
						format = { enable = false },
					},
				},
			})

			vim.lsp.config('emmet_ls', {
				-- html/css only: on tsx/jsx it fights with the TS server
				filetypes = { 'html', 'css', 'sass', 'scss', 'less' },
			})

			-- ------------------------------------------------------ mason ---
			require('mason-lspconfig').setup {
				ensure_installed = MASON_SERVERS,
				automatic_enable = true, -- calls vim.lsp.enable() for installed servers
			}

			-- Anything already on $PATH (rustup, go install, brew, Xcode...)
			for _, name in ipairs(IF_AVAILABLE) do
				local ok, cfg = pcall(function() return vim.lsp.config[name] end)
				local cmd = ok and cfg and cfg.cmd
				if type(cmd) == 'table' and vim.fn.executable(cmd[1]) == 1 then
					vim.lsp.enable(name)
				end
			end

			-- ------------------------------------------------- buffer maps ---
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
				callback = function(ev)
					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
					end

					map('n', 'K', function() vim.lsp.buf.hover { border = 'rounded' } end, 'Hover')
					map('n', 'gD', vim.lsp.buf.declaration, 'Declaration')
					map('n', '<leader>D', vim.lsp.buf.type_definition, 'Type definition')
					map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code action')
					map('n', '<leader>lf', function() require('conform').format { async = true, lsp_format = 'fallback' } end, 'Format')

					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if client and client:supports_method 'textDocument/inlayHint' then
						map('n', '<leader>lh', function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = ev.buf }, { bufnr = ev.buf })
						end, 'Toggle inlay hints')
					end
				end,
			})
		end,
	},

	{
		-- Live-previewing rename. Bound to grn, which overrides Nvim 0.11's
		-- built-in rename. The old config bound bare `gr`, which shadowed the
		-- whole built-in gr* prefix (grr/gri/gra/grn) behind a timeout.
		'smjonas/inc-rename.nvim',
		cmd = 'IncRename',
		opts = {},
		keys = {
			{
				'grn',
				function() return ':IncRename ' .. vim.fn.expand '<cword>' end,
				expr = true,
				desc = 'Rename symbol',
			},
		},
	},

	{
		'folke/trouble.nvim',
		cmd = 'Trouble',
		opts = {},
		keys = {
			{ '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Workspace diagnostics' },
			{ '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer diagnostics' },
			{ '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols' },
			{ '<leader>xl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'LSP references' },
			{ '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix' },
		},
	},

	{
		'stevearc/conform.nvim',
		event = 'BufWritePre',
		cmd = 'ConformInfo',
		opts = {
			-- Each entry falls back to the LSP formatter when the binary is
			-- missing, so none of this needs to be installed to work.
			formatters_by_ft = {
				lua = { 'stylua' },
				javascript = { 'prettierd', 'prettier', stop_after_first = true },
				javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
				typescript = { 'prettierd', 'prettier', stop_after_first = true },
				typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
				json = { 'prettierd', 'prettier', stop_after_first = true },
				jsonc = { 'prettierd', 'prettier', stop_after_first = true },
				css = { 'prettierd', 'prettier', stop_after_first = true },
				scss = { 'prettierd', 'prettier', stop_after_first = true },
				html = { 'prettierd', 'prettier', stop_after_first = true },
				yaml = { 'prettierd', 'prettier', stop_after_first = true },
				markdown = { 'prettierd', 'prettier', stop_after_first = true },
				go = { 'goimports', 'gofmt' },
				rust = { 'rustfmt' },
				python = { 'ruff_format' },
				sh = { 'shfmt' },
				fish = { 'fish_indent' },
			},
			default_format_opts = { lsp_format = 'fallback' },
			-- Opt-in, not on by default: format_on_save = { timeout_ms = 1000 },
		},
	},
}
