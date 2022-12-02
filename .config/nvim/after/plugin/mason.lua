local status, mason = pcall(require, "mason")
if not status then return end

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
