require 'plugins'
require 'options'
require 'maps'
require 'cmds'

function source_vim(filename)
	vim.cmd('source ' .. vim.fn.stdpath('config') .. '/vim/' .. filename)
end

source_vim('ecole_header.vim')
