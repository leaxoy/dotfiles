local function resolve_lsp_command(cmds, lang)
  return function()
    vim.ui.select(cmds, {
      prompt = "Execute Commands:",
    }, function(choice)
      if not choice then return end
      vim.api.nvim_out_write("Execute command: " .. choice)
      if vim.bo.filetype == "go" then
        local arg = { URI = vim.uri_from_bufnr(vim.api.nvim_get_current_buf()) }
        vim.lsp.buf.execute_command({ command = choice, arguments = { arg } })
      end
    end)
  end
end

local function resolve_text_document_capabilities(client, buffer)
  local map = function(mode, lhs, rhs, opts)
    if type(mode) == "string" and string.len(mode) > 1 then mode = vim.split(mode, "") end
    opts = vim.tbl_extend("force", { noremap = true, silent = true, buffer = buffer }, opts)
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  local caps = client.server_capabilities

  if caps.declarationProvider then
    map("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration" })
  end
  if caps.definitionProvider then
    map("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
  end
  if caps.typeDefinitionProvider then
    map("n", "gt", vim.lsp.buf.type_definition, { desc = "Type Definition" })
  end
  -- if caps.implementationProvider then
  --   map("n", "gi", vim.lsp.buf.implementation, { desc = "Implementation" })
  -- end
  -- if caps.referencesProvider then
  --   map("n", "gr", vim.lsp.buf.references, { desc = "References" })
  -- end
  if caps.callHierarchyProvider then
    map("n", "ghi", vim.lsp.buf.incoming_calls, { desc = "Incoming Calls" })
    map("n", "gho", vim.lsp.buf.outgoing_calls, { desc = "Outgoing Calls" })
  end
  -- if caps.typeHierarchyProvider then
  local hierarchy = require("hierarchy")
  local result_handler = function(err, result, ctx, config)
    hierarchy.handlers.load_quickfix(err, result, ctx, config)
    require("telescope.builtin").quickfix(require("telescope.themes").get_ivy({}))
  end
  map("n", "ght", function() hierarchy.subtypes(result_handler) end, { desc = "Sub Types" })
  map("n", "ghT", function() hierarchy.supertypes(result_handler) end, { desc = "Super Types" })
  -- end
  if caps.documentHighlightProvider then
    local group = "lsp_document_highlight"
    vim.api.nvim_create_augroup(group, { clear = false })
    vim.api.nvim_clear_autocmds({ buffer = buffer, group = group })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = group,
      buffer = buffer,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = group,
      buffer = buffer,
      callback = vim.lsp.buf.clear_references,
    })
  end
  -- if caps.documentLinkProvider then
  -- end
  if caps.hoverProvider then
    map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
  end
  if caps.codeLensProvider and caps.codeLensProvider.resolveProvider then
    vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged" }, {
      pattern = "*", callback = vim.lsp.codelens.refresh
    })
    map("n", "gad", vim.lsp.codelens.display, { desc = "Display CodeLens" })
    map("n", "gar", vim.lsp.codelens.run, { desc = "Run CodeLens" })
    map("n", "gaf", vim.lsp.codelens.refresh, { desc = "Refresh CodeLens" })
  end
  -- if caps.foldingRangeProvider then
  -- end
  -- if caps.selectionRangeProvider then
  -- end
  if caps.documentSymbolProvider then
    local status, outline = pcall(require, "lspsaga.outline")
    if status then
      map("n", "go", function() outline:render_outline(true) end, { desc = "Document Symbol" })
    else
      map("n", "go", vim.lsp.buf.document_symbol, { desc = "Document Symbol" })
    end
  end
  if caps.semanticTokensProvider then
    if caps.semanticTokensProvider.full and
        client.supports_method("textDocument/semanticTokens/full") then
      local augroup = vim.api.nvim_create_augroup("SemanticTokens", {})
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave", "TextChanged" }, {
        group = augroup,
        buffer = buffer,
        callback = vim.lsp.buf.semantic_tokens_full,
      })
      vim.lsp.buf.semantic_tokens_full()
    end
  end
  -- if caps.inlineValueProvider then
  -- end
  if caps.inlayHintProvider then
    local status, hint = pcall(require, "lsp-inlayhints")
    if status then hint.on_attach(client, buffer, false) end
  end
  -- if caps.monikerProvider then
  -- end
  -- if caps.completionProvider then
  -- end
  -- if caps.diagnosticProvider then
  -- end
  if caps.signatureHelpProvider then
    map("n", "gs", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  end
  if caps.codeActionProvider then
    local code_action = function() vim.lsp.buf.code_action({ apply = true }) end
    map("nv", "<leader>a", code_action, { desc = "Code Action" })
  end
  if caps.colorProvider then
    local document_color_status, document_color = pcall(require, "document-color")
    if document_color_status then document_color.buf_attach(buffer) end
  end
  if caps.documentFormattingProvider then
    local format_group = "document_formatting"
    vim.api.nvim_create_augroup(format_group, { clear = false })
    vim.api.nvim_clear_autocmds({ buffer = buffer, group = format_group })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = format_group, buffer = buffer, command = "lua vim.lsp.buf.format()",
    })
  end
  -- if caps.documentRangeFormattingProvider then
  -- end
  -- if caps.documentOnTypeFormattingProvider then
  -- end
  if caps.renameProvider then
    local status, rn = pcall(require, "lspsaga.rename")
    local rename_fn = function() if status then rn:lsp_rename() else vim.lsp.buf.rename() end end
    map("n", "gr", rename_fn, { desc = "Rename" })
  end
  -- if caps.linkedEditingRangeProvider then
  -- end
end

local function resolve_workspace_capabilities(client, buffer)
  local map = function(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("force", { noremap = true, silent = true, buffer = buffer }, opts)
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  local caps = client.server_capabilities

  --#region workspace start
  if caps.workspaceSymbolProvider then
    map("n", "gO", vim.lsp.buf.workspace_symbol, { desc = "Workspace Symbol" })
  end
  if caps.executeCommandProvider then
    -- local cmds = caps.executeCommandProvider.commands
    -- local langs = client.config.filetypes
    -- map("n", "ge", resolve_lsp_command(cmds, langs), { desc = "Execute Command" })
  end
  if caps.workspace and caps.workspace.workspaceFolders then
    map("n", "gwa", vim.lsp.buf.add_workspace_folder, { desc = "Add Workspace" })
    map("n", "gwr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove Workspace" })
    local print_workspaces = function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end
    map("n", "gwl", print_workspaces, { desc = "List Workspace" })
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf = args.buf

    resolve_text_document_capabilities(client, buf)
    resolve_workspace_capabilities(client, buf)
  end,
  desc = "setup lsp functions"
})
