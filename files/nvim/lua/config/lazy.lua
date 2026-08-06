local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'--branch=stable',
		'https://github.com/folke/lazy.nvim.git',
		lazypath,
	}
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
			{ out, 'WarningMsg' },
			{ '\nPress any key to continue without plugins.' },
		}, true, {})
		vim.fn.getchar()
		return
	end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
	spec = { { import = 'plugins' } },
	install = { colorscheme = { 'gruvbox', 'habamax' } },
	checker = { enabled = true, notify = false }, -- check for updates, don't nag
	change_detection = { notify = false },
	ui = { border = 'rounded' },
	rocks = { enabled = false }, -- nothing here needs luarocks; keeps :checkhealth clean
	performance = {
		rtp = {
			disabled_plugins = {
				'gzip',
				'tarPlugin',
				'tohtml',
				'tutor',
				'zipPlugin',
				'netrwPlugin',
				'rplugin',
			},
		},
	},
}
