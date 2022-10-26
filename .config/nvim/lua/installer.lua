local mason_installed = require("mason-registry").get_installed_package_names()
local mason_installer = require("mason.api.command").MasonInstall

local function install(tools)
  local to_be_installed = {}
  for _, tool in ipairs(tools) do
    if not vim.tbl_contains(mason_installed, tool) then table.insert(to_be_installed, 0, tool) end
  end
  mason_installer(to_be_installed)
end

return {
  install = install,
}
