local function resolve_text_document_capabilities(client, buffer)
  local function map(mode, lhs, rhs, opts) buffer_keymap(mode, lhs, rhs, buffer, opts) end
  map("n", "<leader>c", partial(show_keymap, "<leader>c"), { desc = "+Code" })

  local caps = client.server_capabilities
  local has_glance = is_plugin_installed "glance.nvim"
  local has_lspsaga = is_plugin_installed "lspsaga.nvim"

  if caps.declarationProvider then
    map("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration" })
  end
  if caps.definitionProvider then
    if has_lspsaga then
      map("n", "gf", [[<CMD>Lspsaga lsp_finder<CR>]], { desc = "Lsp Finder" })
      map("n", "gp", [[<CMD>Lspsaga peek_definition<CR>]], { desc = "Peek Definition" })
    end
    local def = has_glance and [[<CMD>Glance definitions<CR>]] or vim.lsp.buf.definition
    map("n", "gd", def, { desc = "Definition" })
  end
  if caps.typeDefinitionProvider then
    local type_def = has_glance and [[<CMD>Glance type_definitions<CR>]]
      or vim.lsp.buf.type_definition
    map("n", "gt", type_def, { desc = "Type Definition" })
  end
  if caps.implementationProvider then
    local impl = has_glance and [[<CMD>Glance implementations<CR>]] or vim.lsp.buf.implementation
    map("n", "gi", impl, { desc = "Implementation" })
  end
  if caps.referencesProvider then
    local ref = has_glance and [[<CMD>Glance references<CR>]] or vim.lsp.buf.references
    map("n", "gr", ref, { desc = "References" })
  end
  if caps.callHierarchyProvider then
    local ch_status, ch = pcall(require, "lspsaga.callhierarchy")
    if ch_status then
      map("n", "ghi", function() ch:incoming_calls() end, { desc = "Incoming Calls" })
      map("n", "gho", function() ch:outgoing_calls() end, { desc = "Incoming Calls" })
    else
      map("n", "ghi", vim.lsp.buf.incoming_calls, { desc = "Incoming Calls" })
      map("n", "gho", vim.lsp.buf.outgoing_calls, { desc = "Outgoing Calls" })
    end
  end
  if caps.documentHighlightProvider then
    local group = "lsp_document_highlight"
    vim.api.nvim_create_augroup(group, { clear = false })
    vim.api.nvim_clear_autocmds { buffer = buffer, group = group }
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
    local function hover()
      if vim.tbl_contains({}, vim.bo.filetype) then
        vim.cmd.help { args = { vim.fn.expand "<cword>" } }
      elseif vim.bo.filetype == "man" then
        vim.cmd.Man { args = { vim.fn.expand "<cword>" } }
      elseif vim.fn.expand "%:t" == "Cargo.toml" then
        require("crates").show_popup()
      elseif vim.fn.expand "%:t" == "package.json" then
        require("package-info").show { force = true }
      else
        vim.lsp.buf.hover()
      end
    end
    map("n", "K", hover, { desc = "Hover" })
  end
  if caps.codeLensProvider then
    vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged" }, {
      buffer = buffer,
      callback = function() vim.lsp.codelens.refresh() end,
    })
    map("n", "<leader>cl", vim.lsp.codelens.run, { desc = "Run CodeLens" })
  end
  if caps.documentSymbolProvider then
    local symbol = has_lspsaga and [[<CMD>Lspsaga outline<CR>]] or vim.lsp.buf.document_symbol
    map("n", "<leader>co", symbol, { desc = "Document Symbol" })
  end
  if caps.inlayHintProvider then
    local status, hint = pcall(require, "lsp-inlayhints")
    if status then hint.on_attach(client, buffer, false) end
  end
  if caps.signatureHelpProvider then
    map("n", "<leader>cs", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  end
  if caps.codeActionProvider then
    local code_action = function() vim.lsp.buf.code_action { apply = true } end
    map("nv", "<leader>ca", code_action, { desc = "Run Code Action" })
  end
  if caps.colorProvider then
    local document_color_status, document_color = pcall(require, "document-color")
    if document_color_status then document_color.buf_attach(buffer) end
  end
  if caps.documentFormattingProvider then
    local format_group = "document_formatting"
    vim.api.nvim_create_augroup(format_group, { clear = false })
    vim.api.nvim_clear_autocmds { buffer = buffer, group = format_group }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = format_group,
      buffer = buffer,
      callback = function() vim.lsp.buf.format() end,
    })
  end
  if caps.renameProvider then map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" }) end
end

local function resolve_workspace_capabilities(client, buffer)
  local function map(mode, lhs, rhs, opts) buffer_keymap(mode, lhs, rhs, buffer, opts) end

  local caps = client.server_capabilities

  --#region workspace start
  if caps.workspaceSymbolProvider then
    map("n", "<leader>cO", vim.lsp.buf.workspace_symbol, { desc = "Workspace Symbol" })
  end
  if caps.workspace and caps.workspace.workspaceFolders then
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add Workspace" })
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove Workspace" })
    local print_workspaces = function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end
    map("n", "<leader>wl", print_workspaces, { desc = "List Workspace" })
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf = args.buf

    resolve_text_document_capabilities(client, buf)
    resolve_workspace_capabilities(client, buf)
  end,
  desc = "setup lsp functions",
})
