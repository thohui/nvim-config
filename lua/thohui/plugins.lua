local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()


return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  --Autopairs
  use 'windwp/nvim-autopairs' 

  --Themes
  use {'catppuccin/nvim', as = 'catppuccin'}

  --Treesitter
  use { 'nvim-treesitter/nvim-treesitter' }
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("nvim-treesitter/nvim-treesitter-context")
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  --Markdown preview
  use 'ellisonleao/glow.nvim'

  --Language packs
  use 'sheerun/vim-polyglot'

  --Comment
  use 'numToStr/Comment.nvim'

  -- LSP
  use 'jose-elias-alvarez/null-ls.nvim' 
  use 'williamboman/mason.nvim'
  use("williamboman/mason-lspconfig.nvim")

  --LSP autocomplete
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
 
  --file tree
  use 'kyazdani42/nvim-tree.lua'

  -- Rust Dev
  use 'simrat39/rust-tools.nvim'

  --Buffer navigation
  use 'nvim-lualine/lualine.nvim'
  use {'romgrk/barbar.nvim', requires = 'nvim-web-devicons'}

  --terminal
  use 'NvChad/nvterm'
  --Grammar checking because I can't english
  use 'rhysd/vim-grammarous'

  --Telescope Requirements
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  --Telescope
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-telescope/telescope-file-browser.nvim'

  --devicons
  use 'kyazdani42/nvim-web-devicons'

  if packer_bootstrap then
      require('packer').sync()
  end
end)
