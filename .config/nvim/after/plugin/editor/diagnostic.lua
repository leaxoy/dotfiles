vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  float = { show_header = true, focus = false, border = "double" },
  update_in_insert = true,
  severity_sort = false,
}

-- local signs = { Error = "", Warn = "", Hint = "", Info = "" }
local signs = { Error = "", Warn = "", Info = "", Hint = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
