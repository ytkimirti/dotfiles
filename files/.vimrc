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
map <F7> :w <CR> :!clear && make run<CR>
map <F8> :w <CR> :!clear && gcc -o a.out % && ./a.out <CR>
map <F9> :w <CR> :!clear && gcc -o a.out *.c && ./a.out <CR>

nnoremap <F10> :call ToggleSyntastic()<CR>

nnoremap <Leader>w :up<CR> :Baslik<CR>
nnoremap <Leader>s A;<ESC>

" Pasting the yank register
nmap ,p "0p
nmap ,P "0P

nnoremap <Leader>p "*p
nnoremap <Leader>P "*P

" Copying to clipboard with capital Y
nnoremap Y "*y
vnoremap Y "*y

" Moving selected lines with J and K
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')


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
set relativenumber
" Video stuff
set noerrorbells
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set incsearch
if has('nvim')
	set undodir=~/.config/nvim/undodir
else
	set undodir=~/.vim/undodir
endif
set undofile

" Tab stuff
set autoindent noexpandtab tabstop=4 shiftwidth=4

call plug#begin('~/.vim/plugged')



if has('nvim')	" For nvim
	Plug 'neoclide/coc.nvim', {'branch': 'release'} " COC for nvim
else 			" For vim
	Plug 'vim-syntastic/syntastic'
	Plug 'alexandregv/norminette-vim'
	Plug 'andreyorst/SimpleSnippets.vim'
	Plug 'ytkimirti/SimpleSnippets-snippets'
	Plug 'jiangmiao/auto-pairs'
endif

" Editor
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'
Plug 'kien/ctrlp.vim'
Plug 'preservim/nerdcommenter'

Plug 'preservim/nerdtree'
"Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'

Plug 'aserebryakov/vim-todo-lists'

" Color themes
Plug 'rafi/awesome-vim-colorschemes'
"Plug 'morhetz/gruvbox'

call plug#end()

colorscheme alduin
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

" Ctrl P

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Ctrl / for commenting
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

" The file root sync thing, cd to current file
autocmd BufEnter * lcd %:p:h

" ------------- NERD TREE ---------------
nmap <C-n> :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTreeFocus<CR>
nnoremap <C-h> :NERDTreeToggle<CR>
let g:NERDTreeGitStatusWithFlags = 1

let g:NERDTreeIgnore = ['^node_modules$']


" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" >>>>>>>>>>>>>	VIM ONLY <<<<<<<<<<<<<

if !has('nvim')

"------------ Simple snippets -----------

let g:SimpleSnippetsExpandOrJumpTrigger = "<Tab>"
let g:SimpleSnippetsJumpBackwardTrigger = "<S-Tab>"
let g:SimpleSnippetsJumpToLastTrigger = "<C-j>"

let g:SimpleSnippets_similar_filetypes = [
			\ ['C_CPP', 'c', 'cpp', 'h']
			\]

" ------------------ SYNTASTIC SETTINGS ---------------------

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

else
" >>>>>>>>>>>>>>>>> NVIM ONLY <<<<<<<<<<<<<<<<<<<<<<<<<<<<

" ------------   COC CONFIG --------

" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
set cmdheight=2

set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set signcolumn=number

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  "\ 'coc-eslint', 
  "\ 'coc-prettier', 
  \ 'coc-json', 
  \ ]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)


" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)


" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)


" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif


endif
