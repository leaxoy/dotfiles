return {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "double" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "double" }),
  ["window/showMessage"] = function(_, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local lvl = ({ "ERROR", "WARN", "INFO", "DEBUG" })[result.type]
    require("fn").lsp_notify(client.name, result.message, lvl, 3000, function()
      return lvl == "ERROR" or lvl == "WARN"
    end)
  end,
  ["textDocument/publishDiagnostics"] = vim.lsp.diagnostic.on_publish_diagnostics,
  ["typeHierarchy/supertypes"] = function(err, result, ctx)
    print("supertypes not support currently")
  end,
  ["typeHierarchy/subtypes"] = function(err, result)
    print("subtypes not support currently")
  end,
}
