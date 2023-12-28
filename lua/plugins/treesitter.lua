return {
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/playground',
    dependencies = {
        {
            'windwp/nvim-ts-autotag',
            event = "LazyFile"
        },
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context'
    },
    build = ":TSUpdate",
    event = { "LazyFile", "VeryLazy" },
    config = function()
        require 'nvim-treesitter.install'.compilers = { 'zig' }

        local ok, ts = pcall(require, 'nvim-treesitter.configs')
        if not ok then return end

        ts.setup {
            ensure_installed = { "c", "vim", "lua", "vimdoc", "javascript", "typescript", "css", "java", "html", "python", "vue" },
            sync_install = false,
            ignore_install = { " " },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            autotag = {
                enable = true,
                enable_rename = true,
                enable_close = true,
                enable_close_on_slash = true,
                filetypes = { "html", "xml", "vue", "typescript" },
            },
            indent = { enable = true },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<C-Space>',
                    node_incremental = '<C-Space>',
                    scope_incremental = '<C-s>',
                    node_decremental = '<BS>' },

            },
            --[=[
textobjects = {
     select = {
		enable = true,
	 	lookahead = true,
		keymaps = {
			['aa'] = '@parameter.outer',
			['ia'] = '@parameter.inner',
			['af'] = '@functio.outer',
			['if'] = '@function.inner',
			['ac'] = '@class.outer',
			['ic'] = '@class.inner',
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
			[']m'] = '@function.outer',
			[']]'] = '@class.outer',
			},
			goto_next_end = {
			[']M'] = '@function.outer',
			[']['] = '@class.outer',
			},
			goto_previous_start = {
			['[m'] = '@function.outer',
			['[['] = '@class.outer',
			},
			goto_previous_end  = {
			[']M'] = '@function.outer',
			['[]'] = '@class.outer',
			},
		},
	   swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },		
  },
  ]=]
        }

        require'treesitter-context'.setup {

        }
    end,
    keys = {
        { "<c-space>", desc = "Increment selection" },
        { "<bs>",      desc = "Decrement selection", mode = "x" },
    }
}
