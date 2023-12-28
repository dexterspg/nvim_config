local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action


-- wezterm.on("gui-startup", function(cmd)
--     local tab, pane, window = mux.spawn_window( cmd or {})
--     window:gui_window():maximize()
-- end)

-- if wezterm.config_builder then
--     config = wezterm.config_builder()
-- end

return {


default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe", "-i", "-l" },
-- This is where you actually apply your config choices

-- For example, changing the color scheme:
 color_scheme = 'Dracula',
 font = wezterm.font 'JetBrainsMono Nerd Font Mono',
 font_size = 12,
 window_background_opacity = 0.9,
 bold_brightens_ansi_colors = 'BrightOnly',
 window_decorations='NONE',
--  initial_rows =100
--  initial_cols =100
 window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
},


 keys = {
    {
        key = 'n',
        mods = 'SHIFT|CTRL',
        action = act.ToggleFullScreen,
    },
}


}


