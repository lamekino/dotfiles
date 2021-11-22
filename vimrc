" Vimrc 4.0! :D
set nocp
filetype plugin indent on
" Plugins: {{{
if filereadable(expand("~/.vim/autoload/plug.vim"))
    call plug#begin("~/.vim/plugged")
    " Useful Plugins
    Plug 'vim-scripts/Align'              " Aligns whitespace
    Plug 'danro/rename.vim'               " Rename files from buffer
    Plug 'tpope/vim-commentary'           " Treat comments like text objects
    Plug 'tpope/vim-surround'             " Modify surrounding characters
    Plug 'ap/vim-css-color'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    " Language support
    Plug 'sheerun/vim-polyglot'
    Plug 'alx741/vim-hindent'
    Plug 'uiiaoo/java-syntax.vim'
    " Appearance
    Plug 'vim-airline/vim-airline'        " The bar at the bottom
    Plug 'vim-airline/vim-airline-themes' " ^ themes
    Plug 'bling/vim-bufferline'           " Show buffers in airline
    " Colorschemes
    Plug 'morhetz/gruvbox'
    Plug 'nanotech/jellybeans.vim'
    call plug#end()
    " Plugin options
    " Airline
    let g:airline_theme           = "minimalist"
    let g:airline_powerline_fonts = 0
    let g:airline_symbols_ascii   = 1
    let g:airline_highlighting_cache = 1
    let g:airline_extensions      = [ 'bufferline' ]
    " Bufferline
    let g:bufferline_echo        = 0
    let g:bufferline_pathshorten = 1
    let g:bufferline_fname_mod   = ':p:~:.'
    " Gruvbox
    let g:gruvbox_contrast_dark  = 'hard'
    let g:gruvbox_contrast_light = 'hard'
    let g:rehash256 = 1
    colorscheme gruvbox
endif
" }}}
" Editor Config: {{{
set nu rnu
set confirm
set ignorecase
set incsearch
set hlsearch
set lazyredraw
set hidden
set cursorline
set splitbelow
set splitright
set showcmd
set wildmenu
set path+=**
"-- Tab settings
set ts=4 sw=4 sts=4
set expandtab
set autoindent
"-- Language Settings
set encoding=utf-8
set spelllang=en_us
"-- Appearance
syntax on
set notitle
set background=dark
set laststatus=2
set list
let &listchars="space:·,trail:×,nbsp:*"

if has("termguicolors")
    set termguicolors
else
    colorscheme industry
endif

if has("gui_running")
    set guifont=IBM\ Plex\ Mono\ Medium\ 11
    set guioptions-=m  " menu bar
    set guioptions-=T  " toolbar
    set guioptions-=r  " right scrollbar
    set guioptions-=L  " left scrollbar
endif
" }}}
" Keybinds: {{{
if has("mouse")
    set mouse=vn
endif
"" Function keys
imap     <F1> <C-o>:echo<CR>
noremap  <F1> :bnext!<cr>
noremap  <F2> :bprev!<cr>
nnoremap <F3> :GFiles .<cr>

"" Control keys
nnoremap <C-Q> :bd<cr>
nnoremap <C-K> :w<cr>:make<cr>
nnoremap <C-S> :so $MYVIMRC<cr>
nnoremap <C-@> :Files .<cr>

" Copy/paste
noremap <C-Y><C-Y> "+y$
noremap <C-Y> "+y
noremap <C-P> "+p

"" Quick keys
nnoremap ; :noh<cr>
nnoremap _ "_d
nnoremap H ^
nnoremap L $

"" Splits
map <left>  <C-w>h
map <down>  <C-w>j
map <up>    <C-w>k
map <right> <C-w>l

"" Leader keys
let mapleader=" "
nnoremap <Leader>tp :set paste!<cr>
nnoremap <Leader>tr :set ro!<cr>
nnoremap <Leader>tw :set wrap!<cr>
nnoremap <Leader>ts :set spell!<cr>
" }}}
" vim:foldmethod=marker:ts=4
