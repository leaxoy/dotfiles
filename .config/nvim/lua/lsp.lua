-- -- TODO: hook make opts function after https://github.com/neovim/neovim/pull/20184 merged
-- local origin_make_floating_popup_options = vim.lsp.util.make_floating_popup_options
-- function vim.lsp.util.make_floating_popup_options(width, height, opts)
--   local inner_opts = origin_make_floating_popup_options(width, height, opts)
--   local addon = { title = opts.title, title_pos = opts.title_pos, border = opts.border }
--   return vim.tbl_extend("force", inner_opts, addon)
-- end

local origin_make_client_capabilities = vim.lsp.protocol.make_client_capabilities
function vim.lsp.protocol.make_client_capabilities()
  local capabilities = origin_make_client_capabilities()
  local textDocument = capabilities.textDocument
  local workspace = capabilities.workspace
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
  textDocument.typeHierarchy = { dynamicRegistration = false }
  textDocument.colorProvider = { dynamicRegistration = true }
  workspace.semanticTokens = { refreshSupport = true }
  local status, tokens = pcall(require, "nvim-semantic-tokens")
  if status then capabilities = tokens.extend_capabilities(capabilities) end

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

local provider = vim.lsp.handlers
provider["textDocument/hover"] =
  vim.lsp.with(provider.hover, { border = "rounded", title = "Hover" })
provider["textDocument/signatureHelp"] =
  vim.lsp.with(provider.signature_help, { border = "rounded", title = "SignatureHelp" })
provider["window/showMessage"] = function(_, result, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local lvl = ({ "ERROR", "WARN", "INFO", "DEBUG" })[result.type]
  local filter = function() return vim.tbl_contains({ "ERROR", "WARN" }, lvl) end
  require("fn").lsp_notify(client.name, result.message, lvl, 3000, filter)
end
