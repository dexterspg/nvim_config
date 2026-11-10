-- Open a folder in Windows Explorer and bring that window to the front.
-- A plain open leaves the new window behind the terminal, so tap ALT (unlocks foreground
-- switching) and activate the window once it appears.
local function open_folder_in_explorer(path)
    path = path:gsub("[/\\]+$", "")
    local script = [[
Add-Type @"
using System; using System.Runtime.InteropServices;
public class OilFg {
 [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr h);
 [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int c);
 [DllImport("user32.dll")] public static extern void keybd_event(byte vk, byte scan, uint flags, UIntPtr extra);
}
"@
$p = ']] .. path:gsub("'", "''") .. [['
Start-Process explorer.exe -ArgumentList ('"' + $p + '"')
$h = $null
for ($i = 0; $i -lt 40 -and -not $h; $i++) {
  Start-Sleep -Milliseconds 100
  foreach ($w in (New-Object -ComObject Shell.Application).Windows()) {
    try { if (([Uri]$w.LocationURL).LocalPath.TrimEnd('\') -ieq $p) { $h = [IntPtr]$w.HWND; break } } catch {}
  }
}
if ($h) {
  [OilFg]::keybd_event(0x12, 0, 0, [UIntPtr]::Zero); [OilFg]::keybd_event(0x12, 0, 2, [UIntPtr]::Zero)
  [void][OilFg]::ShowWindow($h, 9); [void][OilFg]::SetForegroundWindow($h)
}
]]
    local encoded = vim.base64.encode(vim.iconv(script, "utf-8", "utf-16le"))
    -- not detached: a detached hidden PowerShell never gets as far as opening the window
    vim.fn.jobstart({ "powershell.exe", "-NoProfile", "-NonInteractive", "-WindowStyle", "Hidden", "-EncodedCommand", encoded })
end

return {
    'stevearc/oil.nvim',
    dependencies = { 'echasnovski/mini.icons' },
    cmd = "Oil",
    keys = {
        { "-", "<CMD>Oil<CR>", desc = "Open parent directory (Oil)" },
        { "<leader>-", "<CMD>Oil --float<CR>", desc = "Open Oil in floating window" },
    },
    init = function()
        -- Disable netrw so Oil can take over directory buffers
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        -- Load Oil when opening a directory (e.g. `nvim .`)
        vim.api.nvim_create_autocmd("BufWinEnter", {
            nested = true,
            callback = function(info)
                if vim.fn.isdirectory(info.file) == 1 then
                    require("lazy").load({ plugins = { "oil.nvim" } })
                    require("oil").open(info.file)
                end
            end,
        })
    end,
    opts = {
        -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
        default_file_explorer = true,

        -- Columns to show in oil buffer
        columns = {
            "icon",
            -- "permissions",
            -- "size",
            -- "mtime",
        },

        -- Buffer-local options for oil buffers
        buf_options = {
            buflisted = false,
            bufhidden = "hide",
        },

        -- Window-local options for oil buffers
        win_options = {
            wrap = false,
            signcolumn = "yes:2",
            cursorcolumn = false,
            foldcolumn = "0",
            spell = false,
            list = false,
            conceallevel = 3,
            concealcursor = "nvic",
            number = true,
            relativenumber = true,
        },

        -- Send deleted files to trash instead of permanent deletion
        delete_to_trash = true,

        -- Skip confirmation for simple operations
        skip_confirm_for_simple_edits = false,

        -- Prompt for confirmation before certain operations
        prompt_save_on_select_new_entry = true,

        -- Keymaps in oil buffer
        keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-s>"] = "actions.select_vsplit",
            ["<C-h>"] = "actions.select_split",
            ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-r>"] = "actions.refresh",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["gs"] = "actions.change_sort",
            -- files open in their default app; folders open in Explorer, brought to the front
            ["gx"] = {
                desc = "Open file or folder externally",
                callback = function()
                    local actions = require("oil.actions")
                    local oil = require("oil")
                    local entry = oil.get_cursor_entry()
                    local dir = oil.get_current_dir()
                    if entry and dir and entry.type == "directory" then
                        open_folder_in_explorer(dir .. entry.name)
                    else
                        actions.open_external.callback()
                    end
                end,
            },
            ["g."] = "actions.toggle_hidden",
            ["g\\"] = "actions.toggle_trash",
        },

        -- Set to false to disable all keymaps
        use_default_keymaps = false,

        view_options = {
            -- Show files and directories that start with "."
            show_hidden = false,

            -- This function defines what is considered a "hidden" file
            is_hidden_file = function(name, bufnr)
                return vim.startswith(name, ".")
            end,

            -- This function defines what will never be shown, even when `show_hidden` is set
            is_always_hidden = function(name, bufnr)
                return name == ".." or name == ".git"
            end,

            sort = {
                -- sort order: "asc" or "desc"
                { "type", "asc" },
                { "name", "asc" },
            },
        },

        -- Configuration for the floating window in oil.open_float
        float = {
            padding = 2,
            max_width = 90,
            max_height = 30,
            border = "rounded",
            win_options = {
                winblend = 0,
            },
        },

        -- Configuration for the file preview window
        preview = {
            max_width = 0.9,
            min_width = { 40, 0.4 },
            width = nil,
            max_height = 0.9,
            min_height = { 5, 0.1 },
            height = nil,
            border = "rounded",
            win_options = {
                winblend = 0,
            },
        },

        -- Configuration for the progress window
        progress = {
            max_width = 0.9,
            min_width = { 40, 0.4 },
            width = nil,
            max_height = { 10, 0.9 },
            min_height = { 5, 0.1 },
            height = nil,
            border = "rounded",
            minimized_border = "none",
            win_options = {
                winblend = 0,
            },
        },
    },
}
