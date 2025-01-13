-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
-- This will hold the configuration.
local config = wezterm.config_builder()

-- local gpus = wezterm.gui.enumerate_gpus()
-- config.webgpu_preferred_adapter = gpus[1]
-- config.front_end = "WebGpu"

config.front_end = "OpenGL"
config.max_fps = 120
config.term = "xterm-256color" -- Set the terminal type

config.font = wezterm.font("Monaspace Radon", { weight = "Medium" })
config.cell_width = 0.95
config.prefer_egl = true
config.font_size = 14
-- config.font_size = 16
config.initial_cols = 120 -- Set the initial width to 120 columns
config.initial_rows = 30 -- Set the initial height to 30 rows

config.window_background_opacity = 0.8
-- config.win32_system_backdrop = "Tabbed"
-- config.window_background_gradient = {
-- 	colors = { "#0f0c29", "#302b63", "#24243e" },
-- 	-- colors = { "#004d4d", "#006666", "#008080" },
-- 	orientation = { Linear = { angle = -45.0 } },
-- }

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
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
	-- { key = "Tab", mods = "CTRL|SHIFT", action = act.CopyMode("MoveForwardWord") },

	-- copy and paste
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("PrimarySelection") },

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
				overrides.window_background_opacity = 0 --0.8
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

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE" -- "RESIZE"
config.default_prog = { "C:\\Users\\corcl\\AppData\\Local\\Programs\\nu\\bin\\nu.exe" }

-- load cái ảnh xong terminal lag vl khuyên là máy yếu không nên bật
-- config.window_background_image = "C:\\Users\\corcl\\Pictures\\chill.png"
-- config.window_background_image = "C:\\Users\\corcl\\Pictures\\guts.png"

config.window_background_image_hsb = {
	brightness = 0.1,
}

-- local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
-- bar.apply_to_config(config)

-- tabs
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.colors = {
	tab_bar = {
		background = "rgba(0, 0, 0, 0%)",
		active_tab = {
			bg_color = "rgba(0, 0, 0, 0%)",
			fg_color = "#7FFF50",
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
			-- bg_color = "rgba(59, 34, 76, 50%)",
			bg_color = "rgba(0, 0, 0, 0%)",
			fg_color = "white",
		},
	},
}

-- and finally, return the configuration to wezterm
return config
