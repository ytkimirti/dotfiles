require("mason").setup()
require("mason-lspconfig").setup()

-- Setup cmp capabilities for all servers
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.lsp.config('*', {
	capabilities = capabilities
})

-- Server-specific overrides
vim.lsp.config('emmet_ls', require('server.emmet_ls'))
vim.lsp.config('lua_ls', require('server.lua_ls'))
vim.lsp.config('rust_analyzer', require('server.rust_analyzer'))

vim.lsp.enable({
	'pyright',
	'bashls',
	'dockerls',
	'cssls',
	'clangd',
	'texlab',
	'emmet_ls',
	'ts_ls',
	'lua_ls',
	'rust_analyzer',
})

require("luasnip/loaders/from_vscode").lazy_load()
