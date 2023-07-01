return {
  "neovim/nvim-lspconfig",
  ---@type LazyLspConfig
  opts = {
    servers = {
      gopls = {
        init_options = {
          allExperiments = true,
        },
        settings = {
          gopls = {
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              -- compositeLiteralTypes = true,
              constantValues = true,
              -- functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            ["formatting.gofumpt"] = true,
            ["ui.completion.experimentalPostfixCompletions"] = true,
            ["ui.completion.usePlaceholders"] = true,
            ["ui.codelenses"] = {
              gc_details = true,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            ["ui.diagnostic.analyses"] = {
              fieldalignment = true,
              nilness = true,
              shadow = true,
              unusedparams = true,
              unusedvariable = true,
              unusedwrite = true,
              useany = true,
            },
            ["ui.diagnostic.staticcheck"] = true,
          },
        },
      },
    },
  },
}
