return {
  "neovim/nvim-lspconfig",
  ---@type LazyLspConfig
  opts = {
    servers = {
      gopls = {
        settings = {
          gopls = {
            semanticTokens = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              -- compositeLiteralTypes = true,
              constantValues = true,
              -- functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            completeUnimported = true,
            gofumpt = true,
            usePlaceholders = true,
            codelenses = {
              gc_details = true,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              shadow = true,
              unusedparams = true,
              unusedvariable = true,
              unusedwrite = true,
              useany = true,
            },
            staticcheck = true,
          },
        },
      },
    },
  },
}
