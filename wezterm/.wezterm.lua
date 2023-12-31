local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action


-- wezterm.on("gui-startup", function(cmd)
--     local tab, pane, window = mux.spawn_window( cmd or {})
--     window:gui_window():maximize()
-- end)

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end


config.default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe", "-i", "-l" }

config.color_scheme = 'Dracula'
config.font = wezterm.font('JetBrainsMono Nerd Font Mono', { weight = 'Bold' })
config.font_size = 12
config.window_background_opacity = 0.6
config.bold_brightens_ansi_colors = 'BrightOnly'
config.window_decorations = 'NONE'
config.window_close_confirmation = "AlwaysPrompt"
--  initial_rows =100
--  initial_cols =100
--
--
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
    { key = 'n', mods = 'SHIFT|CTRL', action = act.ToggleFullScreen },
    { key = '-', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
}

return config
