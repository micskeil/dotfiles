-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set
-- save file
vim.keymap.del("i", "<C-s>")
map({ "i" }, "<C-s>", "<esc><esc>", { desc = "Save File" })
