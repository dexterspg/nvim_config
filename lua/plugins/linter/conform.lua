return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				vue = { { "prettierd", "prettier" } },
				-- java = { "google-java-format" },

				html = { "htmlbeautifier" },
				-- bash = { "beautysh" },
				css = { { "prettierd", "prettier" } },
				scss = { { "prettierd", "prettier" } },
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>ll", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 2000,
			})
			require("lint").try_lint()
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
