vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opts = { noremap = true, silent = true}
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end
nvim_tree.setup {
	hijack_cursor = true,
	update_focused_file = {
		enable = true,
		update_cwd = false,
	},
	renderer = {
		root_folder_modifier = ":t",
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_closed = "",
					arrow_open = "",
					default = "",
					empty = "",
					open = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				 git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					untracked = "U",
					deleted = "",
					ignored = "◌",
				}, 
			},
		},
		highlight_git = true,
		highlight_opened_files ="all"
	},

	diagnostics = {
		enable = true,
		show_on_dirs = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},

	view = {
		width = 30,
		side = 'left',
		adaptive_size = true,

	},

	actions = {
		open_file ={
			quit_on_open = true, -- not working 
		}
	}
}

vim.keymap.set('n', '<leader>n', ':NvimTreeFindFileToggle<CR>', opts)

