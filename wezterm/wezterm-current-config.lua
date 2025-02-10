local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
local config = wezterm.config_builder()

-- local gpus = wezterm.gui.enumerate_gpus()
-- config.webgpu_preferred_adapter = gpus[1]
-- config.front_end = "WebGpu"

config.front_end = "OpenGL"
config.max_fps = 120
config.term = "xterm-256color" -- Set the terminal type
config.alternate_buffer_wheel_scroll_speed = 1
config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		mods = "NONE",
		action = act.ScrollByLine(-1),
	},
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		mods = "NONE",
		action = act.ScrollByLine(1),
	},
}

config.font = wezterm.font("JetBrains Mono", { weight = "Bold" }) -- "Hack Nerd Font Mono" "Monaspace Radon"
config.cell_width = 0.95
config.prefer_egl = true
config.font_size = 15 -- 16
config.initial_cols = 120 -- Set the initial width to 120 columns
config.initial_rows = 30 -- Set the initial height to 30 rows
config.window_background_opacity = 0.85

-- config.win32_system_backdrop = "Tabbed" -- "Acrylic"
-- config.window_background_opacity = 0
-- config.window_background_gradient = {
-- 	colors = { "#0f0c29", "#302b63", "#24243e" },
-- 	-- colors = { "#004d4d", "#006666", "#008080" },
-- 	orientation = { Linear = { angle = -45.0 } },
-- }

config.window_padding = {
	left = 4,
	right = 0,
	top = 7,
	bottom = 0,
}

config.inactive_pane_hsb = {
	saturation = 1.2,
	brightness = 0.25,
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

-- keymaps
config.keys = {
	{ key = "`", mods = "CTRL", action = "ShowTabNavigator" },
	{ key = "~", mods = "CTRL|SHIFT", action = "ShowLauncher" },

	-- move
	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },

	{ key = "h", mods = "CTRL|SHIFT|ALT", action = act({ AdjustPaneSize = { "Left", 1 } }) },
	{ key = "j", mods = "CTRL|SHIFT|ALT", action = act({ AdjustPaneSize = { "Down", 1 } }) },
	{ key = "k", mods = "CTRL|SHIFT|ALT", action = act({ AdjustPaneSize = { "Up", 1 } }) },
	{ key = "l", mods = "CTRL|SHIFT|ALT", action = act({ AdjustPaneSize = { "Right", 1 } }) },

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
	{
		key = "UpArrow",
		mods = "CTRL|SHIFT",
		action = act.SendKey({
			key = "UpArrow",
			mods = "CTRL|SHIFT",
		}),
	},
	{
		key = "DownArrow",
		mods = "CTRL|SHIFT",
		action = act.SendKey({
			key = "DownArrow",
			mods = "CTRL|SHIFT",
		}),
	},

	-- tmux like
	{
		key = "\\",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "-",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = "Backspace",
		mods = "CTRL|ALT",
		action = act({ CloseCurrentPane = { confirm = true } }),
	},
	{
		key = "Backspace",
		mods = "CTRL|SHIFT|ALT",
		action = act({ CloseCurrentTab = { confirm = true } }),
	},
	-- copy and paste
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("PrimarySelection") },

	-- other config
	{
		key = "E",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
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
		key = "0",
		mods = "CTRL",
		action = act.PaneSelect({
			mode = "SwapWithActive",
		}),
	},
	{
		key = "O",
		mods = "CTRL|ALT",
		-- toggling opacity
		action = wezterm.action_callback(function(window, _)
			local overrides = window:get_config_overrides() or {}
			if overrides.window_background_opacity == 1.0 then
				overrides.window_background_opacity = 0.8 --0.8
			else
				overrides.window_background_opacity = 1.0
			end
			window:set_config_overrides(overrides)
		end),
	},
}

config.color_scheme = "Popping and Locking" -- "Cloud (terminal.sexy)" "Argonaut"
config.force_reverse_video_cursor = true

config.window_decorations = "RESIZE" -- "INTEGRATED_BUTTONS|RESIZE"
config.default_prog = { "C:\\Users\\corcl\\AppData\\Local\\Programs\\nu\\bin\\nu.exe" }

-- load cái ảnh xong terminal lag vl khuyên là máy yếu không nên bật
-- config.window_background_image = "C:\\Users\\corcl\\Pictures\\guts.png"
-- config.window_background_image_hsb = {
-- 	brightness = 0.1,
-- }

-- tabs
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.colors = {
	tab_bar = {
		background = "rgba(0, 0, 0, 0%)",
		active_tab = {
			bg_color = "rgba(0, 0, 0, 0%)",
			-- fg_color = "#cfff93",
			-- fg_color = "#957fb8",
			fg_color = "#66cbf1",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = "rgba(0, 0, 0, 0%)",
			fg_color = "#f8f2f5",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		new_tab = {
			bg_color = "rgba(0, 0, 0, 0%)",
			fg_color = "white",
		},
	},
}

function get_max_cols(window)
	local tab = window:active_tab()
	local cols = tab:get_size().cols
	return cols
end

wezterm.on("window-config-reloaded", function(window)
	wezterm.GLOBAL.cols = get_max_cols(window)
end)

wezterm.on("window-resized", function(window, pane)
	wezterm.GLOBAL.cols = get_max_cols(window)
end)

-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
-- 	local title = tab.active_pane.title
-- 	local full_title = "[" .. tab.tab_index + 1 .. "] " .. title
-- 	local pad_length = (wezterm.GLOBAL.cols // #tabs - #full_title) // 2
-- 	if pad_length * 2 + #full_title > max_width then
-- 		pad_length = (max_width - #full_title) // 2
-- 	end
-- 	return string.rep(" ", pad_length) .. full_title .. string.rep(" ", pad_length)
-- end)

wezterm.on("update-status", function(window)
	local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	local color_scheme = window:effective_config().resolved_palette
	local bg = color_scheme.background
	local fg = color_scheme.foreground

	window:set_right_status(wezterm.format({
		{ Background = { Color = "none" } },
		{ Foreground = { Color = bg } },
		{ Text = SOLID_LEFT_ARROW },

		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = " " .. wezterm.hostname() .. " " },
		{ Text = "|" },
		-- { Text = os.getenv("USERNAME") .. " " },
		{
			Text = " 🎲🎮⏮️⏸️⏭️🎸🧑‍💻",
		},
		-- { Text = wezterm.home_dir .. " " },
		{ Text = " | " },
		{ Text = os.date("%d-%m-%Y %H:%M:%S") },
	}))
end)

return config
