" -- My Keymaps -- 
"  "  F3 for seeing spaces
"  F9 for gcc on current
"  F8 for gcc with final flags
"  F10 for toggling syntastic
"  C-h for nerd tree toggle
"  C-n for nerd tree focus
"  Cmd-p for ctrlp      ()
"  Cmd-/ for commenting (++)


map <F8> :w <CR> :!clear && gcc -Werror -o a.out *.c && ./a.out <CR>
map <F9> :w <CR> :!clear && gcc -Werror -Wall -Wextra -o a.out *.c && ./rush- <CR>
" map <F9> :w <CR> :!clear && gcc -Wall -Werror -Wextra % && ./a.out <CR>
"


nnoremap ; :

nnoremap du gg11dj

" For local replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

" For ctrl-P
nnoremap <C-t> :Files<Cr>

" For backspace fricking delete
set backspace=indent,eol,start



:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
noremap <F3> :set list!<CR>
inoremap <F3> <C-o>:set list!<CR>
cnoremap <F3> <C-c>:set list!<CR>

syntax on

set mouse=a
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


" Shortcut for changing tabs
nnoremap H gT
nnoremap L gt

call plug#begin('~/.vim/plugged')

" Plug 'morhetz/gruvbox'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'andreyorst/SimpleSnippets.vim'
Plug 'ytkimirti/SimpleSnippets-snippets'
Plug 'vim-syntastic/syntastic'
Plug 'alexandregv/norminette-vim'
Plug 'kien/ctrlp.vim'

Plug 'morhetz/gruvbox'
Plug 'sickill/vim-monokai'
Plug 'taniarascia/new-moon.vim'

Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'preservim/nerdcommenter'

call plug#end()

colorscheme gruvbox 

" Ctrl / for commenting
nmap <C-n> :NERDTreeToggle<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

" The file root sync thing, cd to current file
autocmd BufEnter * lcd %:p:h

" NERD TREE
nnoremap <C-n> :NERDTreeFocus<CR>
nnoremap <C-h> :NERDTreeToggle<CR>
let g:NERDTreeGitStatusWithFlags = 1


" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Toggling syntastic window

function! ToggleSyntastic()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            lclose
            return
        endif
    endfor
    SyntasticCheck
endfunction

nnoremap <F10> :call ToggleSyntastic()<CR>

" -- NORMINETTE SETTINGS --


" Enable norminette-vim (and gcc)
let g:syntastic_c_checkers = ['gcc', 'norminette']
let g:syntastic_aggregate_errors = 0

" Support headers (.h)
let g:c_syntax_for_h = 1
let g:syntastic_c_include_dirs = ['include', '../include', '../../include', 'libft', '../libft/include', '../../libft/include']

" Pass custom arguments to norminette (this one ignores 42header)
" let g:syntastic_c_norminette_args = '-R CheckTopCommentHeader'

" For the things with headers
"let g:syntastic_c_norminette_args = '-R CheckDefine'

" Check errors when opening a file (disable to speed up startup time)
let g:syntastic_check_on_open = 0

" Enable error list
let g:syntastic_always_populate_loc_list = 1

" Automatically open error list
let g:syntastic_auto_loc_list = 1

" Skip check when closing
let g:syntastic_check_on_wq = 0
