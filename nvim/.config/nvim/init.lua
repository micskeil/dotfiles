-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- set the title of the terminal to the current directory
vim.o.title = true
vim.o.titlestring = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " - nvim"

-- set the title of the terminal to the current directory when leaving nvim
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    os.execute('echo -ne "\\033]0;' .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. ' - bash\\007"')
  end,
})
