local status, null_ls = pcall(require, "null-ls")
if not status then return end

local ca = null_ls.builtins.code_actions
local diag = null_ls.builtins.diagnostics
local fmt = null_ls.builtins.formatting

null_ls.setup {
  sources = {
    ca.gitsigns,
    ca.refactoring.with {
      extra_filetypes = { "c", "cpp", "java" }
    },

    diag.cspell.with {
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity.WARN
      end,
      extra_args = { "--config", "~/.config/cspell/cspell.json" }
    },
    diag.fish,
    diag.todo_comments,

    fmt.black,
    fmt.fish_indent,
    fmt.isort,
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
