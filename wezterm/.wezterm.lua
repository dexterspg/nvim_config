local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- Colorscheme list (cycle with LEADER+p / LEADER+P)
local colorschemes = {
    -- Favorites first
    'Dracula',
    'Rosé Pine (Gogh)',
    'GruvboxLight',
    'ayu',
    'Poimandres',
    'Solarized Light (Gogh)',
    -- Rose Pine family
    'Rosé Pine Moon (Gogh)',
    'Rosé Pine Dawn (Gogh)',
    -- Tokyo Night family
    'Tokyo Night',
    'Tokyo Night Storm',
    'Tokyo Night Moon',
    'Tokyo Night Day',
    -- Catppuccin family
    'Catppuccin Mocha',
    'Catppuccin Macchiato',
    'Catppuccin Frappe',
    'Catppuccin Latte',
    -- Nord family
    'nord',
    'Nord Light (Gogh)',
    -- Dracula family
    'Dracula (Official)',
    -- Gruvbox family
    'GruvboxDark',
    'Gruvbox dark, hard (base16)',
    -- One Dark
    'One Dark (Gogh)',
    'OneHalfDark',
    'OneHalfLight',
    -- Nightfox family
    'nightfox',
    'duskfox',
    'nordfox',
    'carbonfox',
    'terafox',
    'dayfox',
    'dawnfox',
    -- Kanagawa
    'Kanagawa (Gogh)',
    'Kanagawa Dragon (Gogh)',
    -- Ayu family
    'Ayu Mirage',
    'ayu_light',
    -- Everforest
    'Everforest Dark Hard (Gogh)',
    'Everforest Light Hard (Gogh)',
    -- Monokai
    'Monokai Pro (Gogh)',
    'Monokai Vivid',
    -- Iceberg
    'iceberg-dark',
    'iceberg-light',
    -- Misc popular
    'Yousai (terminal.sexy)',
    'Vesper',
    'hardhacker',
    'Mellifluous',
    'Solarized Dark Higher Contrast',
    'flexoki-dark',
    'flexoki-light',
}

local scheme_idx = 1
-- Sync index to whatever is set as default
for i, name in ipairs(colorschemes) do
    if name == 'Dracula' then scheme_idx = i break end
end

-- Light schemes for low-opacity mode (opacity <= 0.5)
local light_schemes = {
    'Catppuccin Latte',
    'dayfox',
    'Yousai (terminal.sexy)',
    'iceberg-light',
    'flexoki-light',
    'Rosé Pine Dawn (Gogh)',
    'GruvboxLight',
    'OneHalfLight',
    'ayu_light',
}
local light_idx = 1

local default_bg_opacity = 0.85
local current_bg_opacity = default_bg_opacity  -- tracks live value for LEADER+o display

