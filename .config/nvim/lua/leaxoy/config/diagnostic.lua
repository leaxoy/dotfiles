vim.diagnostic.config {
  virtual_text = true,
  signs = false,
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  float = {
    show_header = true,
    focus = false,
    border = "double",
    focusable = false,
    header = "",
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    source = true,
  },
  update_in_insert = false,
  severity_sort = false,
}

local signs = { Error = "", Warn = "", Info = "", Hint = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
