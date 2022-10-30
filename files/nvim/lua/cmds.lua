local new_cmd = vim.api.nvim_create_user_command
local set = vim.keymap.set

P = function(v)
	print(vim.inspect(v))
end

-- new_cmd("EnableAutoSave", function()
-- 	require('config.auto-save')
-- 	require('notify')('AutoSave enabled!', "success", {
-- 		title = "",
-- 		timeout = 500,
-- 		render = "minimal",
-- 		stages = "slide_in_slide_out",
-- 	})
-- end, {})
--
new_cmd("CreateClangdFile", function()
	os.execute([[
	echo '
CompileFlags: # Tweak the parse settings
  Add: 
    - "-include-directory=libft"
	' > .clangd
	]])
end, {})

vim.g.is_zen = false
local o = vim.opt
new_cmd("ToggleZen", function()
	if not vim.g.is_zen then
		vim.g.is_zen = true
		o['showmode'] = false
		o['ruler'] = false
		o['laststatus'] = 0
		o['showcmd'] = false
		-- require('notify')('Zen enabled', 'success', {
		-- 	timeout = 100,
		-- 	render = "minimal",
		-- 	stages = "slide_in_slide_out",
		-- })
	else
		vim.g.is_zen = false
		-- require('notify')('Zen disabled', 'success', {
		-- 	timeout = 100,
		-- 	render = "minimal",
		-- 	stages = "slide_in_slide_out",
		-- })
		o['showmode'] = true
		o['ruler'] = false
		o['laststatus'] = 2
		o['showcmd'] = true
	end
end, {})

-- vim.cmd('ToggleZen')

set('n', '<leader>z', '<cmd>ToggleZen<cr>', {})



-- let s:hidden_all = 0
-- function! ToggleHiddenAll()
--     if s:hidden_all  == 0
--         let s:hidden_all = 1
--         set noshowmode
--         set noruler
--         set laststatus=0
--         set noshowcmd
--     else
--         let s:hidden_all = 0
--         set showmode
--         set ruler
--         set laststatus=2
--         set showcmd
--     endif
-- endfunction
--
-- nnoremap <silent> <S-h> :call ToggleHiddenAll()<CR>
