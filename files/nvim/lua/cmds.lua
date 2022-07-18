local new_cmd = vim.api.nvim_create_user_command

new_cmd("EnableAutoSave", function()
	require('config.auto-save')
	require('notify')('AutoSave enabled!', "success", {
		title = "",
		timeout = 500,
		render = "minimal",
		stages = "slide_in_slide_out",
	})
end, {})

new_cmd("CreateClangdFile", function()
	os.execute([[
	echo '
CompileFlags: # Tweak the parse settings
  Add: 
    - "-include-directory=libft"
	' > .clangd
	]])
end, {})
