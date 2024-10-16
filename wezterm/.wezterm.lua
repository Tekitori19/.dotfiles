-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()
config.default_prog = { "pwsh.exe" }
-- This is where you actually apply your config choices
-- For example, changing the color scheme:
config.color_scheme = "Everforest Dark (Gogh)"
config.font = wezterm.font("Hack Nerd Font", { weight = 450 })
config.font_size = 12
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
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
	font = wezterm.font("Hack Nerd Font"),
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
	-- hue = 1.0,
	-- saturation = 1.5,
	-- brightness = 1.5,
}

-- This is used to set an image as my background
config.background = {
	{
		source = { File = { path = "C:\\Users\\corcl\\Pictures\\wallhaven-l816dy_1600x900.png", speed = 0.2 } },
		-- opacity = 0.96,
		-- width = "Contain",
		-- repeat_y = "NoRepeat",
		-- height = "100%",
		hsb = { brightness = 0.04 },
	},
}

-- tmux replace
config.scrollback_lines = 3500
config.enable_scroll_bar = true
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false
config.leader = { key = "F1", mods = "NONE", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "LeftArrow", mods = "OPT", action = act.SendString("\x1bb") },
	{ key = "RightArrow", mods = "OPT", action = act.SendString("\x1bf") },

	-- The physical CMD key on OSX is the Alt key on Win/*nix, so map the common Alt-combo commands.
	{ key = ".", mods = "CMD", action = act.SendString("\x1b.") },
	{ key = "p", mods = "CMD", action = act.SendString("\x1bp") },
	{ key = "n", mods = "CMD", action = act.SendString("\x1bn") },
	{ key = "b", mods = "CMD", action = act.SendString("\x1bb") },
	{ key = "f", mods = "CMD", action = act.SendString("\x1bf") },

	-- Window management
	{ key = "a", mods = "LEADER", action = act({ SendString = "`" }) },
	{ key = "-", mods = "LEADER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
	{ key = "c", mods = "LEADER", action = act({ SpawnTab = "CurrentPaneDomain" }) },

	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

	{ key = "H", mods = "LEADER", action = act({ AdjustPaneSize = { "Left", 5 } }) },
	{ key = "J", mods = "LEADER", action = act({ AdjustPaneSize = { "Down", 5 } }) },
	{ key = "K", mods = "LEADER", action = act({ AdjustPaneSize = { "Up", 5 } }) },
	{ key = "L", mods = "LEADER", action = act({ AdjustPaneSize = { "Right", 5 } }) },

	{ key = "`", mods = "LEADER", action = act.ActivateLastTab },
	{ key = " ", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "1", mods = "LEADER", action = act({ ActivateTab = 0 }) },
	{ key = "2", mods = "LEADER", action = act({ ActivateTab = 1 }) },
	{ key = "3", mods = "LEADER", action = act({ ActivateTab = 2 }) },
	{ key = "4", mods = "LEADER", action = act({ ActivateTab = 3 }) },
	{ key = "5", mods = "LEADER", action = act({ ActivateTab = 4 }) },
	{ key = "6", mods = "LEADER", action = act({ ActivateTab = 5 }) },
	{ key = "7", mods = "LEADER", action = act({ ActivateTab = 6 }) },
	{ key = "8", mods = "LEADER", action = act({ ActivateTab = 7 }) },
	{ key = "9", mods = "LEADER", action = act({ ActivateTab = 8 }) },
	{ key = "x", mods = "LEADER", action = act({ CloseCurrentPane = { confirm = true } }) },

	-- Activate Copy Mode
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
	-- Paste from Copy Mode
	{ key = "]", mods = "LEADER", action = act.PasteFrom("PrimarySelection") },
}

config.key_tables = {
	-- added new shortcuts to the end
	copy_mode = {
		{ key = "c", mods = "CTRL", action = act.CopyMode("Close") },
		{ key = "g", mods = "CTRL", action = act.CopyMode("Close") },
		{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
		{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },

		{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
		{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
		{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
		{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },

		{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
		{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
		{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
		{ key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },

		{ key = "RightArrow", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
		{ key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
		{ key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
		{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },

		{ key = "LeftArrow", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
		{ key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
		{ key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
		{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },

		{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
		{ key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },

		{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "m", mods = "ALT", action = act.CopyMode("MoveToStartOfLineContent") },

		{ key = " ", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{ key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
		{ key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
		{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },

		{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
		{ key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
		{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },

		{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
		{ key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
		{ key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
		{ key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
		{ key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
		{ key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },

		{ key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
		{ key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
		{ key = "O", mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },

		{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
		{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },

		{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
		{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },

		-- Enter y to copy and quit the copy mode.
		{
			key = "y",
			mods = "NONE",
			action = act.Multiple({
				act.CopyTo("ClipboardAndPrimarySelection"),
				act.CopyMode("Close"),
			}),
		},
		-- Enter search mode to edit the pattern.
		-- When the search pattern is an empty string the existing pattern is preserved
		{ key = "/", mods = "NONE", action = act({ Search = { CaseSensitiveString = "" } }) },
		{ key = "?", mods = "NONE", action = act({ Search = { CaseInSensitiveString = "" } }) },
		{ key = "n", mods = "CTRL", action = act({ CopyMode = "NextMatch" }) },
		{ key = "p", mods = "CTRL", action = act({ CopyMode = "PriorMatch" }) },
	},

	search_mode = {
		{ key = "Escape", mods = "NONE", action = act({ CopyMode = "Close" }) },
		-- Go back to copy mode when pressing enter, so that we can use unmodified keys like "n"
		-- to navigate search results without conflicting with typing into the search area.
		{ key = "Enter", mods = "NONE", action = "ActivateCopyMode" },
		{ key = "c", mods = "CTRL", action = "ActivateCopyMode" },
		{ key = "n", mods = "CTRL", action = act({ CopyMode = "NextMatch" }) },
		{ key = "p", mods = "CTRL", action = act({ CopyMode = "PriorMatch" }) },
		{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
		{ key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
	},
}

-- and finally, return the configuration to wezterm
return config
