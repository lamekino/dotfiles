compiler javag
set suffixesadd=.java

nnoremap <Leader>r :!java <C-r>=expand("%:r")<cr><cr>
nnoremap <Leader>! :!rm *.class<cr>
nnoremap <Leader>p oSystem.out.println();<Esc>F(
nnoremap <Leader>P oSystem.err.println();<Esc>F(
