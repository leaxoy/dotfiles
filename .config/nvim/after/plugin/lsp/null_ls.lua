local status, null_ls = pcall(require, "null-ls")
if not status then return end

local ca = null_ls.builtins.code_actions
local diag = null_ls.builtins.diagnostics
local fmt = null_ls.builtins.formatting

null_ls.setup {
  sources = {
    ca.gitsigns,
    ca.refactoring.with {
      extra_filetypes = { "c", "cpp", "java" },
    },

    diag.cspell.with {
      diagnostics_postprocess = function(diagnostic) diagnostic.severity = vim.diagnostic.severity.WARN end,
      extra_args = { "--config", "~/.config/cspell/cspell.json" },
    },
    diag.fish,
    diag.ruff,

    fmt.black,
    fmt.fish_indent,
    fmt.jq.with { args = { "--sort-keys" } },
    fmt.isort,
    fmt.stylua,
  },
}

local mason_status, mason_adapter = pcall(require, "mason-null-ls")
if mason_status then
  mason_adapter.setup {
    automatic_installation = true,
    ensure_installed = {
      -- diagnostic
      "cspell",
      "fish",
      "ruff",

      -- formatter
      "black",
      "jq",
      "isort",
      "stylua",
    },
  }
end
