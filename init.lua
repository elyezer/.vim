require('elyezer.plugins')

-- Define the colorscheme for syntax highlight
vim.cmd('colorscheme gruvbox')

vim.cmd([[
" Identify gohtmltmpl files
function! FTgohtmltmpl()
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

highlight! link TermCursor Cursor
highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
]])

local function bind(op, outer_opts)
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

local nmap = bind("n", {noremap = false})
local imap = bind("i", {noremap = false})
local smap = bind("s", {noremap = false})
local nnoremap = bind("n")
local vnoremap = bind("v")
local xnoremap = bind("x")
local inoremap = bind("i")
local snoremap = bind("s")
local tnoremap = bind("t")

local augroup = vim.api.nvim_create_augroup("elyezer", { clear = true })

-- Auto source .vimrc file when save it
vim.api.nvim_create_autocmd("BufWritePost", { pattern = "init.lua", command = "source $MYVIMRC", group = augroup })

-- Identify gohtmltmpl files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { pattern = "*.html", command = "call FTgohtmltmpl()", group = augroup })

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    group = augroup,
    callback = function ()
        local view = vim.fn.winsaveview()
        vim.cmd("keepjumps keeppatterns silent! %s/\\s\\+$//e")
        vim.fn.winrestview(view)
    end
})

vim.api.nvim_create_autocmd("FileType", { pattern = { "css", "html", "gohtmltmpl", "htmldjango", "json" }, command = "setlocal shiftwidth=2 tabstop=2 softtabstop=2", group = augroup })

-- Set spell for some file types
vim.api.nvim_create_autocmd("FileType", { pattern = { "gitcommit", "md", "rst" }, command = "setlocal spell", group = augroup })

-- Fast edit init.vim, plugins and options files
nmap("<leader>e", ":e! $MYVIMRC<cr>")
nmap("<leader>p", ":execute \"edit! " .. vim.fn.stdpath("config") .. "/lua/elyezer/plugins.lua\"<cr>")
nmap("<leader>o", ":execute \"edit! " .. vim.fn.stdpath("config") .. "/plugin/options.lua\"<cr>")

-- Smart way to move between windows
nmap("<C-j>", "<C-W>j")
nmap("<C-k>", "<C-W>k")
nmap("<C-h>", "<C-W>h")
nmap("<C-l>", "<C-W>l")

-- Smart way to move between buffers
nmap("<M-D-Right>", ":tabnext<cr>")
imap("<M-D-Right>", "<esc>:tabnext<cr>a")
nmap("<M-D-Left>", ":tabprevious<cr>")
imap("<M-D-Left>", "<esc>:tabprevious<cr>a")

-- Map omnicomplete shortcut
inoremap("<C-Space>", "<C-x><C-o>")

-- Create backup directory if not exists
vim.fn.mkdir(vim.fn.glob("$HOME/.tmp"), "p")

-- Mappings
-- --------

tnoremap("<esc>", "<c-\\><c-n>")
tnoremap("<C-v><esc>", "<esc>")

if vim.fn.executable('uuidgen') then
    nnoremap("<leader>id", ":execute 'normal! o' . ':id: ' . system('uuidgen')<esc>ddk==")
else
    nnoremap("<leader>id", ":execute 'normal! o' . ':id: ' . system('python3 -c \"import uuid; print(str(uuid.uuid4()))\"')<esc>ddk==")
end

-- Fuzzy finder options
-- --------------------

-- mappings
nnoremap("<C-p>", ":Telescope find_files<cr>")

-- mappings
nnoremap("tf", ":TestFile<cr>")
nnoremap("tl", ":TestLast<cr>")
nnoremap("tn", ":TestNearest<cr>")
nnoremap("ts", ":TestSuite<cr>")
nnoremap("tv", ":TestVisit<cr>")

-- LuaSnip
-- -------
imap ("<silent><expr> <C-j>", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-j>'")
inoremap("<silent> <C-k>", "<cmd>lua require'luasnip'.jump(-1)<Cr>")
snoremap("<silent> <C-j>", "<cmd>lua require('luasnip').jump(1)<Cr>")
snoremap("<silent> <C-k>", "<cmd>lua require('luasnip').jump(-1)<Cr>")

imap("<silent><expr> <C-l>", "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'")
smap("<silent><expr> <C-l>", "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'")

-- vim-markdown options
-- --------------------
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0

-- Python syntax options
-- ---------------------

-- Enable all syntax highlighting features
vim.g.python_highlight_all = 1

-- vim-test options
-- ----------------

-- Prefer pytest whenever it is available
if vim.fn.executable('pytest') or vim.fn.executable('py.test') then
    vim.g["test#python#runner"] = "pytest"
    vim.g["test#python#pytest#options"] = "-v"
end
