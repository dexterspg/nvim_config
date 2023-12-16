local cmp= require('cmp')
require("luasnip.loaders.from_vscode").lazy_load()
local cmp_select = { behavior = cmp.SelectBehavior.Select}
 cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.select_prev_item(cmp_select),
      ['<C-f>'] = cmp.mapping.select_next_item(cmp_select),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
	snippet ={
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,

	},
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      --{ name = 'vsnip' }, -- For vsnip users.
         { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })
