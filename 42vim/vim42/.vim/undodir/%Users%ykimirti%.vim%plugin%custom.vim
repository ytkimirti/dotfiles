Vim�UnDo� V����C���7�F��aM�)�8�
!���X�   C                  '       '   '   '    a1�    _�                             ����                                                                                                                                                                                                                                                                                                                                                             a1�     �                !call plug#begin('~/.vim/plugged')5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             a1�     �             �             5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             a1�     �                �             5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             a1�     �         !       5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a1�     �         !      Plug ''5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             a1�    �         !      Plug 'kien/ctrlp.vim.git'    �         !       5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a1�     �                Plug 'kien/ctrlp.vim.git'5�_�      	                     ����                                                                                                                                                                                                                                                                                                                                                             a1�    �                Plug 'git£kien/ctrlp.vim.git'5�_�      
           	           ����                                                                                                                                                                                                                                                                                                                                                             a1�     �                 5�_�   	              
           ����                                                                                                                                                                                                                                                                                                                                                             a1�     �         !       5�_�   
                        ����                                                                                                                                                                                                                                                                                                                                                             a1�    �         !      Plug ''5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             a1�    �         !      (Plug 'git@github.com:kien/ctrlp.vim.git'5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             a1]     �         !       5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             a1h     �         !      /highlight ColorColumn ctermbg=0 guibg=lightgrey    �         !       5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             a1x     �         !         5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a1|     �         !      !call plug#begin('~/.vim/plugged')    �         !         5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             a1�    �         !      Plug 'jpalardy/spacehi.vim.git'5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             a1o     �      	   "       �         !    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             a1q     �         $       5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             a1s     �         $       5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             a1z    �         %       5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             a1�     �         (      7set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<    �      	   (       5�_�                       7    ����                                                                                                                                                                                                                                                                                                                                                             a1�    �      	   '      7set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<5�_�                       6    ����                                                                                                                                                                                                                                                                                                                                                             a1�    �         (      6set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:5�_�                    	   
    ����                                                                                                                                                                                                                                                                                                                                                             a1�     �      
   (      noremap <F5> :set list!<CR>5�_�                    	   
    ����                                                                                                                                                                                                                                                                                                                                                             a1�     �      
   (      noremap <F4> :set list!<CR>5�_�                    
       ����                                                                                                                                                                                                                                                                                                                                                             a1�     �   	      (      !inoremap <F5> <C-o>:set list!<CR>5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a1�   
 �   
      (      !cnoremap <F5> <C-c>:set list!<CR>5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             a1Y     �         (    �         (    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             a1f     �         )      *map <F8> : !clear && gcc % && ./a.out <CR>5�_�                        %    ����                                                                                                                                                                                                                                                                                                                                                             a1s     �         )      *map <F4> : !clear && gcc % && ./a.out <CR>5�_�      !                      ����                                                                                                                                                                                                                                                                                                                                                             a1x    �         )      map <F4> : !clear &&  <CR>5�_�       "           !      !    ����                                                                                                                                                                                                                                                                                                                                                             a1�     �         )      &map <F4> : !clear && norminette % <CR>5�_�   !   #           "      !    ����                                                                                                                                                                                                                                                                                                                                                             a1      �         )      %map <F4> : !clear && norminette %<CR>5�_�   "   $           #   %        ����                                                                                                                                                                                                                                                                                                                                                             a1    �   %   (   *      " �   %   '   )    5�_�   #   %           $   +        ����                                                                                                                                                                                                                                                                                                                                                             a1P    �   *               5�_�   $   &           %   1        ����                                                                                                                                                                                                                                                                                                                            1          3           V       a1�    �   0   1          F" Set the path to norminette (do no set if using norminette of 42 mac)   Alet g:syntastic_c_norminette_exec = '~/.norminette/norminette.rb'    5�_�   %   '           &           ����                                                                                                                                                                                                                                                                                                                            1          1           V       a19    �         B      	syntax on5�_�   &               '           ����                                                                                                                                                                                                                                                                                                                                                             a1�    �          B       5��