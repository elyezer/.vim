" Be iMproved
set nocompatible
filetype off

" Vundle setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Bundles to install
Plugin 'SirVer/ultisnips'
Plugin 'Yggdroot/indentLine'
Plugin 'airblade/vim-gitgutter'
Plugin 'davidhalter/jedi-vim'
Plugin 'godlygeek/tabular'
Plugin 'hdima/python-syntax'
Plugin 'honza/vim-snippets'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'itchyny/lightline.vim'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/gist-vim'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-tbone'
Plugin 'tpope/vim-unimpaired'

" Bundle required by gist-vim bundle
Plugin 'mattn/webapi-vim'

" Colorschemes
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin indent on

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

    " Better editing options for reStructuredText files
    autocmd FileType rst setlocal spell textwidth=79
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
set gdefault " Add g flag by default

" Wildcard command-line completion
set wildmenu " Show completions above the command-line
set wildmode=list:longest " Complete only until point of ambiguity.

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

" Create backup directory if not exists
if exists("*mkdir") && empty(glob('~/.tmp'))
    call mkdir($HOME . '/.tmp')
endif

" Change backup directory
set backupdir=~/.tmp

" Change the directory of swp files
set directory=~/.tmp

" Syntastic options
" -----------------

" Check syntax on open
let g:syntastic_check_on_open=1

" Checkers for Python
let g:syntastic_python_checkers=['flake8', 'pylint', 'python']

" Python syntax options
" ---------------------

" Enable all syntax highlighting features
let python_highlight_all=1

" Lightline options
" -----------------

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename', 'modified' ] ]
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
      \ 'component': {
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")&&strlen(fugitive#head())?'.
      \               '"\ue0a0 ".fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ }

" Ident line options
" ------------------

let g:indentLine_char = '│'

if &background == "dark"
    if g:solarized_termcolors == 256
        let g:indentLine_color_term=235
    else
        let g:indentLine_color_term=0
    endif
else
    if g:solarized_termcolors == 256
        let g:indentLine_color_term=187
    else
        let g:indentLine_color_term=7
    endif
endif
