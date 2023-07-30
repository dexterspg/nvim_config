
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd[[packadd packer.nvim]]

-- Configure plugins using Packer
return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'vim-airline/vim-airline'
	use 'preservim/nerdtree'
	use {
			  'nvim-telescope/telescope.nvim', tag = '0.1.1',
		--	 or                            , branch = '0.1.x',
			  requires = { {'nvim-lua/plenary.nvim'} }
			}
		-- use 'BurntSushi/ripgrep'
		-- LSP plugin for Java
		--  use 'mfussenegger/nvim-jdtls'

		use {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			'neovim/nvim-lspconfig',
		}
		-- Autocompletion plugin
		use 'hrsh7th/nvim-cmp'
		use 'hrsh7th/cmp-nvim-lsp'
		use 'hrsh7th/cmp-buffer'

		use ( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'} 
		)
		use('nvim-treesitter/playground')
		use('ThePrimeagen/harpoon')

		use 'nvim-treesitter/nvim-treesitter-textobjects'
		use 'windwp/nvim-ts-autotag'
		use 'mattn/emmet-vim'

	end)

