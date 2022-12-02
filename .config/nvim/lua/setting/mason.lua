local registry_status, registry = pcall(require, "mason-registry")
if not registry_status then return end

local SettingRegistry = require "neoconf.plugins"

SettingRegistry.register {
  on_update = function(event) ---@diagnostic disable-line
    ---@type table<string, table<string>>
    local mason_config = require("neoconf").get("mason", {})
    local tools = vim.tbl_flatten(mason_config)
    require("mason.api.command").MasonInstall(tools, { debug = false })
  end,
  on_schema = function(schema)
    schema:set("mason", { description = "Mason is neovim package manager", type = "object" })

    local mason_tools = {}
    local packages = registry.get_all_packages()
    for _, package in ipairs(packages) do
      for _, category in ipairs(package.spec.categories) do
        if not mason_tools[category] then mason_tools[category] = {} end
        table.insert(mason_tools[category], package)
      end
    end

    for category, tools in pairs(mason_tools) do
      local names = {}
      local descriptions = {}
      for _, tool in ipairs(tools) do
        table.insert(names, tool.name)
        table.insert(descriptions, tool.spec.desc)
      end
      schema:set("mason." .. string.lower(category), {
        description = category .. " tools",
        type = "array",
        uniqueItems = true,
        items = { type = "string", enum = names, enumDescriptions = descriptions },
      })
    end
  end,
}
