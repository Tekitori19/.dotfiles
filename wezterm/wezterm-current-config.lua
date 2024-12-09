-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
-- local mux = wezterm.mux
-- This will hold the configuration.
local config = wezterm.config_builder()

-- local gpus = wezterm.gui.enumerate_gpus()
-- config.webgpu_preferred_adapter = gpus[1]
-- config.front_end = "WebGpu"

config.front_end = "OpenGL"
config.max_fps = 120
config.term = "xterm-256color" -- Set the terminal type

config.font = wezterm.font("Hack Nerd Font Propo", { weight = "Medium" })
config.cell_width = 0.95
config.window_background_opacity = 0.9
config.prefer_egl = true
-- config.font_size = 14.5
config.font_size = 13
config.initial_cols = 122 -- Set the initial width to 120 columns
config.initial_rows = 32 -- Set the initial height to 30 rows

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.inactive_pane_hsb = {
	saturation = 0.0,
	brightness = 0.3,
}

-- color scheme toggling
---@diagnostic disable-next-line: unused-local
wezterm.on("toggle-colorscheme", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if overrides.color_scheme == "Zenburn" then
		overrides.color_scheme = "Cloud (terminal.sexy)"
	else
		overrides.color_scheme = "Zenburn"
	end
	window:set_config_overrides(overrides)
end)

-- Event to center the window on startup
-- wezterm.on("gui-startup", function(cmd)
-- 	local _, pane, window = wezterm.mux.spawn_window(cmd or {})
--
-- 	-- Lấy kích thước màn hình chính
-- 	local screen = wezterm.gui.screens().active
-- 	local screen_width = screen.width
-- 	local screen_height = screen.height
--
-- 	-- Đặt kích thước cố định cho cửa sổ
-- 	local default_width = 1200 -- Điều chỉnh theo nhu cầu của bạn
-- 	local default_height = 800 -- Điều chỉnh theo nhu cầu của bạn
--
-- 	-- Tính toán vị trí để đặt cửa sổ chính giữa
-- 	local x = math.floor((screen_width - default_width) / 2)
-- 	local y = math.floor((screen_height - default_height) / 2)
--
-- 	-- Đặt kích thước và vị trí cửa sổ
-- 	window:set_position(x, y)
-- 	window:set_size(default_width, default_height)
-- end)

-- keymaps
config.keys = {
	-- move
	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },

	{ key = "h", mods = "CTRL|SHIFT|ALT", action = act({ AdjustPaneSize = { "Left", 5 } }) },
	{ key = "j", mods = "CTRL|SHIFT|ALT", action = act({ AdjustPaneSize = { "Down", 5 } }) },
	{ key = "k", mods = "CTRL|SHIFT|ALT", action = act({ AdjustPaneSize = { "Up", 5 } }) },
	{ key = "l", mods = "CTRL|SHIFT|ALT", action = act({ AdjustPaneSize = { "Right", 5 } }) },

	{
		key = "LeftArrow",
		mods = "CTRL|SHIFT",
		action = act.SendKey({
			key = "LeftArrow",
			mods = "CTRL|SHIFT",
		}),
	},
	{
		key = "RightArrow",
		mods = "CTRL|SHIFT",
		action = act.SendKey({
			key = "RightArrow",
			mods = "CTRL|SHIFT",
		}),
	},

	-- tmux like
	{
		key = "h",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "v",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = "x",
		mods = "CTRL|ALT",
		action = act({ CloseCurrentPane = { confirm = true } }),
	},
	-- { key = "Tab", mods = "CTRL|SHIFT", action = act.CopyMode("MoveForwardWord") },

	-- copy and paaste
	-- { key = "c", mods = "CTRL|SHIFT", action = act.ActivateCopyMode },
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("PrimarySelection") },

	-- override "ctrl-shift-x" để không làm gì cả
	-- { key = "X", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },

	-- other config
	{
		key = "E",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "E",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.EmitEvent("toggle-colorscheme"),
	},
	{ key = "9", mods = "CTRL", action = act.PaneSelect },
	{
		key = "O",
		mods = "CTRL|ALT",
		-- toggling opacity
		action = wezterm.action_callback(function(window, _)
			local overrides = window:get_config_overrides() or {}
			if overrides.window_background_opacity == 1.0 then
				overrides.window_background_opacity = 0.9
			else
				overrides.window_background_opacity = 1.0
			end
			window:set_config_overrides(overrides)
		end),
	},
}

-- For example, changing the color scheme:
-- config.color_scheme = "Argonaut"
config.color_scheme = "Popping and Locking"
config.force_reverse_video_cursor = true
-- config.colors = {
-- 	foreground = "#dcd7ba",
-- 	background = "#1f1f28",
--
-- 	cursor_bg = "#c8c093",
-- 	cursor_fg = "#c8c093",
-- 	cursor_border = "#c8c093",
--
-- 	selection_fg = "#c8c093",
-- 	selection_bg = "#2d4f67",
--
-- 	scrollbar_thumb = "#16161d",
-- 	split = "#16161d",
--
-- 	ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
-- 	brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
-- 	indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
-- }

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.default_prog = { "C:\\Users\\corcl\\AppData\\Local\\Programs\\nu\\bin\\nu.exe" }

-- load cái ảnh xong terminal lag vl khuyên là máy yếu không nên bật
-- config.window_background_image = "C:\\Users\\corcl\\Pictures\\wallhaven-9d1zdd_1600x900.png"
-- config.window_background_image = "C:\\Users\\corcl\\Pictures\\viktor.png"

config.window_background_image_hsb = {
	brightness = 0.1,
}

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config)

-- tabs
-- config.hide_tab_bar_if_only_one_tab = true
-- config.use_fancy_tab_bar = false
-- config.tab_bar_at_bottom = false

-- and finally, return the configuration to wezterm
return config
