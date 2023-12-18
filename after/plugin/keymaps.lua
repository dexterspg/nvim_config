local M = {}
-- keymaps = P

local lspconfig = require('lspconfig')
opts = { noremap = true, silent = true }

function M.map_lsp_keys()
	-- Enable completion triggered by <c-x><c-o>
	--vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
	-- Buffer local mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	-- local opts = { buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
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
	vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
end

function M.map_java_keys()
	print("calling map_java keys")
	M.map_lsp_keys()

	local spring_boot_run = 'mvn spring-boot:run -Dspring-boot.run.profiles=local'
	local command = ':lua require("toggleterm").exec("' .. spring_boot_run .. '")<CR>'
	vim.keymap.set('n', '<leader>sr', command)

	vim.keymap.set('n', '<leader>oi', ':lua require("jdtls").organize_imports()<CR>')
	vim.keymap.set('n', '<leader>jc', ':lua require("jdtls").compile("instrumental")')
	vim.keymap.set({ 'v', 'n' }, '<leader>cev', ':lua require("jdtls").extract_variable()<CR>', opts)
	vim.keymap.set({ 'v', 'n' }, '<leader>cec', ':lua require("jdtls").extract_constant()<CR>', opts)
	vim.keymap.set({ 'v', 'n' }, '<leader>cem', ':lua require("jdtls").extract_method()<CR>', opts)
end

function M.map_python_keys()
	-- local opts = { buffer = bufnr }
	M.map_lsp_keys()
end

return M
