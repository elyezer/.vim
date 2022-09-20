local opt = vim.opt
local fn = vim.fn

-- Highlight current line
opt.cursorline = true

-- Show line numbers
opt.number = true

-- Show relative line numbers
opt.relativenumber = true

-- Enable mouse support in terminal
opt.mouse = a

-- Keep some lines visible when scrolling
opt.scrolloff = 3

-- Maximum width of text that is being inserted
opt.textwidth = 79

-- Show the filename in the window titlebar
opt.title = true

-- Tab stuff
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.shiftround = true

-- Invisibles
opt.list = true -- Show invisibles
opt.listchars = {tab = '▸ ', trail = '·', eol = '¬'} -- Change tab, trail and eol characters

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true -- Add g flag by default

-- Wildcard command-line completion
opt.wildmode = 'list:longest' -- Complete only until point of ambiguity.

-- Open splits at bottom
opt.splitbelow = true

-- Open vertical splits at right
opt.splitright = true

-- Show global status line
opt.laststatus = 3

-- opt.completeopt
opt.completeopt = {'menu', 'menuone', 'noselect'}

-- Faster and improved grep using either rg or ag (The Silver Searcher)
if fn.executable('rg') then
  opt.grepprg = 'rg --vimgrep $*'
  opt.grepformat = '%f:%l:%c:%m'
elseif fn.executable('ag') then
  opt.grepprg = 'ag --vimgrep $*'
  opt.grepformat = '%f:%l:%c:%m'
end
