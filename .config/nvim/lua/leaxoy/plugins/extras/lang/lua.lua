return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "folke/neodev.nvim", config = true },
  },
  opts = {
    servers = {
      lua_ls = {},
    },
  },
}
