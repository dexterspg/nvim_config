require 'nvim-treesitter.install'.compilers = { 'zig' }

local ok, ts = pcall(require, 'nvim-treesitter.configs')
if not ok then return end

ts.setup {
  ensure_installed = { "c", "vim", "lua", "vimdoc",  "javascript", "typescript", "css", "java", "html", "python"  },
  sync_install = false,
  ignore_install = { " " },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  autotag = {
    enable = true,
	enable_rename =true,
	enable_close =true,
	enable_close_on_slash=true,
    filetypes = { "html", "xml", "vue", "typescript" },
  },
  indent = {enable = true},

	

  --[[incremental_selection = {
	init_selection = '<c-space>',
	node_incremental = '<c-space>',
	scope_incremental = '<c-s>',
	node_incremental = '<c-backspace>',

  }, ]]
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
