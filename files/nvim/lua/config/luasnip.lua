local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local m = extras.m
local l = extras.l
local la = extras.lambda
local rep = extras.rep
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")

-- For now at least
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end)

ls.config.setup({
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "●", "GruvboxOrange" } }
			}
		},
		[types.insertNode] = {
			active = {
				virt_text = { { "●", "GruvboxBlue" } }
			}
		}
	},
})

------------------ Custom snippets ---------------

local function header_filename(_, parent, _)
	local name = parent.snippet.env.TM_FILENAME:upper():gsub('[%.%s]', '_')
	return name
end

ls.add_snippets("all", {
	s({ trig = "hprot", docstring = "Add header protection" }, {
		t("#ifndef "),
		f(header_filename),
		t({ "", "", "# define " }),
		f(header_filename),
		t({ "", "", "" }),
		i(0),
		t({ "", "", "#endif" })
	}),
	-- s({ trig = "tst", docstring = "create a typedef struct" }, {
	-- 	t("typedef struct s_"),
	-- 	i(1, "name"),
	-- 	t({ "", "{", "\t" }),
	-- 	i(0),
	-- 	t({ "", "}\tt_" }),
	-- 	f(function(args) return args[1][1] end, { 1 }),
	-- }),
	-- s({ trig = "fn", docstring = "function" }, {
	-- 	i(1),
	-- 	t("("),
	-- 	i(2, "void"),
	-- 	t({ ")", "{", "\t" }),
	-- 	i(0),
	-- 	t({"", "}"}),
	-- }),
})

require("luasnip/loaders/from_vscode").load({ include = { "c" } })
-- require("luasnip/loaders/from_vscode").lazy_load();
