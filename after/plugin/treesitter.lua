require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "vim", "lua", "vimdoc",  "javascript", "typescript", "css", "java", "html", "python", "json", "vue"  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  --[[incremental_selection = {
	init_selection = '<c-space>',
	node_incremental = '<c-space>',
	scope_incremental = '<c-s>',
	node_incremental = '<c-backspace>',

  }, ]]
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

  autotag = {
    enable = true,
	enable_rename =true,
	enable_close =true,
	enable_close_on_slash=true,
    filetypes = { "html", "xml", "php", "vue" },
  }
}
