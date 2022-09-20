local fn = vim.fn
local cmd = vim.cmd
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  cmd('packadd packer.nvim')
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'L3MON4D3/LuaSnip',
    requires = 'honza/vim-snippets',
  }
  use 'lukas-reineke/indent-blankline.nvim'
  use 'airblade/vim-gitgutter'
  use 'cohama/lexima.vim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true  },
  }
  use 'janko-m/vim-test'
  use 'jmcantrell/vim-virtualenv'
  use 'sheerun/vim-polyglot'
  use 'tpope/vim-abolish'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'numToStr/Comment.nvim'
  use 'neovim/nvim-lspconfig'

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim',
    },
  }

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = 'nvim-treesitter/nvim-treesitter-textobjects',
    run = ':TSUpdate',
  }

  -- Colorschemes
  use 'gruvbox-community/gruvbox'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
