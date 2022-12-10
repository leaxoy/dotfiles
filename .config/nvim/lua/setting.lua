local setting = require "neoconf"
local settingRegistry = require "neoconf.plugins"

setting.setup { plugins = { jsonls = { configured_servers_only = false } } }

vim.keymap.set(
  "n",
  "<leader>,",
  [[<CMD>Neoconf global<CR>]],
  { silent = true, noremap = true, desc = "Global Settings" }
)
vim.keymap.set(
  "n",
  "<leader>;",
  [[<CMD>Neoconf local<CR>]],
  { silent = true, noremap = true, desc = "Local Settings" }
)

require "setting.mason"
require "setting.neovim"
require "setting.null_ls"
require "setting.treesitter"

_G.settings = {}

---@generic T: string|integer|boolean|table
---@param key string
---@param default T|nil
---@return T
function _G.settings.get(key, default) return setting.get(key, default) end

---@generic T: table
---@param lsp string
---@param default T
---@return T
function _G.settings.get_lsp_config(lsp, default)
  return setting.get(string.format("lspconfig.%s", lsp), default)
end

---@return NullLsConfig
function _G.settings.get_null_ls_config() return setting.get("null_ls", {}) end

---@return table
function _G.settings.get_ui_config() return setting.get("vim.ui", {}) end

---@return table
function _G.settings.get_vim_global_config() return setting.get("vim.global", {}) end

---@return table
function _G.settings.get_vim_buf_config() return setting.get("vim.buf", {}) end

---@return table
function _G.settings.get_vim_win_config() return setting.get("vim.win", {}) end

---@param plugin SettingsPlugin
function _G.settings.register(plugin) settingRegistry.register(plugin) end
