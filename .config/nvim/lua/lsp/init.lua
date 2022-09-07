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

local function type_hierarchy(method)
  vim.lsp.buf_request(0, "textDocument/prepareTypeHierarchy", {})
end

local function super_types() type_hierarchy("typeHierarchy/supertypes") end

local function sub_types() type_hierarchy("typeHierarch/subtypes") end

local function resolve_server_capabilities(client, buffer)
  local map = function(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("force", { noremap = true, silent = true, buffer = buffer }, opts)
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  if client.server_capabilities.declarationProvider then
    map("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration" })
  end
  if client.server_capabilities.definitionProvider then
    map("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
  end
  if client.server_capabilities.typeDefinitionProvider then
    map("n", "gt", vim.lsp.buf.type_definition, { desc = "Type Definition" })
  end
  -- if client.server_capabilities.implementationProvider then
  --   m("n", "gi", vim.lsp.buf.implementation, { desc = "Implementation" })
  -- end
  -- if client.server_capabilities.referencesProvider then
  --   m("n", "gr", vim.lsp.buf.references, { desc = "References" })
  -- end
  if client.server_capabilities.callHierarchyProvider then
    map("n", "ghi", vim.lsp.buf.incoming_calls, { desc = "Incoming Calls" })
    map("n", "gho", vim.lsp.buf.outgoing_calls, { desc = "Outgoing Calls" })
  end
  if client.server_capabilities.typeHierarchyProvider then
    map("n", "ght", sub_types, { desc = "Sub Types" })
    map("n", "ghT", super_types, { desc = "Super Types" })
  end
  if client.server_capabilities.documentHighlightProvider then
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
  -- if client.server_capabilities.documentLinkProvider then
  -- end
  if client.server_capabilities.hoverProvider then
    map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
  end
  if client.server_capabilities.codeLensProvider and client.server_capabilities.codeLensProvider.resolveProvider then
    vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged" }, {
      pattern = "*", callback = vim.lsp.codelens.refresh
    })
    map("n", "gad", vim.lsp.codelens.display, { desc = "Display CodeLens" })
    map("n", "gar", vim.lsp.codelens.run, { desc = "Run CodeLens" })
    map("n", "gaf", vim.lsp.codelens.refresh, { desc = "Refresh CodeLens" })
  end
  -- if client.server_capabilities.foldingRangeProvider then
  -- end
  -- if client.server_capabilities.selectionRangeProvider then
  -- end
  if client.server_capabilities.documentSymbolProvider then
    local status, outline = pcall(require, "lspsaga.outline")
    if status then
      map("n", "go", function() outline:render_outline(true) end, { desc = "Document Symbol" })
    else
      map("n", "go", vim.lsp.buf.document_symbol, { desc = "Document Symbol" })
    end
  end
  if client.server_capabilities.semanticTokensProvider then
    -- if client.server_capabilities.semanticTokensProvider.full and
    --     client.supports_method("textDocument/semanticTokens/full") then
    --   vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
    --     pattern = "*",
    --     callback = vim.lsp.buf.semantic_tokens_full,
    --   })
    -- end
  end
  -- if client.server_capabilities.inlineValueProvider then
  -- end
  if client.server_capabilities.inlayHintProvider then
    require("lsp-inlayhints").on_attach(client, buffer, false)
  end
  -- if client.server_capabilities.monikerProvider then
  -- end
  -- if client.server_capabilities.completionProvider then
  -- end
  -- if client.server_capabilities.diagnosticProvider then
  -- end
  if client.server_capabilities.signatureHelpProvider then
    map("n", "gs", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  end
  if client.server_capabilities.codeActionProvider then
    local code_action = function() vim.lsp.buf.code_action({ apply = true }) end
    map({ "n", "v" }, "gaa", code_action, { desc = "Code Action" })
  end
  -- if client.server_capabilities.colorProvider then
  -- end

  if client.server_capabilities.documentFormattingProvider then
    local format_group = "document_formatting"
    vim.api.nvim_create_augroup(format_group, { clear = false })
    vim.api.nvim_clear_autocmds({ buffer = buffer, group = format_group })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = format_group, buffer = buffer, command = "lua vim.lsp.buf.format()",
    })
  end
  -- if client.server_capabilities.documentRangeFormattingProvider then
  -- end
  -- if client.server_capabilities.documentOnTypeFormattingProvider then
  -- end
  if client.server_capabilities.renameProvider then
    map("n", "gr", vim.lsp.buf.rename, { desc = "Rename" })
  end
  -- if client.server_capabilities.linkedEditingRangeProvider then
  -- end

  --#region workspace start
  if client.server_capabilities.workspaceSymbolProvider then
    map("n", "gO", vim.lsp.buf.workspace_symbol, { desc = "Workspace Symbol" })
  end
  if client.server_capabilities.executeCommandProvider then
    local cmds = client.server_capabilities.executeCommandProvider.commands
    local langs = client.config.filetypes
    map("n", "ge", resolve_lsp_command(cmds, langs), { desc = "Execute Command" })
  end
  if client.server_capabilities.workspace and client.server_capabilities.workspace.workspaceFolders then
    map("n", "gwa", vim.lsp.buf.add_workspace_folder, { desc = "Add Workspace" })
    map("n", "gwr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove Workspace" })
    local print_workspaces = function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end
    map("n", "gwl", print_workspaces, { desc = "List Workspace" })
  end
