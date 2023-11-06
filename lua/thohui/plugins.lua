local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  --Autopairs
  'windwp/nvim-autopairs',

  --Themes
  {'catppuccin/nvim', name = 'catppuccin'},
  {
    'folke/tokyonight.nvim',
    name = 'tokyonight',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  --Treesitter
  'nvim-treesitter/nvim-treesitter',
  'nvim-treesitter/nvim-treesitter-textobjects',
  'nvim-treesitter/nvim-treesitter-context',
  'JoosepAlviste/nvim-ts-context-commentstring',

  --Markdown preview
  'ellisonleao/glow.nvim',

  --Language packs
  'sheerun/vim-polyglot',

  --Comment
  'numToStr/Comment.nvim',

  -- LSP
  'jose-elias-alvarez/null-ls.nvim',
  {'williamboman/mason.nvim', dependencies = {'williamboman/mason-lspconfig.nvim'} },

  --LSP autocomplete
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  --'L3MON4D3/LuaSnip',
  --'saadparwaiz1/cmp_luasnip',
  'neovim/nvim-lspconfig',
  'williamboman/nvim-lsp-installer',
 
  --file tree
  {'kyazdani42/nvim-tree.lua', name = 'nvim-tree'},

  -- Rust Dev
  'simrat39/rust-tools.nvim',

  --Buffer navigation
  'nvim-lualine/lualine.nvim',
  {'romgrk/barbar.nvim', dependencies = {'nvim-web-devicons'} },

  --Telescope Requirements
  'nvim-lua/popup.nvim',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',

  --Telescope
  {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  'nvim-telescope/telescope-file-browser.nvim',

  --devicons
  'kyazdani42/nvim-web-devicons'
})

