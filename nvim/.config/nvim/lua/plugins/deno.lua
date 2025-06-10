return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Enable denols only when deno.json or deno.jsonc is present
        denols = {
          root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
          init_options = {
            lint = true,
            unstable = true,
          },
        },
        -- Disable tsserver in Deno projects
        tsserver = {
          root_dir = function(fname)
            local util = require("lspconfig.util")
            if util.root_pattern("deno.json", "deno.jsonc")(fname) then
              return nil
            end
            return util.root_pattern("package.json", "tsconfig.json", ".git")(fname)
          end,
        },
      },
    },
  },
}