local function cycle_scheme(window, step)
    local overrides = window:get_config_overrides() or {}
    local opacity = current_bg_opacity

    if opacity <= 0.5 then
        light_idx = ((light_idx - 1 + step) % #light_schemes) + 1
        local scheme = light_schemes[light_idx]
        overrides.color_scheme = scheme
        window:set_config_overrides(overrides)
        window:toast_notification('Colorscheme', string.format('[%d/%d] %s (light)', light_idx, #light_schemes, scheme), nil, 2000)
        wezterm.log_info(string.format('Colorscheme changed to: [%d/%d] %s', light_idx, #light_schemes, scheme))
    else
        scheme_idx = ((scheme_idx - 1 + step) % #colorschemes) + 1
        local scheme = colorschemes[scheme_idx]
        overrides.color_scheme = scheme
        window:set_config_overrides(overrides)
        window:toast_notification('Colorscheme', string.format('[%d/%d] %s', scheme_idx, #colorschemes, scheme), nil, 2000)
        wezterm.log_info(string.format('Colorscheme changed to: [%d/%d] %s', scheme_idx, #colorschemes, scheme))
    end
end

-- wezterm.on("gui-startup", function(cmd)
--     local tab, pane, window = mux.spawn_window( cmd or {})
--     window:gui_window():maximize()
-- end)
local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe", "-i", "-l" }
config.default_cwd = "C:/workarea"
config.set_environment_variables = {
    PATH = "/c/Program Files/Java/jdk-17/bin;" .. os.getenv("PATH"),
}
config.color_scheme = 'Dracula'
config.font = wezterm.font('JetBrainsMono Nerd Font Mono', { weight = 'Regular' })
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.font_size = 12
config.window_background_opacity = 1.0
-- config.win32_system_backdrop = "Mica"
config.front_end = 'WebGpu'
-- Transparent background layer (controlled by LEADER+o, default 0.85 opacity)
config.background = {{
    source = { Color = string.format("rgba(15, 15, 25, %.2f)", default_bg_opacity) },
    width = "100%",
    height = "100%",
}}

-- Custom background layer for text contrast
-- Adjust the rgba values to control darkness and text brightness
config.bold_brightens_ansi_colors = 'BrightOnly'
config.window_decorations = 'NONE'

-- Performance tuning: reduce input latency
config.animation_fps = 1          -- no animation redraws
config.cursor_blink_rate = 0      -- disable cursor blink (redraws on every tick)
config.max_fps = 60               -- cap render rate
config.use_ime = false            -- skip IME pipeline on every keystroke
config.check_for_updates = false  -- no background network checks
config.scrollback_lines = 2000    -- default 3500, less memory to manage
-- config.prefer_egl = true        -- redundant with WebGpu front_end
config.audible_bell = "Disabled"  -- prevent bell syscall stalls
config.window_close_confirmation = "AlwaysPrompt"
config.enable_tab_bar=false
--  initial_rows =100
--  initial_cols =100
--
--
-- Dim inactive panes
config.inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.8
}

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 500 }

-- Enable clicking hyperlinks with proper path conversion
config.hyperlink_rules = {
    -- HTTP/HTTPS URLs
    {
        regex = '\\b\\w+://(?:[\\w.-]+)(?::\\d+)?\\S*\\b',
        format = '$0',
    },
    -- Windows absolute paths: C:\path\to\file or C:/path/to/file (including spaces)
    {
        regex = '[A-Z]:[\\\\/:][\\w\\-._/\\\\ ]*[\\w\\-._/\\\\]',
        format = 'file:///$0',
    },
}
config.keys = {
    -- Send C-a when pressing C-a twice
    { key = "a",          mods = "LEADER|CTRL", action = act.SendKey { key = "a", mods = "CTRL" } },
    { key = "c",          mods = "LEADER",      action = act.ActivateCopyMode },
    { key = "phys:Space", mods = "LEADER",      action = act.ActivateCommandPalette },

    -- Opacity control: LEADER+o (prompts for background layer opacity 0.0-1.0)
    { key = "o", mods = "LEADER", action = wezterm.action_callback(function(window, pane)
        window:perform_action(act.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = "Bold" } },
                { Foreground = { AnsiColor = "Green" } },
                { Text = string.format("Background opacity (0.0-1.0) [current: %.2f]: ", current_bg_opacity) },
            },
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    local opacity = tonumber(line)
                    if opacity then
                        opacity = math.max(0, math.min(1, opacity))
                        current_bg_opacity = opacity
                        local overrides = window:get_config_overrides() or {}
                        overrides.background = {{
                            source = { Color = string.format("rgba(15, 15, 25, %.2f)", opacity) },
                            width = "100%",
                            height = "100%",
                        }}
                        overrides.color_scheme = opacity <= 0.5 and light_schemes[light_idx] or colorschemes[scheme_idx]
                        window:set_config_overrides(overrides)
                    end
                end
            end)
        }, pane)
    end) },

    { key = "s",          mods = "LEADER",      action = act.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "v",          mods = "LEADER",      action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "h",          mods = "LEADER",      action = act.ActivatePaneDirection("Left") },
    { key = "j",          mods = "LEADER",      action = act.ActivatePaneDirection("Down") },
    { key = "k",          mods = "LEADER",      action = act.ActivatePaneDirection("Up") },
    { key = "l",          mods = "LEADER",      action = act.ActivatePaneDirection("Right") },
    { key = "q",          mods = "LEADER",      action = act.CloseCurrentPane { confirm = true } },
    { key = "z",          mods = "LEADER",      action = act.TogglePaneZoomState },
    -- We can make separate keybindings for resizing panes
    -- But Wezterm offers custom "mode" in the name of "KeyTable"
    { key = "r",          mods = "LEADER",      action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },
    { key = "R",          mods = "LEADER",      action = act.RotatePanes "Clockwise" },
    { key = "S",          mods = "LEADER",      action = act.PaneSelect { mode = "SwapWithActive" } },

    -- Tab keybindings
    { key = "t",          mods = "LEADER",      action = act.SpawnTab("CurrentPaneDomain") },
    -- Spawn CMD tab: LEADER+C
    { key = "C",          mods = "LEADER",      action = act.SpawnCommandInNewTab { args = { "cmd.exe" }, domain = "CurrentPaneDomain" } },
    { key = "[",          mods = "LEADER",      action = act.ActivateTabRelative(-1) },
    { key = "]",          mods = "LEADER",      action = act.ActivateTabRelative(1) },
    { key = "n",          mods = "LEADER",      action = act.ShowTabNavigator },
    {
        key = "e",
        mods = "LEADER",
        action = act.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = "Bold" } },
                { Foreground = { AnsiColor = "Fuchsia" } },
                { Text = "Renaming Tab Title...:" },
            },
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end)
        }
    },
    -- Toggle tab bar: LEADER+b
    { key = "b", mods = "LEADER", action = wezterm.action_callback(function(window)
        local overrides = window:get_config_overrides() or {}
        overrides.enable_tab_bar = not (overrides.enable_tab_bar or false)
        window:set_config_overrides(overrides)
    end) },

    -- Colorscheme cycler: LEADER+p (next), LEADER+P (prev)
    { key = "p", mods = "LEADER",       action = wezterm.action_callback(function(window, pane) cycle_scheme(window, 1)  end) },
    { key = "P", mods = "LEADER",       action = wezterm.action_callback(function(window, pane) cycle_scheme(window, -1) end) },

    --  moving tabs around
    { key = "m", mods = "LEADER",       action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },
    -- Fuzzy workspace switcher: Ctrl+A, w - PRIMARY
    { key = "w", mods = "LEADER",       action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },
    -- Workspace creation/navigation: Ctrl+A, Shift+W (prompts for workspace name) - SECONDARY
    { key = "w", mods = "LEADER|SHIFT", action = act.PromptInputLine {
        description = wezterm.format {
            { Attribute = { Intensity = "Bold" } },
            { Foreground = { AnsiColor = "Teal" } },
            { Text = "Workspace name: " },
        },
        action = wezterm.action_callback(function(window, pane, line)
            if line then
                -- Create and switch to workspace
                window:perform_action(act.SwitchToWorkspace { name = line }, pane)
            end
        end)
    }},

}

config.key_tables = {
    resize_pane = {
        { key = "h",      action = act.AdjustPaneSize { "Left", 1 } },
        { key = "j",      action = act.AdjustPaneSize { "Down", 1 } },
        { key = "k",      action = act.AdjustPaneSize { "Up", 1 } },
        { key = "l",      action = act.AdjustPaneSize { "Right", 1 } },
        { key = "Escape", action = "PopKeyTable" },
        { key = "Enter",  action = "PopKeyTable" },
    },
    move_tab = {
        { key = "h",      action = act.MoveTabRelative(-1) },
        { key = "j",      action = act.MoveTabRelative(-1) },
        { key = "k",      action = act.MoveTabRelative(1) },
        { key = "l",      action = act.MoveTabRelative(1) },
        { key = "Escape", action = "PopKeyTable" },
        { key = "Enter",  action = "PopKeyTable" },
    }
}

return config






--
