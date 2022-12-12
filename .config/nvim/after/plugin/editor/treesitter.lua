local ts_config_status, ts_config = pcall(require, "nvim-treesitter.configs")
if not ts_config_status then return end

vim.settings.register {
  name = "treesitter",
  on_schema = function(schema)
    local all_configs = require("nvim-treesitter.parsers").get_parser_configs()

    local names = vim.tbl_keys(all_configs)
    local descriptions = {}
    for _, config in ipairs(all_configs) do
      table.insert(descriptions, config.install_info.url)
    end
    table.insert(names, "all")
    table.insert(descriptions, "all parsers")
    schema:set("treesitter", {
      description = "",
      type = "object",
    })
    schema:set("treesitter.filetypes", {
      description = 'A list of parser names, or "all"',
      type = "array",
      items = { type = "string", enum = names, enumDescriptions = descriptions },
      uniqueItems = true,
    })
    schema:set("treesitter.highlight", {
      description = "",
      type = "object",
      properties = {
        enable = {
          type = "boolean",
          default = true,
        },
      },
    })
  end,
}

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
  ensure_installed = vim.g.ts_syntaxes,
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true },
}
