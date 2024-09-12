return {
  "neovim/nvim-lspconfig",
  event = "LazyFile",
  dependencies = {
    "mason.nvim",
    { "williamboman/mason-lspconfig.nvim", config = function() end },
  },
  opts = {
      servers = {
        lua_ls = {
          mason = false, -- set to false if you don't want this server to be installed with mason
        },
      },
  }
}
