require 'user.options'
require 'user.keymaps'
vim.cmd('source ' .. '$HOME/.config/nvim/lua/user/keymaps.vim')
vim.cmd('source ' .. '$HOME/.config/nvim/lua/user/options.vim')
require 'user.plugins'
require 'user.cmp'
require 'user.lsp'
require 'user.treesitter'
