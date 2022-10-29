local status_ok, tsconfig = pcall(require, "nvim-treesitter.configs")
if not status_ok then return end

tsconfig.setup {
	-- A list of parser names, or "all"
	ensure_installed = {
		"c",
		"lua",
		"rust",
		"fish",
		"bash",
		"json",
		"make",
		"markdown",
		"markdown_inline",
	},
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = true,

	-- Automatically install missing parsers when entering buffer
	auto_install = true,
	highlight = {
		enable = true,
		disable = {},

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
  autotag = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",

        -- ["au"] = "@function.outer",
        -- ["iu"] = "@function.inner",
        --
        -- ["aj"] = "@block.outer",
        -- ["ij"] = "@block.inner",
        --
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        ["an"] = "@parameter.outer",
        ["in"] = "@parameter.inner",

		["ai"] = "@conditional.outer",
		["ii"] = "@conditional.inner",

		["ia"] = "@parameter.inner",
		["aa"] = "@parameter.outer",

		["al"] = "@loop.outer",
		["il"] = "@loop.inner",
      },
      -- You can choose the select mode (default is charwise 'v')
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding xor succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      include_surrounding_whitespace = false,
    },
  },
}
