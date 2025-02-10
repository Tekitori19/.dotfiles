-- Keset('n', '\\', 'zz')ymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Chế độ normal (Normal mode)
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<Tab>", "E", { noremap = true, silent = true })
map("n", "<S-Tab>", "B", { noremap = true, silent = true })

-- Sql query
map("n", "<leader>r", ":'<,'>DB", { noremap = true, silent = true })

-- Terminal
map("t", "<Leader><ESC>", "<C-\\><C-n>", { noremap = true })

-- paste nhưng không thay đổi register
map("x", "<leader>P", [["_dP]])

-- Xóa dòng nhưng không thay đổi register
map("v", "c", [["_c]])
map("n", "c", [["_c]])
map("n", "x", [["_x]])
map("n", "<S-X>", [["_dd]])
map("v", "x", [["_x]])

-- git keymaps
map("n", "<leader>gl", function()
  require("snacks").lazygit.log()
end, { desc = "Lazygit Logs" })
map("n", "<leader>gbr", function()
  require("snacks").picker.git_branches({ layout = "select" })
end, { desc = "Pick and Switch Git Branches" })

-- Duplicate a line and comment out the first line
map("n", "yc", "yygccp", { noremap = true })

map("i", "kj", "<ESC>")

-- Chế độ chèn (Insert mode)
-- map("i", "<C-h>", "<Left>", { noremap = true, silent = true })
-- map("i", "<C-j>", "<Right>", { noremap = true, silent = true })

-- Chế độ lệnh (Command mode)
map("c", "<C-h>", "<Left>", { noremap = true, silent = true })
map("c", "<C-l>", "<Right>", { noremap = true, silent = true })

-- Ctrl + A
map("n", "<C-a>", "ggVG", { noremap = true, silent = true })

-- zz
map("n", "\\", "zz", { noremap = true, silent = true })
