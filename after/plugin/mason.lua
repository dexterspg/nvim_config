local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup()
local install_path = vim.fn.stdpath('data') .. "/mason"

mason_lspconfig.setup({

	 ensure_installed = { "html", "jsonls", "tsserver", "lua_ls", "volar", "cssls", "pyright"}

})



