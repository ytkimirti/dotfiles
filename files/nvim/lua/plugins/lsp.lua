-- Which TypeScript server to run. Measured on a real project, 2026-08:
--
--            hover  def  refs  rename  docSymbols  codeActions
--   vtsls      ok    ok    4     ok         3          19
--   tsgo       ok    ok    4     ok         5           1
--
-- tsgo (microsoft/typescript-go, the native Go rewrite) is the newer and much
-- faster server, and it does have the one action that matters most -- "Add
-- import from ...". What it does not have yet is refactorings: convert
-- export/import styles, extract function, and so on. It also still reports
-- itself as `7.0.0-dev` and upstream labels it experimental.
--
-- So the default is vtsls. Change this one string to 'tsgo' if you want the
-- fast one; everything else adjusts automatically.
local TS_SERVER = 'vtsls'

-- Servers mason installs and keeps up to date for you. Kept deliberately
-- short because this machine is short on disk -- anything you `:MasonInstall`
-- later is picked up automatically. mason is a convenience, not a
-- requirement: see IF_AVAILABLE below.
local MASON_SERVERS = {
	'lua_ls',
	TS_SERVER,
	'jsonls',
	'cssls',
	'html',
	'bashls',
}

-- Servers enabled only when the binary is already on $PATH, however it got
-- there -- brew, npm, cargo, go install, rustup, mason, doesn't matter. Costs
-- no disk, and :checkhealth stays quiet about the ones you don't have.
--
-- This is what was broken before: the old config called vim.lsp.enable() on
-- ten servers, none of which were installed, so LSP silently did nothing.
--
-- A nested table means "first one that exists wins", so two servers covering
-- the same filetype never both attach and double up every diagnostic.
local IF_AVAILABLE = {
	'clangd',
	'gopls',
	'rust_analyzer',
	{ 'basedpyright', 'pyright' }, -- basedpyright is the maintained fork
	'ruff', -- lints/formats python alongside the type checker
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
			-- Enable every mason-installed server except the TypeScript one
			-- we didn't pick. Without this both attach to the same buffer and
			-- every diagnostic shows up twice.
			local other_ts = TS_SERVER == 'tsgo' and 'vtsls' or 'tsgo'
			require('mason-lspconfig').setup {
				ensure_installed = MASON_SERVERS,
				automatic_enable = { exclude = { other_ts } },
			}

			-- Is this server's binary on $PATH, however it got installed?
			local function available(name)
				local ok, cfg = pcall(function() return vim.lsp.config[name] end)
				if not ok or not cfg then return false end
				-- Most configs give a cmd table; a few build the command in a
				-- function, in which case fall back to the server's own name.
				local exe = type(cfg.cmd) == 'table' and cfg.cmd[1] or name
				return vim.fn.executable(exe) == 1
			end

			for _, entry in ipairs(IF_AVAILABLE) do
				-- A table is a preference list: enable the first one present.
				for _, name in ipairs(type(entry) == 'table' and entry or { entry }) do
					if available(name) then
						vim.lsp.enable(name)
						break
					end
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
