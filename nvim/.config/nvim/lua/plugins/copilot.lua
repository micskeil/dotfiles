return {
  "zbirenbaum/copilot.lua",
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      debounce = 75,
      keymap = {
        accept = "<C-j>",
        accept_word = "C-k>",
        accept_line = "<C-l>",
        next = "<C-]>",
        prev = "<C-[>",
        dismiss = "<C-d>",
      },
    },
  },
}
