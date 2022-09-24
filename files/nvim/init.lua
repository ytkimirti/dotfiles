require 'plugins'
require 'options'
require 'maps'
require 'cmds'

local function source_vim(filename)
	vim.cmd('source ' .. vim.fn.stdpath('config') .. '/vim/' .. filename)
end

source_vim('ecole_header.vim')
source_vim('misc.vim')
