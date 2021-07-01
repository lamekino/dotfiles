"+----------------------------------------------------------------------------+
"| ====           ▀                                 ▄▄▄▄          ▄▄▄▄   ==== |
"| ====  ▄   ▄  ▄▄▄    ▄▄▄▄▄   ▄ ▄▄   ▄▄▄          ▀   ▀█        ▄▀  ▀▄  ==== |
"| ====  ▀▄ ▄▀    █    █ █ █   █▀  ▀ █▀  ▀             ▄▀        █  ▄ █  ==== |
"| ====   █▄█     █    █ █ █   █     █               ▄▀          █    █  ==== |
"| ====    █    ▄▄█▄▄  █ █ █   █     ▀█▄▄▀         ▄█▄▄▄▄   █     █▄▄█   ==== |
"+----------------------------------------------------------------------------+
"| Helpful Resources                                                          |
"| :help {cmd}                                                                |
"| Vim scripting:    https://learnvimscriptthehardway.stevelosh.com           |
"| Vim tips wiki:    https://vim.fandom.com/wiki/Vim_Tips_Wiki                |
"| Online help.txt:  http://vimdoc.sourceforge.net/htmldoc/                   |
"+----------------------------------------------------------------------------+
" Basic settings {{{
set nocp
set number
set relativenumber
set confirm
set incsearch
set spelllang=en_us
set encoding=utf-8
set tabstop=4       " Display 4 spaces for each tab
set shiftwidth=4    " Autoindent spaces
set softtabstop=4   " How many spaces are inserted on <Tab>
set laststatus=2    " Show bottom status bar
set path+=**        " see https://youtu.be/XA2WjJbmmoM?t=408
set smartindent     " Use smart indentation
set wildmenu        " Use autocompletion in colon menu
set noexpandtab     " Don't use spaces for tabs
set splitbelow      " Make :sp go below
set splitright      " Make :vsp go to the right
set showcmd         " Shows current normal mode command/key press
set autochdir       " Automatically :cd into open file directory
set cursorline      " Highlight current line
let g:netrw_winsize = 20    " set windows such as :lex use 20% of screen
filetype plugin indent on   " use filetype based indentation
" }}}
" Plugins {{{
if filereadable(expand("~/.vim/autoload/plug.vim"))
	call plug#begin("~/.vim/plugged")
	" Useful Plugins
	Plug 'vim-airline/vim-airline'         " The bar at the bottom
	Plug 'vim-airline/vim-airline-themes'  " + themes
	Plug 'tpope/vim-commentary'            " Treat comments like text objects
	Plug 'tpope/vim-surround'              " Modify surrounding characters
	Plug 'ap/vim-css-color'                " Previews hex colors, eg #00FFFF
	Plug 'junegunn/fzf'                    " Fuzzy finder
	Plug 'junegunn/fzf.vim'                " Scripts for fzf
	Plug 'danro/rename.vim'                " Rename files from buffer
	Plug 'bling/vim-bufferline'            " Buffer list at bottom
	" Language support
	Plug 'rust-lang/rust.vim'             " Rust
	Plug 'neovimhaskell/haskell-vim'      " Haskell
	Plug 'alx741/vim-hindent'             " Haskell indentation
	Plug 'mmikeww/autohotkey.vim'         " AutoHotKey
	Plug 'PProvost/vim-ps1'               " Powershell
	" Colorschemes
	Plug 'morhetz/gruvbox'
	call plug#end()
	" Plugin options
	" Airline
	let g:airline_powerline_fonts = 0
	let g:airline_symbols_ascii   = 1
	" Bufferline
	let g:bufferline_echo        = 0
	let g:bufferline_pathshorten = 1
	let g:bufferline_fname_mod   = ':~'
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

" try to use gruvbox, if installed
try
	colorscheme gruvbox
" otherwise, use a basic colorscheme
catch /^Vim\%((\a\+)\)\=:E185/
	hi clear
	hi LineNr     cterm=none    ctermfg=8
	hi Comment    cterm=none    ctermfg=8
	hi cComment   cterm=none    ctermfg=8
	hi StatusLine cterm=reverse ctermfg=8
