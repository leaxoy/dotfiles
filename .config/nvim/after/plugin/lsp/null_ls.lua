local status, null_ls = pcall(require, "null-ls")
if not status then return end

null_ls.setup {
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.refactoring,

    null_ls.builtins.diagnostics.cspell.with {
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity.WARN
      end,
      extra_args = { "--config", "~/.config/cspell/cspell.json" }
    },
    null_ls.builtins.diagnostics.fish,

    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
  }
}

local mason_status, mason_adapter = pcall(require, "mason-null-ls")
if mason_status then
  mason_adapter.setup {
    auto_update = true,
    automatic_installation = true,
    ensure_installed = {
      { "cspell" },

      { "black" },
      { "isort" },
    },
  }
end
