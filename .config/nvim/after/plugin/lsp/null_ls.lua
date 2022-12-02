local status, null_ls = pcall(require, "null-ls")
if not status then return end

local settings = require "neoconf"

---@class LspConfig
---@field enabled boolean
---@field extra_args table<string>
---@field extra_filetypes table<string>
---@field disabled_filetypes table<string>

---@alias LspConfigGroup table<string, LspConfig>

---@class LspConfigSetting
---@field code_action LspConfigGroup
---@field diagnostic LspConfigGroup
---@field formatter LspConfigGroup

local ca = null_ls.builtins.code_actions
local diag = null_ls.builtins.diagnostics
local fmt = null_ls.builtins.formatting

local sources = {
  diag.cspell.with {
    diagnostics_postprocess = function(diagnostic) diagnostic.severity = vim.diagnostic.severity.WARN end,
    extra_args = { "--config", "~/.config/cspell/cspell.json" },
  },
}

---@param collection table<string, any>
---@param name string
---@param config LspConfig
---@param opts table|nil
local function gen_source(collection, name, config, opts)
  local args = vim.tbl_extend("keep", {
    extra_args = config.extra_args or {},
    extra_filetypes = config.extra_filetypes or {},
    disabled_filetypes = config.disabled_filetypes or {},
  }, opts or vim.empty_dict())
  return collection[name].with(args)
end

---@type LspConfigSetting
local null_ls_settings = settings.get("null_ls", {})
for name, config in pairs(null_ls_settings.code_action or vim.empty_dict()) do
  if config.enabled then table.insert(sources, gen_source(ca, name, config)) end
end
for name, config in pairs(null_ls_settings.diagnostic or vim.empty_dict()) do
  if config.enabled then table.insert(sources, gen_source(diag, name, config)) end
end
for name, config in pairs(null_ls_settings.formatter or vim.empty_dict()) do
  if config.enabled then table.insert(sources, gen_source(fmt, name, config)) end
end

null_ls.setup {
  border = "double",
  sources = sources,
}

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
