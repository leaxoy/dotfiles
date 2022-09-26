-- VsCode specific config
if vim.g.vscode then return end

local status, impatient = pcall(require, "impatient")
if status then impatient.enable_profile() end

require("base")
pcall(require, "local_option") -- try load local config, can override option
require("plugins")
require("commands")
require("keybinding")
require("lsp")
