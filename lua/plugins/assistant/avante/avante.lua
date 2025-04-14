return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "echasnovski/mini.pick", -- Optional: file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- Optional: file_selector provider telescope
        "hrsh7th/nvim-cmp", -- Autocompletion for Avante commands and mentions
        "ibhagwan/fzf-lua", -- Optional: file_selector provider fzf
        "nvim-tree/nvim-web-devicons", -- Or echasnovski/mini.icons
        "zbirenbaum/copilot.lua", -- For providers = 'copilot'
        {
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            config = function()
                require("img-clip").setup({
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        use_absolute_path = true, -- Required for Windows users
                    },
                })
            end,
        },
        {
            "MeanderingProgrammer/render-markdown.nvim",
            ft = { "markdown", "Avante" },
            config = function()
                require("render-markdown").setup({
                    file_types = { "markdown", "Avante" },
                })
            end,
        },
    },
    config = function()
        local ok, avante = pcall(require, "avante")
        if not ok then return end

        avante.setup({
            provider = "openai",
            openai = {
                endpoint = "https://api.openai.com/v1",
                model = "gpt-4o", -- Your desired model
                timeout = 30000, -- Timeout in milliseconds
                temperature = 0,
                max_completion_tokens = 8192, -- To include reasoning tokens
                -- reasoning_effort = "medium", -- Uncomment for reasoning models
            },
            -- opts = {
                -- provider = "anthropic",
                -- anthropic = {
                    -- endpoint = "https://api.anthropic.com/v1",
                    -- model = "claude-2",
                    -- api_key = os.getenv("ANTHROPIC_API_KEY"), -- Store your key as an environment variable
                -- },
            -- }
        })
    end,
    build = "make", -- If you want to build from source
}

