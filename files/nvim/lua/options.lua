local options = {
  joinspaces = false,											 -- Insert only one space when joining lines with J
  backup = false,                          -- creates a backup file
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp*
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
	-- timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  -- expandtab = true,                     -- convert tabs to spaces
  shiftwidth = 4,                          -- the number of spaces for each >> or <<
  tabstop = 4,                             -- insert virtual spaces for a tab
  cursorline = false,                      -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = true,                  -- set relative numbered lines
  numberwidth = 2,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                            -- display lines as one long line
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
	background = 'dark',
}

-- This is for gruvbox-material. Available values: 'hard', 'medium'(default), 'soft'
-- vim.g.gruvbox_material_background = 'medium'

-- local function call_ok(func, ...)
-- 	local ok, _ = pcall(func, ...)
-- 	return ok
-- end

if pcall(vim.cmd, 'colorscheme carbonfox') then

elseif pcall(vim.cmd, "colorscheme tokyonight") then
	local ok, tokyonight = pcall(require, "tokyonight")
	if ok then
		tokyonight.setup {
			style = "night",
		}
	end
elseif pcall(vim.cmd, "colorscheme gruvbox") then
	vim.g.gruvbox_transparent_bg = 1
	vim.g.gruvbox_bold = 0
	vim.g.gruvbox_contrast_dark = "hard"
end

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
-- vim.cmd [[set iskeyword+=-]]              -- w-15 or flex-wrap is trated as one word


