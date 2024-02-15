return {
	"rshkarin/mason-nvim-lint",
	dependencies = {
		"mfussenegger/nvim-lint",
	},
	event = {
		"BufReadPre",
		"BufNewFile",
		"BufWritePost",
	},
	config = function()
		local lint = require("lint")
		local mason_linter = require("mason-nvim-lint")

		mason_linter.setup({
			ensure_installed = { "prettier", "eslint_d", "stylua" },
			-- format = true
		})

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			vue = { "eslint_d" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>gf", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
