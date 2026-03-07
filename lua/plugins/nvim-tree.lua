vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFileToggle<CR>', opts)

return {
    'nvim-tree/nvim-tree.lua',
    enabled = false, -- Disabled in favor of neo-tree
    dependencies = {
        'ahmedkhalf/project.nvim',
    },
    config = function()
        local status_ok, nvim_tree = pcall(require, "nvim-tree")
        if not status_ok then
            return
        end
        nvim_tree.setup({
            sync_root_with_cwd = true, --based on project.nvim config
            respect_buf_cwd = true,  --based on project.nvim config
            hijack_cursor = true,
            update_focused_file = {
                enable = true,
                update_cwd = true, --based on project.nvim config
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
                highlight_opened_files = "all"
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
                open_file = {
                    quit_on_open = false, -- not working
                }
            }
        })
        -- Add autocmd for Java files to include package declaration
        local function add_java_package()
            local file_path = vim.fn.expand("%:p") -- Get the full path of the current file
            local root_dir = require("lspconfig").util.find_git_ancestor(file_path) or vim.fn.getcwd()
            local src_dir = root_dir .. "/src/main/java/"
            if file_path:find(src_dir, 1, true) then
                local relative_path = file_path:sub(#src_dir + 1)
                local package_name = relative_path:gsub("/", "."):gsub("\\", "."):gsub("%.java$", "")
                local package_line = "package " .. package_name .. ";"

                -- Add the package declaration at the top of the file
                vim.api.nvim_buf_set_lines(0, 0, 0, false, { package_line, "" })
                vim.cmd("write") -- Save the file to preserve the changes
            end
        end

        vim.api.nvim_create_autocmd("BufNewFile", {
            pattern = "*.java",
            callback = function()
                add_java_package()
            end,
        })
    end,
}
