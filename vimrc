"+-----------------------------------------------------------------------------+
"| ====           ▀                             ▄▄▄▄       ▄▄▄▄       █   ==== |
"| ====  ▄   ▄  ▄▄▄    ▄▄▄▄▄   ▄ ▄▄   ▄▄▄      ▀   ▀█     ▄▀  ▀▄     █    ==== |
"| ====  ▀▄ ▄▀    █    █ █ █   █▀  ▀ █▀  ▀       ▄▄▄▀     █    █    █     ==== |
"| ====   █▄█     █    █ █ █   █     █             ▀█     █    █          ==== |
"| ====    █    ▄▄█▄▄  █ █ █   █     ▀█▄▄▀     ▀▄▄▄█▀  █   █▄▄█   █       ==== |
"+-----------------------------------------------------------------------------+
"| Helpful Resources                                                           |
"| :help {cmd}                                                                 |
"| Vim scripting:    https://learnvimscriptthehardway.stevelosh.com            |
"| Vim tips wiki:    https://vim.fandom.com/wiki/Vim_Tips_Wiki                 |
"| Online help.txt:  http://vimdoc.sourceforge.net/htmldoc/                    |
"+-----------------------------------------------------------------------------+
" Settings {{{
" Vim settings
set nocp
set confirm
set incsearch
set wildmenu   " Use autocompletion in colon menu
set splitbelow " Make :sp go below
set splitright " Make :vsp go to the right
set showcmd    " Shows current normal mode command/key press
set path+=**   " https://youtu.be/XA2WjJbmmoM?t=408
set spelllang=en_us
set encoding=utf-8
filetype plugin indent on " use filetype based indentation

" Display settings
set number
set relativenumber
set laststatus=2  " Show bottom status bar
set cursorline    " Highlight current line
let g:netrw_winsize = 20    " set windows such as :lex use 20% of screen

" Tab settings
set smartindent   " Use smart indentation
set tabstop=4     " Display 4 spaces for each tab
set shiftwidth=4  " Autoindent spaces
set softtabstop=4 " How many spaces are inserted on <Tab>
set expandtab     " Expand tabs into spaces

" GVim
if has("gui_running")
    set guifont=IBM\ Plex\ Mono\ Medium\ 11
    set guioptions-=m  " menu bar
    set guioptions-=T  " toolbar
    set guioptions-=r  " right scrollbar
    set guioptions-=L  " left scrollbar
    hi Comment gui=bold
endif
" }}}
" Plugins {{{
if filereadable(expand("~/.vim/autoload/plug.vim"))
    call plug#begin("~/.vim/plugged")
    " Useful Plugins
    Plug 'tpope/vim-commentary'    " Treat comments like text objects
    Plug 'tpope/vim-surround'      " Modify surrounding characters
    Plug 'ap/vim-css-color'        " Previews hex colors, eg #00FFFF
    Plug 'danro/rename.vim'        " Rename files from buffer
    Plug 'bling/vim-bufferline'    " Buffer list at bottom
    Plug 'vim-airline/vim-airline' " The bar at the bottom
    Plug 'vim-airline/vim-airline-themes'
    " Language support
    Plug 'rust-lang/rust.vim'        " Rust
    Plug 'neovimhaskell/haskell-vim' " Haskell
    Plug 'alx741/vim-hindent'        " Haskell indentation
    Plug 'mmikeww/autohotkey.vim'    " AutoHotKey
    Plug 'PProvost/vim-ps1'          " Powershell
    " Colorschemes
    Plug 'morhetz/gruvbox'
    Plug 'nanotech/jellybeans.vim'
    call plug#end()
    " Plugin options
    " Airline
    let g:airline_theme           = "minimalist"
    let g:airline_powerline_fonts = 0
    let g:airline_symbols_ascii   = 1
    " Bufferline
    let g:bufferline_echo        = 0
    let g:bufferline_pathshorten = 1
    let g:bufferline_fname_mod   = ':.:~'
    " Gruvbox
    let g:gruvbox_contrast_dark  = 'hard'
    let g:gruvbox_contrast_light = 'soft'
    " Set a better update command
    command! PlugIn PlugUpdate | PlugUpgrade
