local M = {}

local opts = { noremap = true, silent = true }
local set = vim.keymap.set


-- See `:help vim.lsp.*` for documentation on any of the below functions

M.setup = function()
	-- print('Lsp hooked')
	-- diagnostic
	-- set('n', '<space>e', vim.diagnostic.open_float, opts)
	-- set('n', '[d', vim.diagnostic.goto_prev, opts)
	-- set('n', ']d', vim.diagnostic.goto_next, opts)

	set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
	set("n", "gf", "<cmd>Telescope lsp_implementations<cr>", opts)
	set("n", "gR", "<cmd>Telescope lsp_references<cr>", opts) -- saga is better


	-- set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
	-- set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
	-- set('n', '<space>wl', function()
	-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, opts)

	-- set('n', '<space>D', vim.lsp.buf.type_definition, opts)
	-- set('n', '<space>rn', vim.lsp.buf.rename, opts)
	-- set('n', '<space>ca', vim.lsp.buf.code_action, opts)
	-- set('n', 'gr', vim.lsp.buf.references, opts)
	set('n', '<space>fm', vim.lsp.buf.formatting, opts)

	-- lspsaga --

	-- Hover
	set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

	-- Find usages
	set("n", "gu", "<cmd>Lspsaga lsp_finder<cr>", { silent = true, noremap = true })

	-- Code action

	local codeaction = require("lspsaga.codeaction")

	set("n", "<leader>ca", codeaction.code_action, { silent = true, noremap = true })
	set("v", "<leader>ca", function()
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
		codeaction.range_code_action()
	end, { silent = true, noremap = true })

	-- scroll docs

	local action = require("lspsaga.action")

	set("n", "<C-.>", function()
		action.smart_scroll_with_saga(1)
	end, { silent = true, remap = true })
	-- scroll up hover doc
	set("n", "<C-,>", function()
		action.smart_scroll_with_saga(-1)
	end, { silent = true, remap = true })

	-- show signature help
	vim.keymap.set("n", "gs", require("lspsaga.signaturehelp").signature_help, { silent = true, noremap = true })
	-- rename
	vim.keymap.set("n", "gr", require("lspsaga.rename").lsp_rename, { silent = true, noremap = true })
	-- preview definition
	vim.keymap.set("n", "gp", require("lspsaga.definition").preview_definition, { silent = true, noremap = true })

	-- diagnostics --

	-- Open list
	set('n', '<space>E', vim.diagnostic.setloclist, opts)

	vim.keymap.set("n", "<leader>e", require("lspsaga.diagnostic").show_line_diagnostics, { silent = true,noremap = true })

	-- jump diagnostic
	vim.keymap.set("n", "[d", require("lspsaga.diagnostic").goto_prev, { silent = true, noremap =true })
	vim.keymap.set("n", "]d", require("lspsaga.diagnostic").goto_next, { silent = true, noremap =true })
	-- or jump to error
	vim.keymap.set("n", "[e", function()
		require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, { silent = true, noremap = true })
	vim.keymap.set("n", "]e", function()
		require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, { silent = true, noremap = true })
	end
return M
