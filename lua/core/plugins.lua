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


plugins = {

--  'wbthomason/packer.nvim',
  'stevearc/oil.nvim',
  'vim-airline/vim-airline',
  'preservim/nerdtree',
  {
  'nvim-telescope/telescope.nvim', 
  tag = '0.1.1',
  dependencies = { {'nvim-lua/plenary.nvim'} }
  },
  'BurntSushi/ripgrep',
  'mfussenegger/nvim-jdtls',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  -- Autocompletion plugin
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',

  'nvim-treesitter/nvim-treesitter',
   
  'nvim-treesitter/playground',
  'ThePrimeagen/harpoon',

  'nvim-treesitter/nvim-treesitter-textobjects',
  'windwp/nvim-ts-autotag',
  'mattn/emmet-vim',
  
  -- {'akinsho/toggleterm.nvim', version = "*", config = true},
 'akinsho/toggleterm.nvim',

  -- colorscheme
  {
	  'folke/tokyonight.nvim',  
       config  = function() vim.cmd('colorscheme tokyonight-moon') end
  },
  'rebelot/kanagawa.nvim',
  'ellisonleao/gruvbox.nvim',
  'xiyaowong/transparent.nvim'



}

local opts = {}
require("lazy").setup(plugins, opts)
