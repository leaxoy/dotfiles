return {
  "neovim/nvim-lspconfig",
  dependencies = { "creativenull/efmls-configs-nvim" },
  ---@type LazyLspConfig
  opts = {
    servers = {},
    setups = {
      efm = function(_)
        require("efmls-configs").init {
          default_config = true,
          init_options = { documentFormatting = true },
        }
        require("efmls-configs").setup {
          python = {
            linter = require "efmls-configs.linters.pylint",
            formatter = require "efmls-configs.formatters.black",
          },
          yaml = {
            formatter = require "efmls-configs.formatters.prettier",
          },
        }
      end,
    },
  },
}