endif
" }}}
" Appearence {{{
syntax on
set t_Co=256
set background=dark
hi Normal ctermbg=NONE

try
    colorscheme jellybeans
catch /^Vim\%((\a\+)\)\=:E185/ " error if colorscheme not found
    hi clear
    hi LineNr     cterm=none    ctermfg=8
    hi Comment    cterm=none    ctermfg=8
    hi cComment   cterm=none    ctermfg=8
    hi StatusLine cterm=reverse ctermfg=8
endtry
" }}}
" File types {{{
" C {{{
" Make
aug c
    au FileType c    nnoremap <F2> :!cc % -fsyntax-only -Wall -Wextra -pedantic<CR>
    au FileType cpp  nnoremap <F2> :!c++ % -fsyntax-only -Wall -Wextra -pedantic<CR>
    au FileType make nnoremap <F2> :!make<CR>
aug end
" }}}
" Shell {{{
aug sh
    au FileType sh nnoremap <F2> :!shellcheck %<CR>
aug end
" }}}
" Python {{{
aug python
    au FileType python nnoremap <F2> :!python -i %<CR>
aug end
" }}}
" Haskell {{{
aug haskell
    au FileType haskell setlocal ts=2 sts=2 sw=2 expandtab
    au FileType haskell nnoremap <F2>  :!ghci %<CR>
aug end
" }}}
" Markdown {{{
aug markdown
    au FileType markdown setlocal ts=2 sw=2 sts=2 expandtab spell
aug end
" }}}
" Special files {{{
" use marker folds in these files
aug vim
    au FileType vim  setlocal foldmethod=marker " vim scripts
    au FileType zsh  setlocal foldmethod=marker " zsh scripts
    au FileType tmux setlocal foldmethod=marker " tmux confs
    au BufRead,BufNewFile config.h setlocal foldmethod=marker " st config
aug end
" }}}
" Vim {{{
" open help to the right
aug vim_help
    au FileType help wincmd L
aug end
" }}}
" }}}
" Keybindings {{{
" Unmap
imap <F1> <nop>
" Leader keys {{{
let mapleader = "\<Space>"
nnoremap <Leader>W :w !sudo tee %<CR>
nnoremap <Leader>d "_d
nnoremap <Leader><Leader> :Files .<CR>
" File browsing
nnoremap <Leader>fs :Lex ~<CR>
nnoremap <Leader>ff :cd \| pwd<CR>
nnoremap <Leader>f. :cd .. \| pwd<CR>
nnoremap <Leader>fc :cd 
nnoremap <Leader>fg :GFiles? .<CR>
" System clipboard
nnoremap <Leader>Y "+y$
nnoremap <Leader>D "+d$
nnoremap <Leader>P  "+pa
" Buffers
nnoremap <Leader>l :bnext!<CR>
nnoremap <Leader>h :bprev!<CR>
nnoremap <Leader>q :bdelete<CR>
" Toggle options
nnoremap <Leader>tp :set paste!<CR>
nnoremap <Leader>tr :set ro!<CR>
nnoremap <Leader>tw :set wrap!<CR>
nnoremap <Leader>tc :ToggleColumn<CR>
nnoremap <Leader>ts :set spell!<CR>
nnoremap <Leader>tf :ToggleFoldMarker<CR>
" }}}
" Function keys {{{
nnoremap <F1>  :shell<CR>
nnoremap <F3>  :bprev!<CR>
nnoremap <F4>  :bnext!<CR>
nnoremap <F5>  :so ~/.vimrc<CR>
nnoremap <F6>  :bdelete<CR>
nnoremap <F8>  :!make<CR>
nnoremap <F9>  :!python<CR>
nnoremap <expr> <F10> &foldlevel ? 'zM' : 'zR'
nnoremap <F12> :PlugIn<CR>
" }}}
" Control keys {{{
nnoremap <C-q> :enew<CR>
nnoremap <C-g> :GFiles .<CR>
nmap     <C-p> "+pa
vmap     <C-x> "*d
vmap     <C-c> "*y
" }}}
" Normal Mode {{{
nnoremap H ^
nnoremap L $
" }}}
" }}}
