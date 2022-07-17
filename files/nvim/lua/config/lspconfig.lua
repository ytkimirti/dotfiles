-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }

	-- Mappings
	require('lspmaps').setup()
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local config = require('lspconfig')

-- Language configs --
config.pyright.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

config.clangd.setup {}

config.tsserver.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

config.sumneko_lua.setup{
    on_attach = on_attach,
    flags = lsp_flags,
		settings = {
			Lua = {
				diagnostics = {
					globals = { 'vim' },
				},
			},
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
		},
}
config.rust_analyzer.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}
