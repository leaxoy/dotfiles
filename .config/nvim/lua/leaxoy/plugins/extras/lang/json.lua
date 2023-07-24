return {
  "neovim/nvim-lspconfig",
  dependencies = { "b0o/SchemaStore.nvim" },
  opts = {
    servers = {
      jsonls = {
        on_new_config = function(new_config)
          new_config.settings.json.schemas = new_config.settings.json.schemas or {}
          vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
        end,
        ---@type lspconfig.settings.jsonls
        settings = {},
      },
      yamlls = {
        on_new_config = function(new_config)
          new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
          vim.list_extend(new_config.settings.yaml.schemas, require("schemastore").json.schemas())
        end,
        ---@type lspconfig.settings.yamlls
        settings = {},
      },
    },
  },
}
