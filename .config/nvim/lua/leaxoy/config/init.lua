require "leaxoy.config.prelude"
require "leaxoy.config.base"
require "leaxoy.config.commands"
require "leaxoy.config.keymap"
require "leaxoy.config.diagnostic"
require "leaxoy.config.lsp"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup {
  spec = {
    { import = "leaxoy.plugins.extras.lang.go" },
    { import = "leaxoy.plugins.extras.lang.json" },
    { import = "leaxoy.plugins.extras.lang.lua" },
    { import = "leaxoy.plugins.extras.lang.python" },
    { import = "leaxoy.plugins.extras.lang.rust" },
    { import = "leaxoy.plugins" },
  },
  checker = { enabled = true, frequency = 600 },
  diff = { cmd = "diffview.nvim" },
  install = { colorscheme = { "catppuccin", "vscode", "habamax" } },
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = { border = "double" },
}
