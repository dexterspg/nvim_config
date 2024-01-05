
vim.keymap.set("n", "<leader><leader>", "<CMD>Oil<CR>", {desc = "Open parent directory" } )

return {
	'stevearc/oil.nvim',
    config = function()
        require("oil").setup()
    end
}
