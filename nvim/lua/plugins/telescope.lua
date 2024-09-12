
return {
  "nvim-telescope/telescope.nvim",
  config = function()
    require('telescope').setup {
      -- defaults = {
      --   layout_strategy = "vertical",
      --   layout_config = {
      --     height = vim.o.lines, -- maximally available lines
      --     width = vim.o.columns, -- maximally available columns
      --     prompt_position = "bottom",
      --     preview_height = 0.6, -- 60% of available lines
      --   },
      -- },
      defaults = require('telescope.themes').get_dropdown(),
    }
  end
}
