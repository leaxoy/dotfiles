local status, null_ls = pcall(require, "null-ls")
if not status then return end

local ca = null_ls.builtins.code_actions
local diag = null_ls.builtins.diagnostics
local fmt = null_ls.builtins.formatting

fmt.ruff = require("null-ls.helpers").make_builtin {
  name = "ruff",
  meta = {
    url = "https://github.com/charliermarsh/ruff",
    description = "An extremely fast Python linter, written in Rust.",
  },
  method = require("null-ls.methods").internal.FORMATTING,
  filetypes = { "python" },
  generator_opts = {
    command = "ruff",
    args = { "--fix", "-e", "-n", "--stdin-filename", "$FILENAME", "-" },
    to_stdin = true,
  },
  factory = require("null-ls.helpers").formatter_factory,
}

local sources = {
  diag.cspell.with {
    diagnostics_postprocess = function(diagnostic)
      diagnostic.severity = vim.diagnostic.severity.WARN
    end,
    extra_args = { "--config", "~/.config/cspell/cspell.json" },
  },
  fmt.ruff,
}

---@param collection table<string, any>
---@param name string
---@param config NullLsSetting
---@param opts table|nil
local function gen_source(collection, name, config, opts)
  local args = vim.tbl_extend("keep", {
    extra_args = config.extra_args or {},
    extra_filetypes = config.extra_filetypes or {},
    disabled_filetypes = config.disabled_filetypes or {},
  }, opts or vim.empty_dict())
  return collection[name].with(args)
end

---@type NullLsConfig
local null_ls_settings = settings.get_null_ls_config()
for name, config in pairs(null_ls_settings.code_action or vim.empty_dict()) do
  if config.enabled then table.insert(sources, gen_source(ca, name, config)) end
end
for name, config in pairs(null_ls_settings.diagnostic or vim.empty_dict()) do
  if config.enabled then table.insert(sources, gen_source(diag, name, config)) end
end
for name, config in pairs(null_ls_settings.formatter or vim.empty_dict()) do
  if config.enabled then table.insert(sources, gen_source(fmt, name, config)) end
end

null_ls.setup { border = "double", sources = sources }

local mason_status, mason_adapter = pcall(require, "mason-null-ls")
if mason_status then
  mason_adapter.setup {
    automatic_installation = true,
    ensure_installed = {
      -- diagnostic
      "cspell",
      "fish",
      "golangci_lint",
      "ruff",

      -- formatter
      "black",
      "jq",
      "isort",
      "stylua",
    },
  }
end
