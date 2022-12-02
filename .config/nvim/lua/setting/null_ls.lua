local SettingResitry = require "neoconf.plugins"

SettingResitry.register {
  on_schema = function(schema)
    schema:set("null_ls", {
      description = "null ls config",
      type = "object",
    })
    schema:set("null_ls.code_action", {
      description = "CodeAction config",
      type = "object",
    })
    schema:set("null_ls.diagnostic", {
      description = "Diagnostic config",
      type = "object",
    })
    schema:set("null_ls.formatter", {
      description = "Formatter config",
      type = "object",
    })

    local default_options = {
      enabled = { type = "boolean", description = "whether enabled" },
      extra_args = {
        type = "array",
        items = { type = "string" },
      },
      extra_filetypes = {
        type = "array",
        items = { type = "string" },
      },
      disabled_filetypes = {
        type = "array",
        items = { type = "string" },
      },
    }
    schema:set("null_ls.code_action.gitsigns", {
      description = "gitsigns code action",
      type = "object",
      properties = default_options,
    })
    schema:set("null_ls.code_action.refactoring", {
      description = "refactoring",
      type = "object",
      properties = default_options,
    })

    schema:set("null_ls.diagnostic.fish", {
      description = "fish shell script diagnostic",
      type = "object",
      properties = default_options,
    })
    schema:set("null_ls.diagnostic.golangci_lint", {
      description = "golangci_lint",
      type = "object",
      properties = default_options,
    })
    schema:set("null_ls.diagnostic.ruff", {
      description = "python ruff linter",
      type = "object",
      properties = default_options,
    })

    schema:set("null_ls.formatter.black", {
      description = "The uncompromising Python code formatter",
      type = "object",
      properties = default_options,
    })
    schema:set("null_ls.formatter.fish_indent", {
      description = "fish formatter options",
      type = "object",
      properties = default_options,
    })
    schema:set("null_ls.formatter.jq", {
      description = "Command-line JSON processor",
      type = "object",
      properties = default_options,
    })
    schema:set("null_ls.formatter.isort", {
      description = "A Python utility / library to sort imports",
      type = "object",
      properties = default_options,
    })
    schema:set("null_ls.formatter.stylua", {
      description = "An opinionated Lua code formatter",
      type = "object",
      properties = default_options,
    })
  end,
}
