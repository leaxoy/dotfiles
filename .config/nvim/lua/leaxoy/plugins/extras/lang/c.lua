return {
  "neovim/nvim-lspconfig",
  opts = {
    setups = {
      clangd = function(opts)
        ---@type lspconfig.options.clangd
        opts.capabilities = opts.capabilities or vim.lsp.protocol.make_client_capabilities()
        opts.capabilities.offsetEncoding = { "utf-8" }
        require("lspconfig").clangd.setup(opts)
      end,
    },
  },
}
