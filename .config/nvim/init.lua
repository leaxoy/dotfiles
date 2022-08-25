require("base")

pcall(require, "local_option") -- try load local config, can override option

require("plugins")
require("impatient").enable_profile()
require("highlight")
require("commands")
require("keybinding")
require("lsp").setup()
