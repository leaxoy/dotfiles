require "leaxoy.config.base"
require "leaxoy.config.prelude"
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
  spec = "leaxoy.plugins",
  checker = { enabled = true },
  install = { colorscheme = { "tokyonight", "vscode", "habamax" } },
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
