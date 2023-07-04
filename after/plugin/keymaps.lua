local P = {}
-- keymaps = P

local lspconfig = require('lspconfig')

local function map_lsp_keys(opts)
  vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.keymap.set('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.keymap.set('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.keymap.set('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.keymap.set({ 'n', 'v' }, '<space>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.keymap.set('n', '<space>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
end


function P.map_java_keys(bufnr)
    local opts = { buffer = bufnr }
    map_lsp_keys(opts)
    vim.keymap.set('n', '<leader>oi', ':lua require("jdtls").organize_imports()<CR>')
    vim.keymap.set('n', '<leader>jc', ':lua require("jdtls").compile("instrumental")')
    vim.keymap.set('n', 'crv', ':lua require("jdtls").extract_variable()<CR>', opts)
    vim.keymap.set('n', 'crc', ':lua require("jdtls").extract_constant()<CR>', opts)
    vim.keymap.set('n', 'crm', ':lua require("jdtls").extract_method()<CR>', opts)
    print("keymaps map java_keys")
end

return P

