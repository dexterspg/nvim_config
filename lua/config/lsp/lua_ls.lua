
local nvim_data = vim.fn.stdpath("data")
local mason_path = nvim_data .. '/mason/bin'

return {
    cmd = { mason_path .. "/lua-language-server.cmd", "--stdio" },
    filetypes = { "lua" },
    root_markers = {
        ".git",
        "luarc.json",
    },
    -- settings = {
    --     Lua = {
    --         runtime = {
    --             version = 'LuaJIT',
    --         },
    --         diagnostics = {
    --             globals = { 'vim' }, -- ✅ let the server know 'vim' is a global
    --         },
    --         workspace = {
    --             library = vim.api.nvim_get_runtime_file("", true),
    --             checkThirdParty = false,
    --         },
    --         telemetry = { enable = false },
    --     },
    -- },
    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning
} 
