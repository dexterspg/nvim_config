vim.cmd[[packadd packer.nvim]]

-- Configure plugins using Packer
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'vim-airline/vim-airline'
  use 'preservim/nerdtree'
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	-- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}
  use 'BurntSushi/ripgrep'
   -- LSP plugin for Java
  use 'mfussenegger/nvim-jdtls'

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
 --[[ use  {
    'windwp/nvim-ts-autotag',
  dependencies = "nvim-treesitter/nvim-treesitter",	
    config = function()
      require('nvim-ts-autotag').setup({
        filetypes = { "html" , "xml" }
      })
    end
}
]]--

  use 'windwp/nvim-ts-autotag'
  use 'mattn/emmet-vim'
--[[ 
   use {
        'barrett-ruth/live-server.nvim',
        config = function()
	       require('live-server').setup {
			  port = 8080, -- Set the server port
			  host = '127.0.0.1', -- Set the server host
			  open = true, -- Don't automatically open the server URL in the browser
			  mount = {'C:/Users/dexte/practice_vue'}, -- Specify adjk ditional directories to serve
			  file = {}, -- Specify additional files to serve
			  log = false, -- Disable server logging
			}
        end
    } 
    ]]-- 

--  use {'neoclide/coc.nvim', branch = 'release'}
end)

