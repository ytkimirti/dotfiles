map <F8> : !clear && gcc % && ./a.out <CR>

map <F4> : !clear && norminette % <CR>

"syntax on

" List olayi
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

noremap <F3> :set list!<CR>
inoremap <F3> <C-o>:set list!<CR>
cnoremap <F3> <C-c>:set list!<CR>

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set nowrap
set smartcase
set noswapfile
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch

" ---- That line 80 thing -----

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

" Plug 'git@github.com:kien/ctrlp.vim.git'
" Plug 'jpalardy/spacehi.vim.git'
Plug 'vim-syntastic/syntastic'
Plug 'alexandregv/norminette-vim'

call plug#end()

" -- norminette olayi --

" Enable norminette-vim (and gcc)
let g:syntastic_c_checkers = ['norminette', 'gcc']
let g:syntastic_aggregate_errors = 1

" Support headers (.h)
let g:c_syntax_for_h = 1
let g:syntastic_c_include_dirs = ['include', '../include', '../../include', 'libft', '../libft/include', '../../libft/include']

" Pass custom arguments to norminette (this one ignores 42header)
let g:syntastic_c_norminette_args = '-R CheckTopCommentHeader'

" Check errors when opening a file (disable to speed up startup time)
let g:syntastic_check_on_open = 1

" Enable error list
let g:syntastic_always_populate_loc_list = 1

" Automatically open error list
let g:syntastic_auto_loc_list = 1

" Skip check when closing
let g:syntastic_check_on_wq = 0
