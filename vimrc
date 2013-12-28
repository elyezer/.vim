" Be iMproved
set nocompatible
filetype off

" Vundle setup
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
filetype plugin indent on

" Bundles to install
Bundle 'godlygeek/tabular.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-surround.git'

" Colorschemes
Bundle 'altercation/vim-colors-solarized.git'

" GUI Options
if has("gui_running")
    set guioptions-=T "Disable toolbar
    set guioptions-=m "Disable menu bar
endif

if has("autocmd")
    "Auto source .vimrc file when save it
    autocmd! BufWritePost .vimrc source $MYVIMRC

    "In python files use spaces intead of tabs
    autocmd FileType python setlocal expandtab

    autocmd FileType css,html setlocal expandtab shiftwidth=2 tabstop=2
                                       \ softtabstop=2
endif

" Fast edit .vimrc file
nmap <leader>e :e! $MYVIMRC<cr>

" Define the colorscheme for syntax highlight
syntax enable
set background=dark
silent! colorscheme solarized

" Enable autoindent
set autoindent

" Highlight current line
set cursorline

" Show line numbers
set number

" Backspace configuration
set backspace=eol,start,indent

" Always show cursor postion
set ruler

" Hide the buffer when abandoned
set hidden

" Font type and size
if has("mac")
    set guifont=Monaco:h12
endif

" Tab stuff
set tabstop=4
set softtabstop=4
set shiftwidth=4
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
