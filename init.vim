let s:plug_path = '~/.local/share/nvim/site/autoload/plug.vim'
let s:plugged_path = '~/.local/share/nvim/plugged'
let g:python_host_prog = '/usr/bin/python3'
let g:python3_host_prog = '/usr/bin/python3'

if !filereadable(expand(s:plug_path))
    echo 'Installing vim-plug...'
    echo ''
    execute "silent !curl -fLo " . s:plug_path . " --create-dirs "
        \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    " Install plugins after loading vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin(s:plugged_path)

" Bundles to install
Plug 'L3MON4D3/LuaSnip'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'cohama/lexima.vim'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'janko-m/vim-test'
Plug 'jmcantrell/vim-virtualenv'
Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.py' }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'


Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Colorschemes
Plug 'gruvbox-community/gruvbox'


call plug#end()

" GUI Options
if has('gui_running')
    if has('gui_gtk3')
        set guifont=Source\ Code\ Pro\ for\ Powerline\ 13
    endif
    set guioptions-=T "Disable toolbar
    set guioptions-=m "Disable menu bar
    set shell=/bin/bash
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

" Identify gohtmltmpl files
func FTgohtmltmpl()
  let n = 1
  while n < 10 && n <= line("$")
    if getline(n) =~ '{{-\?\s*\(partial\|template\|block\|define\|if\|with\)\>\|{{\/\*\s\+'
      setfiletype gohtmltmpl
      return
    endif
    let n = n + 1
  endwhile
  setfiletype FALLBACK html
endfunc

if has('autocmd')
    "Auto source .vimrc file when save it
    autocmd! BufWritePost init.vim source $MYVIMRC

    " Identify gohtmltmpl files
    autocmd! BufNewFile,BufRead *.html call FTgohtmltmpl()

    " Strip trailing whitespace on save
    autocmd! BufWritePre * :call Preserve("%s/\\s\\+$//e")

    autocmd FileType css,html,gohtmltmpl,htmldjango,json setlocal shiftwidth=2 tabstop=2 softtabstop=2

    " Set spell for some file types
    autocmd FileType gitcommit,md,rst setlocal spell
endif

" Fast edit .vimrc file
nmap <leader>e :e! $MYVIMRC<cr>

" Define the colorscheme for syntax highlight
syntax enable
set background=dark
silent! colorscheme gruvbox

highlight! link TermCursor Cursor
highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15

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

" Set completeopt
set completeopt=menu,menuone,noselect

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

" Faster and improved grep using either rg or ag (The Silver Searcher)
if executable('rg')
    set grepprg=rg\ --vimgrep\ $*
    set grepformat=%f:%l:%c:%m
elseif executable('ag')
    set grepprg=ag\ --vimgrep\ $*
    set grepformat=%f:%l:%c:%m
endif

" Mappings
" --------

tnoremap <esc> <c-\><c-n>
tnoremap <C-v><esc> <esc>

if executable('uuidgen')
    nnoremap <leader>id :execute 'normal! o' . ':id: ' . system('uuidgen')<esc>ddk==
else
    nnoremap <leader>id :execute 'normal! o' . ':id: ' . system('python3 -c "import uuid; print(str(uuid.uuid4()))"')<esc>ddk==
endif

" Plug options
" ------------

" Command to open plug window
let g:plug_window='botright new'

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
      \ 'component': {
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")&&strlen(fugitive#head())?'.
      \               '"\ue0a0 ".fugitive#head():""}',
      \ },
      \ 'component_visible_condition': {
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
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

" Fuzzy finder options
" --------------------

" mappings
nnoremap <C-p> :Telescope find_files<cr>

" vim-test options
" ----------------

" Prefer pytest whenever it is available
if executable('py.test')
    let test#python#runner = 'pytest'
    let test#python#pytest#options = '-v'
endif

" mappings
nnoremap tf :TestFile<cr>
nnoremap tl :TestLast<cr>
nnoremap tn :TestNearest<cr>
nnoremap ts :TestSuite<cr>
nnoremap tv :TestVisit<cr>

" lspconfig
" ---------
lua << EOF
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')
lspconfig.bashls.setup{capabilities = capabilities}
lspconfig.dockerls.setup{capabilities = capabilities}
lspconfig.jsonls.setup {capabilities = capabilities}
lspconfig.pyright.setup{capabilities = capabilities}
lspconfig.vimls.setup{capabilities = capabilities}
lspconfig.yamlls.setup{capabilities = capabilities}
EOF

if filereadable(expand('~/code/groovy-language-server/build/libs/groovy-language-server-all.jar'))
lua << EOF
groovyls_path = vim.api.nvim_call_function('expand', {'~/code/groovy-language-server/build/libs/groovy-language-server-all.jar'})
require('lspconfig').groovyls.setup{
    cmd = { "java", "-jar", groovyls_path},
}
EOF
endif

" vim-markdown options
" --------------------
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" LuaSnip
" -------
lua << EOF
local ls = require('luasnip')
ls.filetype_extend("all", { "_" })
require('luasnip.loaders.from_snipmate').lazy_load()
EOF

" nvim-cmp
" ----------
lua << EOF
local cmp = require('cmp')
cmp.setup ({
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  experimental = {
    ghost_text = true,
  },
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true  }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    {
        name = 'buffer',
        keyword_length = 3,
    },
  }),
})
EOF

" nvim-treesitter options
" -----------------------
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "bash", "python", "toml", "yaml" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",

      },
    },
  },
}
EOF
