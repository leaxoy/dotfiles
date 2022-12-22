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

ts_config.setup {
  auto_install = true,
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true },
}
