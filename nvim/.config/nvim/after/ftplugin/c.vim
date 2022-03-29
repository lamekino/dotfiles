compiler gcc
set suffixesadd=.c,.h

nnoremap <F2> :make <C-r>=expand("%:r")<cr><cr>
nnoremap <F3> :!./<C-r>=expand("%:r")<cr><cr>
nnoremap <F12> :make clean
