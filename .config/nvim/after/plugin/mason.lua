local status, mason = pcall(require, "mason")
if not status then return end

settings.register {
  on_schema = function(schema)
    local mason_registry = require "mason-registry"

    schema:set("mason", { description = "Mason is neovim package manager", type = "object" })
    local mason_tools = {}
    local packages = mason_registry.get_all_packages()
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
        local desc =
          string.format("%s\nHomepage: [%s](%s)", tool.spec.desc, tool.name, tool.spec.homepage)
        table.insert(descriptions, desc)
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

mason.setup {
  ui = {
    border = "double",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
}
