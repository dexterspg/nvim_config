return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-web-devicons',
  },
  ft = 'markdown',  -- Only load for markdown files
  opts = {
    -- Render style
    heading = {
      -- Add background to headings
      enabled = true,
      sign = true,
      icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
    },
    code = {
      -- Render code blocks with background
      enabled = true,
      sign = true,
      style = 'full',
      width = 'block',
    },
    checkbox = {
      -- Custom checkbox characters
      enabled = true,
      unchecked = { icon = '󰄱 ' },
      checked = { icon = '󰱒 ' },
    },
    -- LaTeX math rendering
    latex = {
      enabled = true,
    },
  },
  config = function(_, opts)
    require('render-markdown').setup(opts)

    -- Optional: Add keybinding to toggle rendering
    vim.keymap.set('n', '<leader>tm', ':RenderMarkdown toggle<CR>',
      { desc = 'Toggle markdown rendering' })
  end,
}
