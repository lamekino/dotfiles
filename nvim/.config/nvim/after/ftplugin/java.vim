compiler javag
set suffixesadd=.java

" <Leader>1 is set to :make
nnoremap <F2> :!java <C-r>=expand("%:r")<cr><cr>
nnoremap <F3> :!find-junit <C-r>=expand("%:r")<cr><cr>
nnoremap <F12> :!rm *.class<cr>

" I want to make this better...
nnoremap <Leader>p oSystem.out.println();<Esc>F(
nnoremap <Leader>P oSystem.err.println();<Esc>F(
