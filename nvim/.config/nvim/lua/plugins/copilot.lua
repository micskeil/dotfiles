return {
  "zbirenbaum/copilot.lua",
  opts = {
    panel = {
      enabled = true,
      auto_refresh = true,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<C-M-CR>",
      },
      layout = {
        position = "bottom", -- | top | left | right | horizontal | vertical
        ratio = 0.4,
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      debounce = 75,
      keymap = {
        accept = "<Tab>",
        accept_word = "<C-w>",
        accept_line = "<C-j>",
        next = "<C-n>",
        prev = "<C-p>",
        dismiss = "<C-e>",
      },
    },
    filetypes = {
      yaml = false,
      markdown = false,
      help = false,
      gitcommit = false,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      ["."] = false,
    },
    copilot_node_command = "node", -- Node.js version must be > 18.x
    server_opts_overrides = {},
  },
}
