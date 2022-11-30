local conf_status, conf = pcall(require, "neoconf.plugins")
if not conf_status then return end

local defaults = {
  doit = true,
  count = 1,
  array = {},
}

conf.register {
  on_schema = function(schema)
    -- this call will create a json schema based on the lua types of your default settings
    schema:import("myplugin", defaults)
    -- Optionally update some of the json schema
    schema:set("myplugin.array", {
      description = "Special array containg booleans or numbers",
      anyOf = {
        { type = "boolean" },
        { type = "integer" },
      },
    })
  end,
}

local mason_config = {
  lsp = {},
  dap = {},
  formatter = {},
  lint = {},
}

conf.register {
  on_schema = function(schema)
    schema:import("mason", mason_config)
    schema:set("mason.lsp", {
      description = "",
      type = "array",
    })
  end,
}
