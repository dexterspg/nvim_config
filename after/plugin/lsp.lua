local constants = require("dexter.constants").get_constants('ubuntu')
local lspconfig = require("lspconfig")
local cmp= require('cmp')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local path_to_python = constants.path_to_python
local path_to_lua = 'C:/Program Files (x86)/Lua/5.1/lua.exe'


local cmp_select = { behavior = cmp.SelectBehavior.Select}
 cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
      ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })
 

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Buffer local mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, Lopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format { async = true }
  end, opts)

  -- Additional key mappings for diagnostics
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
end


lspconfig.tsserver.setup{
	filetypes = { "javascript", "typescript", "typescriptreact", "typescipt.tsx"},
    root_dir = function() return vim.loop.cwd() end,
	on_attach = on_attach,
	capabilities = capabilities
}

lspconfig.lua_ls.setup{
	filetypes = { "lua"},
	on_attach = on_attach,
	capabilities = capabilities,
    root_dir = function() return vim.loop.cwd() end , 

	settings  = {
		Lua = {
			runtime = {
				version = 'luaJIT'	
			},

			diagnostics = {
				globals = {'vim'}
			}, 

		}

	}

} 

lspconfig.html.setup{
 filetypes = { "html", "htmldjango", "mason"},
 init_options ={
    configurationSection = { "html", "css", "javascript"},
	embeddedLanguages = {
        css= true,
		javascript = true
	},
},

    root_dir = function() return vim.loop.cwd() end,
	on_attach = on_attach,
    capabilities = capabilities
 }

lspconfig.pyright.setup{
    root_dir = function() return vim.loop.cwd() end,
	on_attach = on_attach,
	capabilities = capabilities,
    
	settings = {
		python = {
			pythonPath = path_to_python
		}
	}
}

lspconfig.cssls.setup{
    root_dir = function() return vim.loop.cwd() end,
	on_attach = on_attach,
	capabilities = capabilities,
}

lspconfig.jsonls.setup{
    root_dir = function() return vim.loop.cwd() end,
	on_attach = on_attach,
	capabilities = capabilities,
	}

lspconfig.volar.setup{
    root_dir = function() return vim.loop.cwd() end,
	on_attach = on_attach,
	capabilities = capabilities,
	}


