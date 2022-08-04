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
    config = function()
      local ls = require('luasnip')
      ls.filetype_extend("all", { "_" })
      require('luasnip.loaders.from_snipmate').lazy_load()
    end
  }
  use 'lukas-reineke/indent-blankline.nvim'
  use 'airblade/vim-gitgutter'
  use 'cohama/lexima.vim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true  },
    config = function()
      require('lualine').setup({
        options = { section_separators = '', component_separators = ''  }
      })
    end
  }
  use 'janko-m/vim-test'
  use 'jmcantrell/vim-virtualenv'
  use 'sheerun/vim-polyglot'
  use 'tpope/vim-abolish'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use {
    'neovim/nvim-lspconfig',
    config = function()
      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lspconfig = require('lspconfig')
      lspconfig.bashls.setup{capabilities = capabilities}
      lspconfig.dockerls.setup{capabilities = capabilities}
      lspconfig.jsonls.setup {capabilities = capabilities}
      lspconfig.pyright.setup{capabilities = capabilities}
      lspconfig.vimls.setup{capabilities = capabilities}
      lspconfig.yamlls.setup{capabilities = capabilities}
    end
  }
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp'
  use {
    'hrsh7th/nvim-cmp',
    config = function()
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
    end
  }
  use 'saadparwaiz1/cmp_luasnip'

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = 'nvim-treesitter/nvim-treesitter-textobjects',
    run = ':TSUpdate',
    config = function()
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
    end
  }

  -- Colorschemes
  use 'gruvbox-community/gruvbox'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
