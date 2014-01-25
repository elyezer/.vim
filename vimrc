" Be iMproved
set nocompatible
filetype off

" Vundle setup
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
filetype plugin indent on

" Bundles to install
Bundle 'MarcWeber/vim-addon-mw-utils.git'
Bundle 'davidhalter/jedi-vim.git'
Bundle 'garbas/vim-snipmate.git'
Bundle 'godlygeek/tabular.git'
Bundle 'hdima/python-syntax.git'
Bundle 'honza/vim-snippets'
Bundle 'jmcantrell/vim-virtualenv.git'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic.git'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tpope/vim-abolish.git'
Bundle 'tpope/vim-commentary.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-repeat.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-tbone.git'
Bundle 'tpope/vim-unimpaired'

" Bundles required by vim-snipmate
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'

" Colorschemes
Bundle 'altercation/vim-colors-solarized.git'

" GUI Options
if has('gui_running')
    set guioptions-=T "Disable toolbar
    set guioptions-=m "Disable menu bar
endif

" Strip trailing whitespace
function! Preserve(command)
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Map to strip trailing whitespace
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>

if has('autocmd')
    "Auto source .vimrc file when save it
    autocmd! BufWritePost .vimrc source $MYVIMRC

    " Strip trailing whitespace on save
    autocmd! BufWritePre * :call Preserve("%s/\\s\\+$//e")

    autocmd FileType css,html setlocal shiftwidth=2 tabstop=2 softtabstop=2

    " Set spell on git commit messages
    autocmd FileType gitcommit setlocal spell
endif

" Fast edit .vimrc file
nmap <leader>e :e! $MYVIMRC<cr>

" Define the colorscheme for syntax highlight
syntax enable
set background=dark
silent! colorscheme solarized

" Automatically load a file changed outside
set autoread

" Enable autoindent
set autoindent

" Backspace configuration
set backspace=eol,start,indent

" Highlight current line
set cursorline

" Always use utf-8
set encoding=utf-8

" Show line numbers
set number

" Enable mouse support in terminal
set mouse=a

" Always show cursor postion
set ruler

" Hide the buffer when abandoned
set hidden

" Keep some lines visible when scrolling
set scrolloff=3

" Show the filename in the window titlebar
set title

" No sounds
set visualbell

" Font type and size
if has('mac')
    set guifont=Monaco:h12
endif

" Tab stuff
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround
set smarttab

" Invisibles
set list "Show invisibles
set listchars=tab:▸\ ,trail:·,eol:¬ "Change tab, trail and eol characters

" Search
set ignorecase
set incsearch
set smartcase

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Open splits at bottom
set splitbelow

" Open vertical splits at right
set splitright

" Smart way to move between buffers
map <M-D-Right> :tabnext<cr>
imap <M-D-Right> <esc>:tabnext<cr>a
map <M-D-Left> :tabprevious<cr>
imap <M-D-Left> <esc>:tabprevious<cr>a

" Always show status line
set laststatus=2

" Enable omnicomplete
set completeopt=menu,menuone,preview "Show the menu when have only one complete option

" Map omnicomplete shortcut
inoremap <C-Space> <C-x><C-o>

" Change backup directory
set backupdir=~/.tmp

" Change the directory of swp files
set directory=~/.tmp

" Syntastic options
" -----------------

" Check syntax on open
let g:syntastic_check_on_open=1

" Checkers for Python
let g:syntastic_python_checkers=['pylint', 'pep8', 'python']

" Python syntax options
" ---------------------

" Enable all syntax highlighting features
let python_highlight_all=1
