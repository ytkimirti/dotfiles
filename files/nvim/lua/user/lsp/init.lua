local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

a = {
	x = 2,
	y = 3
}

a.x = 28

require("user.lsp.lsp-installer")
require("user.lsp.handlers").setup()
