map <F8> :w <CR> :!clear && gcc -Wall -Werror % && ./a.out <CR>
map <F9> :w <CR> :!clear && gcc -Wall -Werror -Wextra % && ./a.out <CR>

" For local replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

" For ctrl-P
nnoremap <C-t> :Files<Cr>


:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
noremap <F3> :set list!<CR>
inoremap <F3> <C-o>:set list!<CR>
cnoremap <F3> <C-c>:set list!<CR>



syntax on

" Video stuff
set noerrorbells
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch

" Tab stuff
set autoindent noexpandtab tabstop=4 shiftwidth=4




call plug#begin('~/.vim/plugged')

" Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'andreyorst/SimpleSnippets.vim'
Plug 'andreyorst/SimpleSnippets-snippets'
Plug 'vim-syntastic/syntastic'
Plug 'alexandregv/norminette-vim'

call plug#end()

" -- NORMINETTE SETTINGS --


" Enable norminette-vim (and gcc)
let g:syntastic_c_checkers = ['gcc', 'norminette']
let g:syntastic_aggregate_errors = 0

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
