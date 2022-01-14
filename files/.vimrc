" -- My Keymaps -- 
"  "  F3 for seeing spaces
"  F9 for gcc on current
"  F8 for gcc with final flags
"  F10 for toggling syntastic
"  C-h for nerd tree toggle
"  C-n for nerd tree focus
"  Cmd-p for ctrlp      ()
"  Cmd-/ for commenting (++)

"nnoremap <SPACE> <Nop>

let mapleader=" "

map <F5> :w <CR> :!clear && gcc -g -o dbg.out *.c && lldb ./dbg.out <CR>
map <F8> :w <CR> :!clear && gcc -o a.out *.c && ./a.out <CR>
map <F9> :w <CR> :!clear && gcc -Wall -Wextra -o a.out *.c && ./a.out <CR>
nnoremap <F10> :call ToggleSyntastic()<CR>

" Just for the vimrc
nnoremap <Leader>w :up<CR>
nnoremap <Leader>s A;<ESC>

" Pasting the yank register
nmap ,p "0p
nmap ,P "0P

" Copying to clipboard with capital Y
nnoremap Y "*y
vnoremap Y "*y

" Moving selected lines with J and K
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Open a new line with shift enter
imap <S-CR> <ESC>o

" Ctrl C same as ESC
map <C-c> <ESC>

filetype plugin on

" For surcing curr vimrc file
nnoremap <leader>m :w<CR> :source %<CR>

" For local replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

" For backspace fricking delete
set backspace=indent,eol,start

" Show hidden chars
:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
noremap <F3> :set list!<CR>
inoremap <F3> <C-o>:set list!<CR>
noremap <F3> <C-c>:set list!<CR>

syntax on

" I dont want recording, for now at least
map q <Nop>

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

call plug#begin('~/.vim/plugged')

Plug 'justinmk/vim-sneak'
Plug 'aserebryakov/vim-todo-lists'
Plug 'vim-syntastic/syntastic'
"Plug 'alexandregv/norminette-vim'
Plug 'kien/ctrlp.vim'

" Color themes
Plug 'rafi/awesome-vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'sickill/vim-monokai'

Plug 'andreyorst/SimpleSnippets.vim'
Plug 'ytkimirti/SimpleSnippets-snippets'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

call plug#end()

colorscheme onedark
"
" ------------------ Colorscheme choices ----------------
" onedark			easy on the eyes
" two-firewatch		really really dark, reddish
" spacecamp			really dark
" spacecamp_lite	kinda dark
" alduin			reaaaally easy on the eyes
" solarized8		solarized but not blue bg
" solarized8_flat
" solarized8 high
" dogrun			dog
" tender			genorous
" OceanicNext		really liked this one
"
" PaperColor	really contrasty
" minimalist	purple
"
" ---------
" hybrid_reverse	orangy
" hybrid_material	
" 

" ------------Simple snippets

let g:SimpleSnippetsExpandOrJumpTrigger = "<Tab>"
let g:SimpleSnippetsJumpBackwardTrigger = "<S-Tab>"
let g:SimpleSnippetsJumpToLastTrigger = "<C-j>"

let g:SimpleSnippets_similar_filetypes = [
			\ ['C_CPP', 'c', 'cpp', 'h']
			\]


" Ctrl / for commenting
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

" The file root sync thing, cd to current file
autocmd BufEnter * lcd %:p:h

" NERD TREE
nmap <C-n> :NERDTreeToggle<CR>
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


" ------------------ SYNTASTIC SETTINGS ---------------------


" Enable norminette-vim (and gcc)
" Add 'norminette here'
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_aggregate_errors = 0

" Support headers (.h)
let g:c_syntax_for_h = 1
let g:syntastic_c_include_dirs = ['include', '../include', '../../include', 'libft', '../libft/include', '../../libft/include']

" Pass custom arguments to norminette (this one ignores 42header)
 "let g:syntastic_c_norminette_args = '-R CheckTopCommentHeader'

" For the things with headers
let g:syntastic_c_norminette_args = '-R CheckDefine'

" Check errors when opening a file (disable to speed up startup time)
let g:syntastic_check_on_open = 0

" Enable error list
let g:syntastic_always_populate_loc_list = 1

" Automatically open error list
let g:syntastic_auto_loc_list = 1

" Skip check when closing
let g:syntastic_check_on_wq = 0
