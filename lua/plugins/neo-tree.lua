return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "echasnovski/mini.icons",
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
        { "<leader>n", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
        { "<leader>fe", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
        { "<leader>fE", "<cmd>Neotree reveal<cr>", desc = "Reveal in Neo-tree" },
        { "<leader>fb", "<cmd>Neotree buffers toggle<cr>", desc = "Neo-tree: Buffers" },
        { "<leader>gs", "<cmd>Neotree git_status toggle<cr>", desc = "Neo-tree: Git Status" },
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            sources = { "filesystem", "buffers", "git_status" },
            source_selector = {
                winbar = true,
                statusline = false,
                tabs = {
                    {
                        source = "filesystem",
                        display_name = " 󰉋 Files "
                    },
                    {
                        source = "buffers",
                        display_name = " 󰈚 Buffers "
                    },
                    {
                        source = "git_status",
                        display_name = " 󰊢 Git "
                    },
                },
            },

            default_component_configs = {
                container = {
                    enable_character_fade = true
                },
                indent = {
                    indent_size = 2,
                    padding = 1,
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    with_expanders = true,
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "",
                    provider = function(icon, node)
                        if node.type == "file" then
                            local mini_icons = require("mini.icons")
                            local file_icon, hl = mini_icons.get("file", node.name)
                            icon.text = file_icon
                            icon.highlight = hl
                        end
                    end,
                },
                file_size = {
                    enabled = false,
                },
                type = {
                    enabled = false,
                },
                last_modified = {
                    enabled = false,
                },
                created = {
                    enabled = false,
                },
                symlink_target = {
                    enabled = false,
                },
                modified = {
                    symbol = "[+]",
                    highlight = "NeoTreeModified",
                },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                    highlight = "NeoTreeFileName",
                },
                git_status = {
                    symbols = {
                        added     = "",
                        modified  = "",
                        deleted   = "✖",
                        renamed   = "➜",
                        untracked = "★",
                        ignored   = "◌",
                        unstaged  = "✗",
                        staged    = "✓",
                        conflict  = "",
                    }
                },
            },

            window = {
                position = "left",
                width = 35,
                number = true,
                relativenumber = true,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    ["<space>"] = "none",
                    ["l"] = "open",
                    ["h"] = "close_node",
                    ["a"] = {
                        "add",
                        config = {
                            show_path = "relative"
                        }
                    },
                    ["d"] = "delete",
                    ["r"] = "rename",
                    ["y"] = "copy_to_clipboard",
                    ["x"] = "cut_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["c"] = "copy",
                    ["m"] = "move",
                    ["q"] = "close_window",
                    ["R"] = "refresh",
                    ["?"] = "show_help",
                },
            },

            filesystem = {
                filtered_items = {
                    visible = false,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {
                        "node_modules",
                        ".git",
                        ".class",
                        "target",
                    },
                    never_show = {
                        ".DS_Store",
                        "thumbs.db",
                    },
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true,  -- Keep parent folders open and visible
                },
                group_empty_dirs = true,
                hijack_netrw_behavior = "open_default",
                use_libuv_file_watcher = true,
                window = {
                    mappings = {
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root",
                        ["[g"] = "prev_git_modified",
                        ["]g"] = "next_git_modified",
                    },
                },
            },

            buffers = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
                group_empty_dirs = true,
                show_unloaded = true,
            },

            git_status = {
                window = {
                    position = "float",
                    mappings = {
                        ["A"]  = "git_add_all",
                        ["gu"] = "git_unstage_file",
                        ["ga"] = "git_add_file",
                        ["gr"] = "git_revert_file",
                        ["gc"] = "git_commit",
                        ["gp"] = "git_push",
                        ["gg"] = "git_commit_and_push",
                    }
                }
            },

            event_handlers = {
                {
                    event = "neo_tree_buffer_enter",
                    handler = function()
                        vim.wo.number = true
                        vim.wo.relativenumber = true
                    end,
                },
            },
        })
    end,
}