endtry

if has("gui_running")
	set guifont=IBM\ Plex\ Mono\ Medium\ 11
	set guioptions-=m  " menu bar
	set guioptions-=T  " toolbar
	set guioptions-=r  " right scrollbar
	set guioptions-=L  " left scrollbar
	hi Comment gui=bold
else
	" enable transparency
	hi Normal guibg=NONE ctermbg=NONE
endif

if has("nvim")
	" Disable cursor switching
	set guicursor=
endif
" }}}
" Autocmd/File type options {{{
if has("autocmd")
	" automatically mkview/loadview
	" au BufWinLeave *.* mkview
	" au BufWinEnter *.* silent loadview

	aug c
		au FileType c    nnoremap <F2> :!cc % -fsyntax-only -Wall -Wextra -pedantic<CR>
		au FileType cpp  nnoremap <F2> :!c++ % -fsyntax-only -Wall -Wextra -pedantic<CR>
		au FileType make nnoremap <F2> :!make<CR>
	aug end

	aug sh
		au FileType sh nnoremap <F2> :!shellcheck %<CR>
	aug end

	aug python
		au FileType python nnoremap <F2> :!python -i %<CR>
	aug end

	aug haskell
		au FileType haskell setlocal ts=2 sts=2 sw=2 expandtab
		au FileType haskell nnoremap <F2>  :!ghci %<CR>
	aug end

	aug markdown
		au FileType markdown setlocal ts=2 sw=2 sts=2 expandtab spell
	aug end

	" use marker folds in these files
	aug vim
		au FileType vim  setlocal foldmethod=marker " vim scripts
		au FileType zsh  setlocal foldmethod=marker " zsh scripts
		au FileType tmux setlocal foldmethod=marker " tmux confs
		au BufRead,BufNewFile config.h setlocal foldmethod=marker " st config
	aug end

	" automatically reload vimrc
	" aug vimrc_reload
	" 	au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC
	" aug end

	" open help to the right
	aug vim_help
		au FileType help wincmd L
	aug end
endif
" }}}
" Functions {{{
" toggle between light/dark themes
function! SetColor()
	if (&background == "light")
		set background=dark
	else
		set background=light
	endif
endfunction

" toggle 80 column ruler
function! ToggleColumn()
	if (&colorcolumn == 0)
		set colorcolumn=80
	else
		set colorcolumn=0
	endif
endfunction

function! ToggleFoldMarker()
	if (&foldmethod != "marker")
		set foldmethod=marker
		norm zM
	else
		set foldmethod=manual
		norm zR
	endif
endfunction

function! Shell()
	if has("gui_running")
		term
	else
		shell
	endif
endfunction

command! SetColor call SetColor()
command! ToggleColumn call ToggleColumn()
command! ToggleFoldMarker call ToggleFoldMarker()
command! Shell call Shell()
" }}}
" Keybindings {{{
" Unmap
imap <F1> <nop>
" Leader keys
let mapleader = "\<Space>"
nnoremap <Leader>; :noh<CR>
nnoremap <Leader>W :w !sudo tee %<CR>
nnoremap <Leader>d "_d
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
" Function keys
nnoremap <F1>  :Shell<CR>
nnoremap <F3>  :bprev!<CR>
nnoremap <F4>  :bnext!<CR>
nnoremap <F5>  :so ~/.vimrc<CR>
nnoremap <F6>  :bdelete<CR>
nnoremap <F8>  :!make<CR>
nnoremap <F9>  :!python<CR>
nnoremap <expr> <F10> &foldlevel ? 'zM' : 'zR'
nnoremap <F11> :SetColor<CR>
nnoremap <F12> :PlugIn<CR>
" Control keys
nnoremap <C-x> :enew<CR>
nnoremap <C-o> :Files .<CR>
nnoremap <C-g> :GFiles .<CR>
" }}}
