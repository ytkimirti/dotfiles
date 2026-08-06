local opt = vim.opt

-- Files / persistence
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000
opt.fileencoding = 'utf-8'
opt.confirm = true -- ask to save instead of failing :q on a dirty buffer

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'nosplit' -- live preview for :s and :IncRename

-- Indent (tabs, width 4 -- matches the rest of these dotfiles)
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true
opt.joinspaces = false -- one space when joining lines with J

-- UI
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.signcolumn = 'yes'
opt.cursorline = false
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.showmode = false -- lualine already shows it
opt.laststatus = 3 -- one global statusline instead of one per split
opt.pumheight = 10
opt.conceallevel = 0
opt.termguicolors = true
opt.background = 'dark'
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = 'screen' -- don't scroll the current window when splitting
opt.mouse = 'a'
opt.updatetime = 200
opt.listchars = { eol = '$', tab = '>-', trail = '~', extends = '>', precedes = '<' }

opt.completeopt = { 'menuone', 'noselect' }
opt.shortmess:append 'c'
opt.whichwrap:append '<,>,[,],h,l'

-- Nvim 0.11+ ships these providers off by default anyway; being explicit keeps
-- :checkhealth quiet and shaves the startup probe for interpreters we don't use.
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
