-- No more needed since not using norminette
vim.g.ale_fixers = {
	'shellcheck',
}

vim.g.ale_linters = {
	c = {"norminette"},
	cpp = {"norminette"}
}
