local SettingResitry = require "neoconf.plugins"

---@class NullLsSetting
---@field enabled boolean
---@field extra_args table<string>
---@field extra_filetypes table<string>
---@field disabled_filetypes table<string>
---@alias NullLsSettingGroup table<string, NullLsSetting>
---@class NullLsSettingSection
---@field code_action NullLsSettingGroup
---@field diagnostic NullLsSettingGroup
---@field formatting NullLsSettingGroup

SettingResitry.register {
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
      local status, source = pcall(require, "null-ls.builtins." .. module .. "." .. name)
      if status then
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
