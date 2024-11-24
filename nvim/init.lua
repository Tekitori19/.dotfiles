-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.scrolloff = 8
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- vim.api.nvim_set_option("clipboard", "unnamed")
-- Check if 'pwsh' is executable and set the shell accordingly
-- if vim.fn.executable("pwsh") == 1 then
--   vim.o.shell = "pwsh"
-- else
--   vim.o.shell = "powershell"
-- end

-- Setting shell command flags
-- vim.o.shellcmdflag =
--   "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
--
-- -- Setting shell redirection
-- vim.o.shellredir = '2>&1 | %{ "$_" } | Out-File %s; exit $LastExitCode'
--
-- -- Setting shell pipe
-- vim.o.shellpipe = '2>&1 | %{ "$_" } | Tee-Object %s; exit $LastExitCode'
--
-- -- Setting shell quote options
-- vim.o.shellquote = "điếu thuốc tàn bên ly cà phê cạn"

-- vim.o.shell = "cmd"
vim.o.shell = "C:\\Users\\corcl\\AppData\\Local\\Programs\\nu\\bin\\nu.exe"
vim.o.shellcmdflag = "-c"
vim.o.shellquote = ""
vim.o.shellxquote = ""
-- vim.o.shell = "pwsh"

Snacks.dashboard.setup()

if vim.g.neovide then
  -- set true để gõ tiếng viêt
  vim.g.neovide_input_ime = true

  vim.g.neovide_refresh_rate = 120
  -- This is how fast the cursor animation "moves", default 0.06
  vim.g.neovide_cursor_animation_length = 0.04
  -- Default 0.7
  vim.g.neovide_cursor_trail_size = 0.7

  -- produce particles behind the cursor, if want to disable them, set it to ""
  -- vim.g.neovide_cursor_vfx_mode = "railgun"
  -- vim.g.neovide_cursor_vfx_mode = "torpedo"
  -- vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_mode = "sonicboom"
  -- vim.g.neovide_cursor_vfx_mode = "ripple"
  -- vim.g.neovide_cursor_vfx_mode = "wireframe"

  vim.g.neovide_scroll_animation_length = 0

  -- vim.g.neovide_transparency = 0.86

  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_left = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_bottom = 0
  -- Not support in current version
  -- vim.g.neovide_floating_blur_amount_x = 2.0
  -- vim.g.neovide_floating_blur_amount_y = 2.0
  -- vim.g.neovide_window_blurred = true
  -- vim.g.neovide_floating_shadow = true
  -- vim.g.neovide_floating_z_height = 10
  -- vim.g.neovide_light_angle_degrees = 45
  -- vim.g.neovide_light_radius = 5
  -- vim.g.neovide_background_color = "#7ea4c2"
  -- vim.g.neovide_background_image = "C:\\Users\\corcl\\Pictures\\my-girl.jpg"
end
