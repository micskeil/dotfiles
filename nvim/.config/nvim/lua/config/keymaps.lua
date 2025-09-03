-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keYmaps here

local map = LazyVim.safe_keymap_set

-- save file
vim.keymap.del("i", "<C-s>")
map({ "i" }, "<C-s>", "<esc><esc>", { desc = "Save File" })

vim.keymap.set("n", "<leader>fp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy full file path" })

vim.keymap.set("n", "<leader>cp", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
end, { desc = "Copy relative file path" })

vim.keymap.set("n", "<leader>yp", function()
  local git_root = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")
  local file_path = vim.fn.expand("%:p")
  local relative_path = file_path:gsub("^" .. git_root .. "/", "")
  vim.fn.setreg("+", relative_path)
end, { desc = "Copy git-relative file path" })
