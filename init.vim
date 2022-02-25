let g:python_host_prog = '/usr/bin/python3'
let g:python3_host_prog = '/usr/bin/python3'

lua require('plugins')

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

" Map omnicomplete shortcut
inoremap <C-Space> <C-x><C-o>

" Create backup directory if not exists
if exists("*mkdir") && empty(glob('~/.tmp'))
    call mkdir($HOME . '/.tmp')
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

" vim-markdown options
" --------------------
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" LuaSnip
" -------
imap <silent><expr> <C-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-j>'
inoremap <silent> <C-k> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <C-j> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <C-k> <cmd>lua require('luasnip').jump(-1)<Cr>

imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'
smap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'
