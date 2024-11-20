return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      enabled = true,
      sections = {
        {
          section = "terminal",
          cmd = "chafa C:\\Users\\corcl\\Pictures\\viktor.png --format symbols --symbols vhalf --size 60x17 --stretch",
          height = 17,
          padding = 1,
        },
        {
          pane = 2,
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
}
