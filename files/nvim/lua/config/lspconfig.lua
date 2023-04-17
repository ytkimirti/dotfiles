require("mason").setup()
require("mason-lspconfig").setup()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

local server_configs = {
	pyright = {},
	bashls = {},
	dockerls = {},
	cssls = {},
	clangd = {},
	texlab = {},
	emmet_ls = require('server.emmet_ls'),
	tsserver = require('server.tsserver'),
	-- diagnosticls = require('server.diagnosticls'),
	lua_ls = require('server.lua_ls'),
	rust_analyzer = require('server.rust_analyzer')
}

local lsp = require "lspconfig"
-- local coq = require "coq"

-- Setup cmp with lsp
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local default_config = {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities
}

for server, config in pairs(server_configs) do
	local merged = {}

	for k, v in pairs(default_config) do merged[k] = v end
	for k, v in pairs(config) do merged[k] = v end

	lsp[server].setup(
		merged
	-- coq.lsp_ensure_capabilities(merged)
	)
end


-- Diagnostic style, i guess
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     underline = true,
--     -- This sets the spacing and the prefix, obviously.
--     virtual_text = {
--       spacing = 4,
--       prefix = ''
--     }
--   }
-- )
require("luasnip/loaders/from_vscode").lazy_load()
