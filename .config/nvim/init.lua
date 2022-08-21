require("base")

pcall(require, "local_option") -- try load local config, can override option

require("plugins")
require("impatient").enable_profile()

require("commands")
require("ui")
require("keybinding")
require("lsp").setup()
require("editor")
require("dbg")
require("vcs")
