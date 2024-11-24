-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Chế độ normal (Normal mode)
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<Tab>", "E", { noremap = true, silent = true })
map("n", "<S-Tab>", "B", { noremap = true, silent = true })

map("t", "<Leader><ESC>", "<C-\\><C-n>", { noremap = true })

-- paste nhưng không thay đổi register
map("x", "<leader>P", [["_dP]])

-- Xóa dòng nhưng không thay đổi register
map("n", "<C-x>", [["_x]])
map("n", "<C-X>", [["_dd]])
map("v", "<C-x>", [["_x]])
map("v", "<C-X>", [["_dd]])

map("i", "jk", "<ESC>")

-- Chế độ chèn (Insert mode)
map("i", "<C-h>", "<Left>", { noremap = true, silent = true })
map("i", "<C-l>", "<Right>", { noremap = true, silent = true })

-- Chế độ lệnh (Command mode)
map("c", "<C-h>", "<Left>", { noremap = true, silent = true })
map("c", "<C-l>", "<Right>", { noremap = true, silent = true })
