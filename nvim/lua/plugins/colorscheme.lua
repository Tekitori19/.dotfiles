return {
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   opts ={
  --     terminal_colors = true, -- add neovim terminal colors
  --     undercurl = true,
  --     underline = true,
  --     bold = true,
  --     italic = {
  --       strings = true,
  --       emphasis = true,
  --       comments = true,
  --       operators = false,
  --       folds = true,
  --     },
  --     strikethrough = true,
  --     invert_selection = false,
  --     invert_signs = false,
  --     invert_tabline = false,
  --     invert_intend_guides = false,
  --     inverse = true, -- invert background for search, diffs, statuslines and errors
  --     contrast = "", -- can be "hard", "soft" or empty string
  --     palette_overrides = {},
  --     overrides = {},
  --     dim_inactive = false,
  --     -- transparent_mode = true,
  --   },
  -- },

  {
    "neanias/everforest-nvim",
    config = function()
      require("everforest").setup({
       transparent_background_level = 1,
        diagnostic_virtual_text = "coloured",
        disable_terminal_colours = true,
        background = "soft",
        ui_contrast = "low",
        on_highlights = function(hl, palette)
          hl.NormalFloat = { fg = palette.fg, bg = palette.none }
        end
      })
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  }
}
