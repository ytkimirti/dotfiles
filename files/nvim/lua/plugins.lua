local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	print "Running the function"
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	print("Function return value: " .. PACKER_BOOTSTRAP)
	print "Installing packer close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

-- Install your plugins here
return packer.startup(function(use)
	-- Essential
	use "wbthomason/packer.nvim"
	use "nvim-lua/plenary.nvim"

	-- Editor
	use { "mfussenegger/nvim-dap", config = [[require('config.dap')]] }
	-- This commit is for now
	use { 'lewis6991/gitsigns.nvim', commit = "851cd32caaea84f303c4fdf51d72dfa5fcd795bb", config = [[require('config.gitsigns')]] }
	use "tpope/vim-fugitive"
	use "tpope/vim-surround"
	use { "windwp/nvim-autopairs", config = [[require("config.autopairs")]] }
	use { 'windwp/nvim-ts-autotag', config = [[require('config.ts-autotag')]] }
	use { "numToStr/Comment.nvim", config = [[require('config.comment')]] }
	use { "Pocco81/AutoSave.nvim", module = "autosave" }
	use { "kyazdani42/nvim-tree.lua", config = [[require('config.nvim-tree')]],
		cmd = { 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeFindFile', 'NvimTreeCollapse' } }
	-- use { "wellle/targets.vim" }

	-- Visual
	-- use "sainnhe/gruvbox-material"
	use { "https://github.com/morhetz/gruvbox" }
	-- use "rafi/awesome-vim-colorschemes"
	use "kyazdani42/nvim-web-devicons"
	-- use { "rcarriga/nvim-notify", module = "notify" }
	-- use { 'goolord/alpha-nvim', config = [[require('config.alpha')]] }

	-- Other
	-- use "akinsho/bufferline.nvim"
	-- use "moll/vim-bbye"
	-- use "nvim-lualine/lualine.nvim"
	-- use "akinsho/toggleterm.nvim"
	-- use "ahmedkhalf/project.nvim"
	-- use "lewis6991/impatient.nvim"
	-- use "lukas-reineke/indent-blankline.nvim"
	-- use "goolord/alpha-nvim"
	-- use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight

	-- snippets
	use { "L3MON4D3/LuaSnip", config = [[require('config.luasnip')]] } --snippet engine
	use { 'ytkimirti/friendly-snippets', config = [[require('config.friendly-snippets')]]}

	-- cmp plugins
	use { "hrsh7th/nvim-cmp", config = [[require('config.cmp')]] }
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-nvim-lua"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "hrsh7th/cmp-nvim-lsp-signature-help"
	use "hrsh7th/cmp-cmdline"
	use { "mtoohey31/cmp-fish", ft = "fish" }
	use "onsails/lspkind.nvim"
	use { 'saadparwaiz1/cmp_luasnip' }


	-- LSP
	use { "neovim/nvim-lspconfig", config = [[require('config.lspconfig')]] }
	use { "williamboman/nvim-lsp-installer" }
	use { 'glepnir/lspsaga.nvim', branch = 'main', config = [[require('config.lspsaga')]] }
	use { 'ytkimirti/ale', config = [[require('config.ale')]] }
	-- use 'folke/lsp-colors.nvim'
	-- use "tamago324/nlsp-settings.nvim" -- language server settings defined in json
	-- use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

	use { "alec-gibson/nvim-tetris", command = ":Tetris" }

	-- Telescope
	use "nvim-telescope/telescope.nvim"

	-- Treesitter
	use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = [[require('config.treesitter')]] }
	use { "nvim-treesitter/nvim-treesitter-textobjects" }
	use { "nvim-treesitter/playground" }

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
