local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup()
mason_lspconfig.setup({
	  ensure_installed = { "jdtls", "html", "jsonls", "tsserver", "lua_ls", "volar", "cssls", "pyright"}

})



