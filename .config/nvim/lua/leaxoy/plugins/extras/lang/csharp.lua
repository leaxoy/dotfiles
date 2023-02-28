return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "Hoffs/omnisharp-extended-lsp.nvim" },
  },
  opts = {
    setups = {
      omnisharp = function(opts)
        ---@type lspconfig.options.omnisharp
        opts = vim.tbl_extend("force", opts or vim.empty_dict(), {
          handlers = {
            ["textDocument/definition"] = require("omnisharp_extended").handler,
          },
        })
        require("lspconfig").omnisharp.setup(opts)
      end,
    },
  },
}
