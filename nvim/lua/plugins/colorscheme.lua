return {
  { "rebelot/kanagawa.nvim", branch = "master", priority = 1000, opts = {
    transparent = true,
  } },
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
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "kanagawa",
      -- colorscheme = "solarized-osaka",
      colorscheme = "nightfly",
    },
  },
}
