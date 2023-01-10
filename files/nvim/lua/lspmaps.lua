local M = {}

local opts = { noremap = true, silent = true }
local set = vim.keymap.set


-- See `:help vim.lsp.*` for documentation on any of the below functions

local function saga_new()
	local saga = require('lspsaga')

	saga.init_lsp_saga()

	-- Lsp finder find the symbol definition implement reference
	-- if there is no implement it will hide
	-- when you use action in finder like open vsplit then you can
	-- use <C-t> to jump back
	set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

	-- Code action
	set({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

	-- Rename
	set("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })

	-- Peek Definition
	-- you can edit the definition file in this flaotwindow
	-- also support open/vsplit/etc operation check definition_action_keys
	-- support tagstack C-t jump back
	set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

	-- Show line diagnostics
	set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

	-- Show cursor diagnostic
	set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

	-- Diagnsotic jump can use `<c-o>` to jump back
	set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
	set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

	-- Only jump to error
	set("n", "[E", function()
	  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, { silent = true })
	set("n", "]E", function()
	  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, { silent = true })

	-- Outline
	-- set("n","<leader>o", "<cmd>LSoutlineToggle<CR>",{ silent = true })

	-- Hover Doc
	set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

	-- Float terminal
	set("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
	-- close floaterm
	set("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
end

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

	saga_new();

	-- lspsaga --

	-- Hover
	-- set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
	--
	-- -- Find usages
	-- set("n", "gu", "<cmd>Lspsaga lsp_finder<cr>", { silent = true, noremap = true })

	-- Code action

	-- local codeaction = require("lspsaga.codeaction")
	--
	-- set("n", "<leader>ca", codeaction.code_action, { silent = true, noremap = true })
	-- set("v", "<leader>ca", function()
	-- 	vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
	-- 	codeaction.range_code_action()
	-- end, { silent = true, noremap = true })

	-- scroll docs

	-- local action = require("lspsaga.action")

	-- set("n", "<C-.>", function()
	-- 	action.smart_scroll_with_saga(1)
	-- end, { silent = true, remap = true })
	-- -- scroll up hover doc
	-- set("n", "<C-,>", function()
	-- 	action.smart_scroll_with_saga(-1)
	-- end, { silent = true, remap = true })

	-- rename
	-- vim.keymap.set("n", "gr", require("lspsaga.rename").lsp_rename, { silent = true, noremap = true })
	-- preview definition
	-- vim.keymap.set("n", "gp", require("lspsaga.definition").preview_definition, { silent = true, noremap = true })

	-- diagnostics --

	-- -- Open list
	-- set('n', '<space>E', vim.diagnostic.setloclist, opts)
	--
	-- vim.keymap.set("n", "<leader>e", require("lspsaga.diagnostic").show_line_diagnostics, { silent = true,noremap = true })
	--
	-- -- Jump to diagnostic
	-- vim.keymap.set("n", "[d", require("lspsaga.diagnostic").goto_prev, { silent = true, noremap =true })
	-- vim.keymap.set("n", "]d", require("lspsaga.diagnostic").goto_next, { silent = true, noremap =true })
	-- -- Jump to error
	-- vim.keymap.set("n", "[e", function()
	-- 	require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
	-- end, { silent = true, noremap = true })
	-- vim.keymap.set("n", "]e", function()
	-- 	require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
	-- end, { silent = true, noremap = true })
	-- -- Jump to ale diagnostic
	-- vim.keymap.set("n", "[f", "<cmd>ALENext<cr>", { silent = true, noremap =true })
	-- vim.keymap.set("n", "]f", "<cmd>ALEPrevious<cr>", { silent = true, noremap =true })
	end
return M
