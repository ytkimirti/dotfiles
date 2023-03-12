let mapleader=" "

nnoremap ; :
nnoremap : ;

nmap ,p "0p
nmap ,P "0P

nnoremap <Leader>p "*p
nnoremap <Leader>P "*P

nnoremap Y "*y
vnoremap Y "*y

" Moving lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Resizing
nnoremap <M-Up> <cmd>resize -2<CR>
nnoremap <M-Down> <cmd>resize +2<CR>
nnoremap <M-Left> <cmd>vertical resize -2<CR>
nnoremap <M-Right> <cmd>vertical resize +2<CR>

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

map <C-c> <ESC>

" For surcing curr vimrc file
nnoremap <leader>m :w<CR> :source %<CR>

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
noremap <F3> :set list!<CR>
inoremap <F3> <C-o>:set list!<CR>

" Update cwd while browsing in netrw
let netwr_keepdir = 0

set backspace=indent,eol,start
set autoindent noexpandtab tabstop=4 shiftwidth=4
set mouse=a
set relativenumber
set belloff=all
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set incsearch
set hlsearch
set ttimeoutlen=0

filetype plugin on

" TODO: Learn how these work
" set undodir=~/.vim/undodir
" set undofile

let &t_ut='' " A fix for kitty terminal

set termguicolors
syntax on
silent! colorscheme habamax
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
