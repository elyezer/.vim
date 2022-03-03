local opt = vim.opt
local fn = vim.fn

-- Automatically load a file changed outside
opt.autoread = true

-- Enable autoindent
opt.autoindent = true

-- Backspace configuration
opt.backspace = {'eol', 'start', 'indent'}

-- Highlight current line
opt.cursorline = true

-- Always use utf-8
opt.encoding = 'utf-8'

-- Show line numbers
opt.number = true

-- Show relative line numbers
opt.relativenumber = true

-- Enable mouse support in terminal
opt.mouse = a

-- Always show cursor postion
opt.ruler = true

-- Hide the buffer when abandoned
opt.hidden = true

-- Keep some lines visible when scrolling
opt.scrolloff = 3

-- Maximum width of text that is being inserted
opt.textwidth = 79

-- Show the filename in the window titlebar
opt.title = true

-- No sounds
opt.visualbell = true

-- Tab stuff
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.shiftround = true
opt.smarttab = true

-- Invisibles
opt.list = true -- Show invisibles
opt.listchars = {tab = '▸ ', trail = '·', eol = '¬'} -- Change tab, trail and eol characters

-- Search
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true
opt.gdefault = true -- Add g flag by default

-- Wildcard command-line completion
opt.wildmenu = true -- Show completions above the command-line
opt.wildmode = 'list:longest' -- Complete only until point of ambiguity.

-- Open splits at bottom
opt.splitbelow = true

-- Open vertical splits at right
opt.splitright = true

-- Always show status line
opt.laststatus = 2

-- opt.completeopt
opt.completeopt = {'menu', 'menuone', 'noselect'}

-- Change backup directory
opt.backupdir = '~/.tmp'

-- Change the directory of swp files
opt.directory = '~/.tmp'

-- Faster and improved grep using either rg or ag (The Silver Searcher)
if fn.executable('rg') then
    opt.grepprg = 'rg --vimgrep $*'
    opt.grepformat = '%f:%l:%c:%m'
elseif fn.executable('ag') then
    opt.grepprg = 'ag --vimgrep $*'
    opt.grepformat = '%f:%l:%c:%m'
end
