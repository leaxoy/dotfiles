local SettingRegistry = require "neoconf.plugins"

---@class NeovimConfig
---@field buf table<string, any>
---@field global table<string, any>
---@field win table<string, any>

---@class NeovimUiConfig
---@field statusBar.git table
---@field statusBar.lsp_info table

SettingRegistry.register {
  on_schema = function(schema)
    schema:set("vim", {
      description = "vim options",
      type = "object",
    })
    schema:set("vim.buf", {
      description = "Buffer local options",
      type = "object",
      properties = {},
    })
    schema:set("vim.global", {
      description = "Global options",
      type = "object",
      properties = {},
    })
    schema:set("vim.win", {
      description = "Window local options",
      type = "object",
      properties = {},
    })
    schema:set("vim.ui", {
      description = "Ui options",
      type = "object",
      properties = {
        ["statusBar.git"] = {
          description = "StatusBar git component",
          type = "object",
          properties = {
            enabled = {
              type = "boolean",
              description = "Whether enabled git component",
              default = true,
            },
            with_diff = {
              type = "boolean",
              description = "Whether show diff info",
              default = true,
            },
          },
        },
        ["statusBar.lsp_info"] = {
          description = "StatusBar lsp_info component",
          type = "object",
          properties = {
            enabled = {
              type = "boolean",
              description = "Whether enabled lsp_info component",
              default = true,
            },
          },
        },
      },
    })

    local all_opts = vim.api.nvim_get_all_options_info()
    for name, opt in pairs(all_opts) do
      local status, new
      if opt.scope == "win" then
        status, new = pcall(vim.api.nvim_win_get_option, 0, name)
      elseif opt.scope == "buf" then
        status, new = pcall(vim.api.nvim_buf_get_option, 0, name)
      elseif opt.scope == "global" then
        status, new = pcall(vim.api.nvim_get_option, name)
      end
      if not status then new = opt.default end
      schema:set("vim." .. opt.scope .. "." .. name, {
        type = opt.type,
        default = opt.default,
        description = string.format(
          "Type: %s\nDefault Value: %s\nUser Setting: %s",
          opt.type,
          opt.default,
          new
        ),
      })
    end
  end,
}
