-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- Chế độ chèn (Insert mode)
map("i", "<C-h>", "<Left>", { noremap = true, silent = true })
-- map("i", "<C-j>", "<Down>", { noremap = true, silent = true })
-- map("i", "<C-k>", "<Up>", { noremap = true, silent = true })
map("i", "<C-l>", "<Right>", { noremap = true, silent = true })

-- Chế độ lệnh (Command mode)
map("c", "<C-h>", "<Left>", { noremap = true, silent = true })
-- map("c", "<C-j>", "<Down>", { noremap = true, silent = true })
-- map("c", "<C-k>", "<Up>", { noremap = true, silent = true })
map("c", "<C-l>", "<Right>", { noremap = true, silent = true })
