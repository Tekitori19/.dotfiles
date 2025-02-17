local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
local config = wezterm.config_builder()

-- local gpus = wezterm.gui.enumerate_gpus()
-- config.webgpu_preferred_adapter = gpus[1]
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

-- config.front_end = "OpenGL"
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
config.font_size = 12 -- 16
config.initial_cols = 120 -- Set the initial width to 120 columns
config.initial_rows = 30 -- Set the initial height to 30 rows
config.tab_max_width = 32
-- config.window_background_opacity = 0.95

-- config.win32_system_backdrop = "Tabbed" -- "Acrylic"
-- config.win32_system_backdrop = "Acrylic"
config.window_background_opacity = 0.8
config.window_background_gradient = {
	colors = { "#222222", "#0f3443", "#3b4758", "#555555" },
	-- colors = { "#000000", "#292E49", "#403B4A", "#536976", "#BBD2C5" },
	orientation = { Linear = { angle = 45.0 } },
}

config.window_padding = {
	left = 2,
	right = 0,
	top = 0,
	bottom = 0,
}

config.inactive_pane_hsb = {
	saturation = 1.2,
	brightness = 0.25,
}

-- Hyperlink
config.hyperlink_rules = wezterm.default_hyperlink_rules()
-- e-mail fulano-ciclano@example.com fulano_ciclano@example.com
table.insert(config.hyperlink_rules, {
	regex = "\\b[A-Z-a-z0-9-_\\.]+@[\\w-]+(\\.[\\w-]+)+\\b",
	format = "mailto:$0",
})

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
			fg_color = "#282C34",
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

wezterm.on("update-status", function(window)
	local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	local color_scheme = window:effective_config().resolved_palette
	-- local bg = color_scheme.background
	-- local fg = color_scheme.foreground
	local bg = "#E5C07B"
	local fg = "#282C34"

	window:set_right_status(wezterm.format({
		{ Background = { Color = "none" } },
		{ Foreground = { Color = bg } },
		{ Text = SOLID_LEFT_ARROW },
		-- { Text = "" },

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

local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, conf, hover, max_width)
	local background = "#65737E"
	local foreground = "#F0F2F5"
	local edge_background = "rgba(0, 0, 0, 0%)"

	if tab.is_active or hover then
		background = "#E5C07B"
		foreground = "#282C34"
	end
	local edge_foreground = background

	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	local max = config.tab_max_width - 25
	if #title > max then
		title = wezterm.truncate_right(title, max) .. "…"
	end
	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = "" },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Attribute = { Intensity = tab.is_active and "Bold" or "Normal" } },
		{ Text = " " .. (tab.tab_index + 1) .. ": " .. title .. " " },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = " " },
	}
end)

return config
