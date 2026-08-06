-- Leader has to be set before lazy.nvim loads any spec, otherwise every
-- plugin-defined <leader> mapping binds to "\" instead of space.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'config.options'
require 'config.lazy'
require 'config.keymaps'
require 'config.autocmds'
require 'config.commands'
