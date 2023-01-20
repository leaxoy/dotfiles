return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-context" },
  build = ":TSUpdate",
  event = "BufReadPost",
  config = function()
    local ts_config_status, ts_config = pcall(require, "nvim-treesitter.configs")
    if not ts_config_status then return end

    local parsers = require("nvim-treesitter.parsers").get_parser_configs()

    parsers.thrift = {
      install_info = {
        url = "https://github.com/duskmoon314/tree-sitter-thrift",
        files = { "src/parser.c" },
        revision = "main",
      },
      filetype = "thrift",
    }

    parsers.kdl = {
      install_info = {
        url = "https://github.com/spaarmann/tree-sitter-kdl",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "main",
      },
      filetype = "kdl",
    }

    ts_config.setup {
      auto_install = true,
      highlight = { enable = true },
      incremental_selection = { enable = false },
      indent = { enable = true },
    }
    require("treesitter-context").setup {}
  end,
}
