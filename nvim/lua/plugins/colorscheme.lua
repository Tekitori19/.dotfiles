return {
  {
    "rebelot/kanagawa.nvim",
    branch = "master",
    priority = 1000,
    opts = {
      transparent = true,
    },
  },
  {
    "HoNamDuong/hybrid.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
  },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.nightflyTransparent = true
    end,
  },
  {
    "aliqyan-21/darkvoid.nvim",
    priority = 1000,
    config = function()
      require("darkvoid").setup({
        transparent = true,
        glow = true,
        colors = {
          plugins = {
            lualine = false, -- make this to false
          },
        },
      })
      vim.cmd.colorscheme("darkvoid")
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
      -- colorscheme = "hybrid",
      -- colorscheme = "default",
      -- colorscheme = "nightfly",
      -- colorscheme = "darkvoid",
      -- colorscheme = "tokyonight",
      -- colorscheme = "rose-pine-moon",
    },
  },
}
