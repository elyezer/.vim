if has('vim_starting')
    " Be iMproved
    set nocompatible
endif

if !filereadable(expand('~/.vim/autoload/plug.vim'))
    echo 'Installing vim-plug...'
    echo ''
    silent !curl -fLso ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    " Install plugins after loading vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

" Bundles to install
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'davidhalter/jedi-vim'
Plug 'godlygeek/tabular'
Plug 'hdima/python-syntax'
Plug 'honza/vim-snippets'
Plug 'hynek/vim-python-pep8-indent'
Plug 'itchyny/lightline.vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'mattn/gist-vim'
Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.py' }
Plug 'scrooloose/syntastic'
Plug 'terryma/vim-multiple-cursors'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'

" Bundle required by gist-vim bundle
Plug 'mattn/webapi-vim'

" Colorschemes
Plug 'altercation/vim-colors-solarized'

call plug#end()

" GUI Options
if has('gui_running')
    set guifont=Source\ Code\ Pro\ for\ Powerline:h13
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
    autocmd FileType rst setlocal spell
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

" Show relative line numbers
set relativenumber

" Enable mouse support in terminal
set mouse=a

" Always show cursor postion
set ruler

" Hide the buffer when abandoned
set hidden

" Keep some lines visible when scrolling
set scrolloff=3

" Maximum width of text that is being inserted
set textwidth=79

" Show the filename in the window titlebar
set title

" No sounds
set visualbell

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

" Faster and improved grep using ag (The Silver Searcher)
if executable('ag')
    set grepprg=ag\ --vimgrep\ $*
    set grepformat=%f:%l:%c:%m
endif

" Mappings
" --------

if executable('uuidgen')
    nnoremap <leader>id :execute 'normal! o' . ':id: ' . system('uuidgen')<esc>ddk==
else
    nnoremap <leader>id :execute 'normal! o' . ':id: ' . system('python3 -c "import uuid; print(str(uuid.uuid4()))"')<esc>ddk==
endif

" Plug options
" ------------

" Command to open plug window
let g:plug_window='botright new'

" Syntastic options
" -----------------

" Check syntax on open
let g:syntastic_check_on_open=1

" Don't check syntax when quitting
let g:syntastic_check_on_wq = 0

" Checkers for Python
let g:syntastic_python_checkers=['flake8', 'python']

" Checkers for RST
let g:syntastic_rst_checkers=['rstcheck']

" Syntastic status line text format
let g:syntastic_stl_format = "\u2716 %t"

" Python syntax options
" ---------------------

" Enable all syntax highlighting features
let python_highlight_all=1

" Lightline options
" -----------------

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename', 'syntastic', 'modified' ] ]
      \ },
      \ 'component': {
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")&&strlen(fugitive#head())?'.
      \               '"\ue0a0 ".fugitive#head():""}',
      \ },
      \ 'component_visible_condition': {
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'component_function': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ }

" Ident line options
" ------------------

let g:indentLine_char = '│'

if exists('g:solarized_termcolors')
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
endif

" CtrlP options
" -------------

" Use ag to search for file names
if executable('ag')
    let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif
