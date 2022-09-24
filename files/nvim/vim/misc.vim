" Only highlight the lines passing 80 characters
" By dawid conway
call matchadd('ColorColumnu', '\%81v', 100)

"
" ( heyoo ) { heyoo }normal! i"
" ormal! i"
" "heyoo" 'heyoo' [ heyoo ]
"
"
"
xnoremap <silent> im <cmd>normal! i"<CR>
onoremap <silent> im <cmd>normal vi"<CR>

xnoremap <silent> am <cmd>normal! a"<CR>
onoremap <silent> am <cmd>normal va"<CR>

xnoremap <silent> in <cmd>normal! i'<CR>
onoremap <silent> in <cmd>normal vi'<CR>

xnoremap <silent> an <cmd>normal! a'<CR>
onoremap <silent> an <cmd>normal va'<CR>

xnoremap <silent> ij <cmd>normal! i(<CR>
onoremap <silent> ij <cmd>normal vi(<CR>

xnoremap <silent> aj <cmd>normal! a(<CR>
onoremap <silent> aj <cmd>normal va(<CR>

xnoremap <silent> iu <cmd>normal! iB<CR>
onoremap <silent> iu <cmd>normal viB<CR>

xnoremap <silent> au <cmd>normal! aB<CR>
onoremap <silent> au <cmd>normal vaB<CR>
