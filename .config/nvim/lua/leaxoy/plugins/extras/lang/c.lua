return {
  "neovim/nvim-lspconfig",
  dependencies = { "p00f/clangd_extensions.nvim" },
  opts = {
    setups = {
      clangd = function(opts)
        ---@type lspconfig.options.clangd
        opts.capabilities = opts.capabilities or vim.lsp.protocol.make_client_capabilities()
        opts.capabilities.offsetEncoding = { "utf-16" }

        map { "gh", "<CMD>ClangdSwitchSourceHeader<CR>", desc = "Goto header file" }

        require("clangd_extensions").setup {
          server = opts,
          extensions = {
            autoSetHints = false,
            ast = {
              kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
              },
              role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
              },
            },
            memory_usage = { border = "rounded" },
            symbol_info = { border = "rounded" },
          },
        }
      end,
    },
  },
}
