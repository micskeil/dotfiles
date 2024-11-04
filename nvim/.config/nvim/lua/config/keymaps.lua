-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keYmaps here

local map = LazyVim.safe_keymap_set
-- save file
vim.keymap.del("i", "<C-s>")

map({ "i" }, "<C-s>", "<esc><esc>", { desc = "Save File" })

-- Add border to terminal
local Util = require("lazyvim.util")
vim.keymap.set("n", "<C-_>", function()
  Util.terminal(nil, { border = "rounded" })
end, { desc = "Term with border" })
vim.keymap.set("n", "<C-/>", function()
  Util.terminal(nil, { border = "rounded" })
end, { desc = "Term with border" })
