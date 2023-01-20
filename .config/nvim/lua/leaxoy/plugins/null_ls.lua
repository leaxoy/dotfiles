local function config_settings()
  local builtin_code_actions = require "null-ls.builtins._meta.code_actions"
  local builtin_formattings = require "null-ls.builtins._meta.formatting"
  local builtin_diagnostics = require "null-ls.builtins._meta.diagnostics"

  require("neoconf.plugins").register {
    name = "null_ls",
    on_schema = function(schema)
      schema:set("null_ls", {
        type = "object",
        description = "NullLs Source Config",
        properties = {
          code_action = {
            type = "object",
          },
          diagnostic = {
            type = "object",
          },
          formatting = {
            type = "object",
          },
        },
      })
    end,
    on_update = nil,
    setup = nil,
  }
end

return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "jay-babu/mason-null-ls.nvim", "nvim-lua/plenary.nvim" },
  event = "BufReadPost",
  config = function()
    --    config_settings()

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
      -- diag.golangci_lint.with { diagnostics_format = "[#{c}] #{m} (#{s})" },

      fmt.black,
      fmt.fish_indent,
      fmt.jq.with { extra_args = { "-S" }, extra_filetypes = { "jsonc" } },
      fmt.stylua,
    }

    null_ls.setup { border = "double", sources = sources }

    require("mason-null-ls").setup {
      automatic_installation = true,
      ensure_installed = {
        --code actions
        "gomodifytags",

        -- diagnostic
        "codespell",
        "fish",
        -- "golangci_lint",

        -- formatter
        "black",
        "jq",
        "stylua",
      },
    }
  end,
}
