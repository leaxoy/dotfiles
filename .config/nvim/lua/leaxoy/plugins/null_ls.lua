return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "jay-babu/mason-null-ls.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require "null-ls"

    local ca = null_ls.builtins.code_actions
    local diag = null_ls.builtins.diagnostics
    local fmt = null_ls.builtins.formatting

    local sources = {
      ca.gitsigns,
      ca.gomodifytags,
      ca.refactoring.with { extra_filetypes = { "c", "cpp", "java" } },

      diag.codespell.with { diagnostics_format = "[#{c}] #{m} (#{s})" },
      diag.fish.with { diagnostics_format = "[#{c}] #{m} (#{s})" },
      diag.golangci_lint.with { diagnostics_format = "[#{c}] #{m} (#{s})" },

      fmt.black,
      fmt.fish_indent,
      fmt.jq.with { extra_args = { "-S" }, extra_filetypes = { "jsonc" } },
      fmt.stylua,
    }

    null_ls.setup { border = "double", sources = sources }

    local mason_status, mason_adapter = pcall(require, "mason-null-ls")
    if mason_status then
      mason_adapter.setup {
        automatic_installation = true,
        ensure_installed = {
          --code actions
          "gomodifytags",

          -- diagnostic
          "codespell",
          "fish",
          "golangci_lint",

          -- formatter
          "black",
          "jq",
          "stylua",
        },
      }
    end
  end,
}
