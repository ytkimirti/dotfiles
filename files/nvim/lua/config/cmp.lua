local cmp = require 'cmp'
local luasnip = require("luasnip")
local lspkind = require('lspkind')

cmp.setup({
	formatting = {
		format = lspkind.cmp_format(),
	},
	snippet = {
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	view = {
		entries = { name = 'custom', selection_order = 'near_cursor' }
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-Space>'] = cmp.mapping.complete(),
		-- ['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		['<C-i>'] = cmp.mapping.confirm({ select = true }), -- Accept the top element
		['<C-.>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable() then
				luasnip.jump(1)
			else
				cmp.mapping.scroll_docs(4)
			end
		end
		),
		['<C-,>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				cmp.mapping.scroll_docs(-4)
			end
		end
		),
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item()
		-- 	-- elseif luasnip.expand_or_jumpable() then
		-- 	-- 	luasnip.expand_or_jump()
		-- 	-- elseif has_words_before() then
		-- 	-- 	cmp.complete()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
  --
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_prev_item()
		-- 	elseif luasnip.jumpable(-1) then
		-- 		luasnip.jump(-1)
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = 'luasnip' },
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'fish' },
		{ name = 'path' },
	},
		{
			{ name = 'buffer' },
		})
})

-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
-- 	sources = cmp.config.sources({
-- 		{ name = 'git' },
-- 	}, {
-- 		{ name = 'buffer' },
-- 	})
-- })

cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	view = {
		entries = { name = 'wildmenu', separator = '|' }
	},
	sources = {
		{ name = 'buffer' }
	}
})

cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})
