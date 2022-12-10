local status, null_ls = pcall(require, "null-ls")
if not status then return end

---@class NullLsSetting
---@field enabled boolean
---@field extra_args table<string>
---@field extra_filetypes table<string>
---@field disabled_filetypes table<string>
---@class NullLsConfig
---@field code_action table<string, NullLsSetting>
---@field diagnostic table<string, NullLsSetting>
---@field formatter table<string, NullLsSetting>

settings.register {
  on_schema = function(schema)
    schema:set("null_ls", {
      description = "null ls config",
      type = "object",
    })
    schema:set("null_ls.code_action", {
      description = "CodeAction config",
      type = "object",
    })
    schema:set("null_ls.diagnostic", {
      description = "Diagnostic config",
      type = "object",
    })
    schema:set("null_ls.formatter", {
      description = "Formatter config",
      type = "object",
    })

    local ft_options = require "null-ls.builtins._meta.filetype_map"
    local all_filetypes = vim.tbl_keys(ft_options)

    local default_options = {
      enabled = { type = "boolean", description = "Whether enabled" },
      extra_args = {
        type = "array",
        description = "additional args passed to cli tool",
        items = { type = "string" },
      },
      extra_filetypes = {
        type = "array",
        description = "additional filetypes passed to cli tool",
        items = { type = "string", enum = all_filetypes },
      },
      disabled_filetypes = {
        type = "array",
        description = "disabled filetypes for cli tool",
        items = { type = "string", enum = all_filetypes },
      },
    }

    local templete = {
      with_source = "%s: %s\nDescription: %s\nHomepage: %s\nDefault Filetypes: [%s]",
      without_source = "%s: %s\nDefault Filetypes: [%s]",
    }

    ---@param type_ string
    ---@param name string
    ---@param module string
    ---@param fts table|nil
    local function desc(type_, name, module, fts)
      local source_status, source = pcall(require, "null-ls.builtins." .. module .. "." .. name)
      if source_status then
        return string.format(
          templete.with_source,
          type_,
          name,
          source.meta and source.meta.description or "",
          source.meta and source.meta.url or "",
          table.concat(fts or { "all" }, ", ")
        )
      else
        return string.format(
          templete.without_source,
          type_,
          name,
          table.concat(fts or { "all" }, ", ")
        )
      end
    end

    for name, cfg in pairs(require "null-ls.builtins._meta.code_actions") do
      schema:set("null_ls.code_action." .. name, {
        description = desc("CodeAction", name, "code_actions", cfg.filetypes),
        type = "object",
        properties = default_options,
      })
    end
    for name, cfg in pairs(require "null-ls.builtins._meta.diagnostics") do
      schema:set("null_ls.diagnostic." .. name, {
        description = desc("Diagnostic", name, "diagnostics", cfg.filetypes),
        type = "object",
        properties = default_options,
      })
    end
    for name, cfg in pairs(require "null-ls.builtins._meta.formatting") do
      schema:set("null_ls.formatter." .. name, {
        description = desc("Formatter", name, "formatting", cfg.filetypes),
        type = "object",
        properties = default_options,
      })
    end
  end,
}

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
