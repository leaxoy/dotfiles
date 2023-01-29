local origin_make_client_capabilities = vim.lsp.protocol.make_client_capabilities
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.protocol.make_client_capabilities()
  local capabilities = origin_make_client_capabilities()
  local textDocument = capabilities.textDocument
  local completionItem = capabilities.textDocument.completion.completionItem

  completionItem.snippetSupport = true
  completionItem.preselectSupport = true
  completionItem.insertReplaceSupport = true
  completionItem.labelDetailsSupport = true
  completionItem.deprecatedSupport = true
  completionItem.commitCharactersSupport = true
  completionItem.tagSupport = { valueSet = { 1 } }
  completionItem.resolveSupport =
    { properties = { "documentation", "detail", "additionalTextEdits" } }
  textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
  textDocument.colorProvider = { dynamicRegistration = true }

  return capabilities
end

vim.lsp.protocol.CompletionItemKind = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", title = { { "Hover", "Boolean" } } })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = "rounded", title = { { "SignatureHelp", "Boolean" } } }
)
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.handlers["window/showMessage"] = function(_, result, _, _)
  local level = result.type == vim.lsp.protocol.MessageType.Log and "info" or "warn"
  vim.notify(result.message, level, { title = "[LSP]" })
  return result
end
