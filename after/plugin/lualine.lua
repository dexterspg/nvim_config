local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
		return
end

local branch = {
		"branch",
		icons_enabled = true,
		icon = "",
}

local diagnostics = {
		"diagnostics",
		sources = { "nvim_diagnostic" },
		sections = { "error", "warn" },
		symbols = { error = " ", warn = " " },
		colored = true,
		update_in_insert = false,
		always_visible = true,
}



lualine.setup {
	  options = {
		    icons_enabled = false,
		    --theme = 'auto',
		    theme = 'auto',
			component_separators = { left = '', right = ''},
		    section_separators = { left = '', right = ''},
		    disabled_filetypes = {
			      statusline = {},
			      winbar = {},
			    },
		    ignore_focus = {},
		    always_divide_middle = true,
		    globalstatus = false,
		    refresh = {
			      tabline = 1000,
			      statusline = 1000,
			      winbar = 1000,
			    }
		  },
	  sections = {
		    lualine_a = {'mode'},
		    lualine_b = { branch, 'diff', diagnostics},
		    lualine_c = {'filename'},
		    lualine_x = {'encoding', 'fileformat', 'filetype'},
		    lualine_y = {'progress'},
		    lualine_z = {'location'}
		  },
	  inactive_sections = {
		    lualine_a = {},
		    lualine_b = {},
		    lualine_c = {'filename'},
		    lualine_x = {'location'},
		    lualine_y = {},
		    lualine_z = {}
		  },
	  tabline = {},
	  winbar = {},
	  inactive_winbar = {},
	  extensions = {}
}
