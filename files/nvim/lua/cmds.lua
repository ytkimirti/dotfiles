local new_cmd = vim.api.nvim_create_user_command

new_cmd("CreateClangdFile", function()
	os.execute([[
	echo '
CompileFlags: # Tweak the parse settings
  Add: 
    - "-include-directory=libft"
	' > .clangd
	]])
end, {})
