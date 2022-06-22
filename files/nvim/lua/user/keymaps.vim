" -- My Keymaps -- 
"  "  F3 for seeing spaces
"  F9 for gcc on current
"  F8 for gcc with final flags
"  F10 for toggling syntastic
"  C-h for nerd tree toggle
"  C-n for nerd tree focus
"  Cmd-p for ctrlp      ()
"  Cmd-/ for commenting (++)

let mapleader=" "

map <F5> :w <CR> :!clear && gcc -g -o dbg.out *.c && lldb ./dbg.out <CR>
map <F7> :w <CR> :!clear && make run<CR>
map <F8> :w <CR> :!clear && gcc -o a.out % && ./a.out <CR>
map <F9> :w <CR> :!clear && gcc -o a.out *.c && ./a.out <CR>

nnoremap <F10> :call ToggleSyntastic()<CR>


" Pasting the yank register
nmap ,p "0p
nmap ,P "0P

nnoremap <Leader>p "*p
nnoremap <Leader>P "*P

" Copying to clipboard with capital Y
nnoremap Y "*y
vnoremap Y "*y

" Show hidden chars
:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
noremap <F3> :set list!<CR>
inoremap <F3> <C-o>:set list!<CR>
noremap <F3> <C-c>:set list!<CR>

" Leader maps
nnoremap <Leader>w :up<CR>