end

local function resolve_client_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
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
  completionItem.resolveSupport = { properties = { "documentation", "detail", "additionalTextEdits" } }
  textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
  textDocument.typeHierarchy = { dynamicRegistration = false, }
  workspace.semanticTokens = { refreshSupport = true }
  capabilities = require("nvim-semantic-tokens").extend_capabilities(capabilities)
  return capabilities
end

local M = {}

M.activate = function(client, bufnr)
  client.offset_encoding = "utf-16"
  resolve_server_capabilities(client, bufnr)
end

M.lsp_capabitities = function()
  return resolve_client_capabilities()
end

M.lsp_settings = {
  gopls = {
    gopls = {
      -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
      allExperiments = true,
      deepCompletion = true,
      linkTarget = "godoc.byted.org/pkg",
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        unusedparams = true,
        unusedwrite = true,
        unusedvariable = true,
        fieldalignment = true,
        nilness = true,
        shadow = true,
        useany = true,
      },
      annotations = { ["nil"] = true, escape = true, inline = true, bounds = true },
      codelenses = {
        enable = true,
        enableByDefault = true,
        generate = true, -- show the `go generate` lens.
        gc_details = true, --  // Show a code lens toggling the display of gc's choices.
        test = true,
        tidy = true,
        upgrade_dependency = true,
      },
      templateExtensions = { ".tmpl", ".html", ".gohtml", ".tmpl.html" },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      semanticTokens = true,
      matcher = "Fuzzy",
      diagnosticsDelay = "500ms",
      experimentalWatchedFileDelay = "100ms",
      symbolMatcher = "fuzzy",
      gofumpt = true,
    },
  },
  jsonls = { json = { schemas = require("schemastore").json.schemas() } },
  rust_analyzer = {
    rust_analyzer = {
      checkOnSave = { command = "clippy" },
      imports = {
        granularity = { group = "module", },
        prefix = "self",
      },
      cargo = {
        buildScripts = { enable = true, },
        allFeatures = true, features = { "all" }
      },
      procMacro = { enable = true },
    },
  },
  sumneko_lua = {
    Lua = {
      format = {
        enable = true,
        -- Put format options here
        -- NOTE: the value should be STRING!!
        -- see: https://github.com/CppCXY/EmmyLuaCodeStyle
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
          quote_style = "double",
        },
      },
      workspace = { checkThirdParty = false, },
    },
  },
  tsserver = {
    tsserver = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        }
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        }
      }
    }
  }
}

M.lsp_init_options = {
  gopls = { usePlaceholders = true },
  jdtls = {
    bundles = {},
    extendedClientCapabilities = {
      progressReportProvider = true,
      classFileContentsSupport = true,
      generateToStringPromptSupport = true,
      hashCodeEqualsPromptSupport = true,
      advancedExtractRefactoringSupport = true,
      advancedOrganizeImportsSupport = true,
      generateConstructorsPromptSupport = true,
      generateDelegateMethodsPromptSupport = true,
      moveRefactoringSupport = true,
      inferSelectionSupport = { "extractMethod", "extractVariable", "extractConstant" },
    },
  },
}

M.setup = function()
  local lsp_center = require("mason-lspconfig")
  lsp_center.setup({ ensure_installed = vim.g.lsp_servers, automatic_installation = true })

  local lspconfig = require("lspconfig")
  for _, server_name in pairs(lsp_center.get_installed_servers()) do
    local opts = {
      capabilities = M.lsp_capabitities(),
      flags = { debounce_text_changes = 150 },
      handlers = require("lsp.handler"),
    }
    opts.settings = vim.tbl_deep_extend(
      "force",
      opts.settings or vim.empty_dict(),
      M.lsp_settings[server_name] or vim.empty_dict()
    )
    opts.commands = vim.tbl_deep_extend(
      "force",
      opts.commands or vim.empty_dict(),
      require("lsp.commands") or vim.empty_dict()
    )
    opts.init_options = vim.tbl_deep_extend(
      "force",
      opts.init_options or vim.empty_dict(),
      M.lsp_init_options[server_name] or vim.empty_dict()
    )
    if server_name == "sumneko_lua" then
      local luadev = require("lua-dev").setup({ lspconfig = opts })
      lspconfig[server_name].setup(luadev)
    elseif server_name == "jdtls" then
      local new_opts = vim.tbl_deep_extend("keep", opts, { use_lombok_agent = true })
      lspconfig[server_name].setup(new_opts)
    else
      lspconfig[server_name].setup(opts)
    end
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local buf = args.buf
      M.activate(client, buf)
    end,
    desc = "setup lsp functions"
  })
end

return M
