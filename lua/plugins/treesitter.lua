return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/playground',
        'windwp/nvim-ts-autotag',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context'
    },
    build = ":TSUpdate",
    config = function()
        require 'nvim-treesitter.install'.compilers = { 'zig' }

        local ok, ts = pcall(require, 'nvim-treesitter.configs')
        if not ok then return end

        ts.setup {
            ensure_installed = { "c", "query","vim", "lua", "xml",  "javascript", "typescript", "css", "java", "html", "python", "vue" },
            sync_install = false,
            ignore_install = { "vimdoc" },
            auto_install = true,
            highlight = {
                enable = true,
                disable = {""},
                -- additional_vim_regex_highlighting = false,
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
                    init_selection = '<C-s>',
                    node_incremental = '<C-s>',
                    scope_incremental = false,
                    node_decremental = '<bs>' },

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
			[']m'] = '@function.outer',
			[']['] = '@class.outer',
			},
			goto_previous_start = {
			['[m'] = '@function.outer',
			['[['] = '@class.outer',
			},
			goto_previous_end  = {
			[']m'] = '@function.outer',
			['[]'] = '@class.outer',
			},
		},
	   swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>a"] = "@parameter.inner",
        },
      },		
  },
  ]=]
        }

        require 'treesitter-context'.setup {

        }
    end,
}
