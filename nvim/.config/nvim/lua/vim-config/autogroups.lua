-- I'll move this to lua once it gets added to nvim

vim.cmd[[
" remove trailing spaces on write
autocmd BufWritePre * :%s/\s\+$//e
]]
