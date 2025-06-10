-- plugins/linter.lua
return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        javascript = { "deno_lint" },
        javascriptreact = { "deno_lint" },
        typescript = { "deno_lint" },
        typescriptreact = { "deno_lint" },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft
      lint.linters.deno_lint = {
        name = "deno_lint",
        cmd = "deno",
        args = { "lint", "--unstable", "--json" },
        stdin = false,
        stream = "stderr",
        ignore_exitcode = true,
        parser = function(output)
          local diagnostics = {}
          for _, item in ipairs(vim.fn.json_decode(output) or {}) do
            table.insert(diagnostics, {
              lnum = item.range.start.line,
              col = item.range.start.character,
              end_lnum = item.range["end"].line,
              end_col = item.range["end"].character,
              source = "deno_lint",
              message = item.message,
              severity = vim.diagnostic.severity.WARN,
            })
          end
          return diagnostics
        end,
      }
    end,
  },
}
