" Vimrc 4.0! :D
set nocp
filetype plugin indent on
" Plugins: {{{
if filereadable(expand("~/.vim/autoload/plug.vim"))
    call plug#begin("~/.vim/plugged")
    " Useful Plugins
    Plug 'vim-scripts/Align'      " Aligns whitespace
    Plug 'danro/rename.vim'       " Rename files from buffer
    Plug 'tpope/vim-commentary'   " Treat comments like text objects
    Plug 'tpope/vim-surround'     " Modify surrounding characters
    Plug 'ap/vim-css-color'       " Show hex colors #000000
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
set laststatus=2
set list
let &listchars="tab:| ,space:·,trail:×,nbsp:*"
"-- File Browser
let g:netrw_winsize = 15
let g:netrw_liststyle = 3
let g:netrw_banner = 0

set background=dark
if has("gui_running")
    set title
    set guifont=IBM\ Plex\ Mono\ Medium\ 11
    set guioptions-=m  " menu bar
    set guioptions-=T  " toolbar
    set guioptions-=r  " right scrollbar
    set guioptions-=L  " left scrollbar
endif

if has("termguicolors")
    " https://github.com/tmux/tmux/issues/1246#issue-292083184
    if exists("$TMUX")
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    set termguicolors
else
    set t_Co=256
endif
" }}}
" Keybinds: {{{
if has("mouse")
    set mouse=vn
endif

" Hide highlight
nnoremap ; :noh<cr>
" Delete to void
nnoremap _ "_d
" Yank to end like D
nnoremap Y y$
" Move blocks of text around
vnoremap <C-j> :m '>+1<cr>gv=gv
vnoremap <C-k> :m '<-2<cr>gv=gv

" Function keys
imap     <F1> <C-o>:echo<CR>
nnoremap <F1> :Buffers<cr>
nnoremap <F2> :Files .<cr>
nnoremap <F3> :cwindow<cr>
nnoremap <F4> :set paste!<cr>
nnoremap <F5> gg=G
nnoremap <F6> :set spell!<cr>
nnoremap <F11> :set wrap!<cr>
nnoremap <F12> :set ro!<cr>

" Leader keys
let mapleader=" "
nnoremap <Leader><Leader> :Lex<cr>
nnoremap <Leader>j :cnext<cr>
nnoremap <Leader>k :cprev<cr>
nnoremap <Leader>J :lnext<cr>
nnoremap <Leader>K :lprev<cr>

" Control keys
nnoremap <C-q> :bd<cr>
nnoremap <C-k> :w<cr>:make<cr>
nnoremap <C-s> :so $MYVIMRC<cr>
nnoremap <C-@> :GFiles .<cr>

" Splits/Buffers
nnoremap <C-h> :bprev!<cr>
nnoremap <C-l> :bnext!<cr>

" Copy/paste
noremap <C-y><C-y> "+y$
noremap <C-y> "+y
noremap <C-p> "+p
" }}}
" vim:foldmethod=marker:ts=4
