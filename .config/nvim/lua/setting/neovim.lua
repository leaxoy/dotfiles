local SettingRegistry = require "neoconf.plugins"

---@class Setting
---@field key string
---@field schema table
---@type table<Setting>
local options = {
  {
    key = "workbench.theme",
    schema = {
      desc = "颜色主题",
      type = "string",
      enum = vim.fn.getcompletion("", "color"),
    },
  },
  {
    key = "editor.lineNumbers",
    schema = {
      desc = "编辑器行号",
      type = "string",
      default = "none",
      enum = { "none", "absolute", "relative" },
      enumDescriptions = {
        "Don't show line number",
        "Show absolute line number (start from 1)",
        "Show relative line number",
      },
    },
  },
  {
    key = "editor.listchars",
    schema = {
      type = "object",
      properties = {
        eol = { type = "string", default = "" },
        tab = { type = "string", default = "» " },
        space = { type = "string", default = " " },
        multispace = { type = "string", default = " " },
        lead = { type = "string", default = " " },
        leadmultispace = { type = "string", default = " " },
        trail = { type = "string", default = "·" },
        extends = { type = "string", default = "›" },
        precedes = { type = "string", default = "‹" },
        conceal = { type = "string", default = " " },
        nbsp = { type = "string", default = "·" },
      },
    },
  },
  {
    key = "editor.ruler",
    schema = {
      type = "boolean",
      default = true,
    },
  },
  {
    key = "editor.rulercolumn",
    schema = {
      type = "integer",
      default = 80,
    },
  },
  {
    key = "search.hlsearch",
    schema = {
      description = "",
      type = "boolean",
      default = true,
    },
  },
  {
    key = "search.incsearch",
    schema = {
      description = "",
      type = "boolean",
      default = true,
    },
  },
  {
    key = "search.ignorecase",
    schema = {
      description = "",
      type = "boolean",
      default = true,
    },
  },
  {
    key = "search.smartcase",
    schema = {
      description = "",
      type = "boolean",
      default = true,
    },
  },
  {
    key = "search.showmatch",
    schema = {
      description = "",
      type = "boolean",
      default = true,
    },
  },
}

SettingRegistry.register {
  on_schema = function(schema)
    schema:set("vim", {
      description = "vim options",
      type = "object",
    })
    for _, option in ipairs(options) do
      schema:set("vim." .. option.key, option.schema)
    end
  end,
}
