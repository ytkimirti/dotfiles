-- Global pretty-printer for poking at things from :lua
_G.P = function(...)
	vim.print(...)
	return ...
end

-- Strip every bit of chrome for screenshots / distraction-free editing
local zen_saved = nil

vim.api.nvim_create_user_command('ToggleZen', function()
	if zen_saved then
		for name, value in pairs(zen_saved) do
			vim.opt[name] = value
		end
		zen_saved = nil
	else
		zen_saved = {}
		for _, name in ipairs { 'showmode', 'ruler', 'laststatus', 'showcmd', 'number', 'relativenumber', 'signcolumn' } do
			zen_saved[name] = vim.opt[name]:get()
		end
		vim.opt.showmode = false
		vim.opt.ruler = false
		vim.opt.laststatus = 0
		vim.opt.showcmd = false
		vim.opt.number = false
		vim.opt.relativenumber = false
		vim.opt.signcolumn = 'no'
	end
end, { desc = 'Toggle distraction-free mode' })

vim.keymap.set('n', '<leader>z', '<cmd>ToggleZen<cr>', { silent = true, desc = 'Toggle zen mode' })
