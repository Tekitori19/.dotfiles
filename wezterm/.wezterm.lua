-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
config.default_prog = { 'pwsh.exe' }
-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Everforest Dark (Gogh)'
config.font = wezterm.font('Hack Nerd Font', {weight = 700})
config.font_size = 12
config.window_decorations = "RESIZE" --"INTEGRATED_BUTTONS|RESIZE"
config.cursor_blink_ease_out = "Linear"

-- Window
config.window_padding = {
  left = 2,
  right = 2,
  top = 5,
  bottom = 0,
}

-- Tab bar
config.use_fancy_tab_bar = false
config.tab_max_width = 16
config.tab_bar_at_bottom = true
config.window_frame = {
  border_top_height = 0,
  border_bottom_height = 0,
  active_titlebar_bg = "rgba(0 0 0 0)",
  font = wezterm.font('Hack Nerd Font'),
  font_size = 11,
}
-- config.text_background_opacity = 0.6
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  -- The filled in variant of the < symbol
  local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

  -- The filled in variant of the > symbol
  local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
  local title = tab.active_pane.title
  if tab.tab_title and #tab.tab_title > 0 then
    title = tab.tab_title
  end
  if tab.is_active then
    return {
      { Background = { Color = "#90c083" } },
      { Foreground = { Color = "#030b09" } },
      -- { Text = SOLID_LEFT_ARROW },
      -- { Background = { Color = "#90c083" } },
      { Foreground = { Color = "#111b21" } },
      { Text = (tab.tab_index + 1) .. ": " .. title .. " " },
      -- { Background = { Color = "#0b0022" } },
      -- { Foreground = { Color = "#2b2042" } },
      -- { Text = SOLID_RIGHT_ARROW },
    }
  else
    return {
      { Background = { Color = "#111b21" } },
      -- { Foreground = { Color = "#1b1032" } },
      -- { Text = SOLID_LEFT_ARROW },
      -- { Background = { Color = "#1b1032" } },
      { Foreground = { Color = "#a0bb73" } },
      { Text = (tab.tab_index + 1) .. ": " .. title .. " " },
      -- { Background = { Color = "#0b0022" } },
      -- { Foreground = { Color = "#1b1032" } },
      -- { Text = SOLID_RIGHT_ARROW },
    }
  end
end)

-- This is used to make my foreground (text, etc) brighter than my background
config.foreground_text_hsb = {
  hue = 1.0,
  saturation = 1.5,
  brightness = 1.5,
}

-- This is used to set an image as my background 
config.background = {
    {
        source = { File = {path = 'C:/Users/Dwcks Dinh/Pictures/wallhaven-4988l8_1920x1080.png', speed = 0.2}},
        opacity = 0.96,
        -- width = "Contain",
        -- repeat_y = "NoRepeat",
        -- height = "100%",
        hsb = {brightness = 0.06},
    }
}

-- and finally, return the configuration to wezterm
return config
