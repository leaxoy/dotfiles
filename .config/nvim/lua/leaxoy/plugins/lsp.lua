--#region Lsp Client Configuration
local function resolve_text_document_capabilities(client, buffer)
  --#region HACK
  --hack ruff_lsp
  if client.name == "ruff_lsp" then client.server_capabilities.hoverProvider = nil end
  --#endregion

  ---@param keys LazyKeys
  local function map(keys) map_local(keys, buffer) end

  local caps = client.server_capabilities
  local has_glance = vim.fn.exists ":Glance"
  local has_lspsaga = vim.fn.exists ":Lspsaga"

  if caps.declarationProvider then
    map { "gD", vim.lsp.buf.declaration, desc = "[LSP] Declaration" }
  end
  if caps.definitionProvider then
    local def
    if has_glance then
      def = [[<CMD>Glance definitions<CR>]]
    elseif has_lspsaga then
      def = [[<CMD>Lspsaga goto_definition<CR>]]
    else
      def = vim.lsp.buf.definition
    end
    map { "gd", def, desc = "[LSP] Definition" }
  end
  if caps.typeDefinitionProvider then
    local type_def = has_glance and [[<CMD>Glance type_definitions<CR>]]
      or vim.lsp.buf.type_definition
    map { "gt", type_def, desc = "[LSP] Type Definition" }
  end
  if caps.implementationProvider then
    local impl = has_glance and [[<CMD>Glance implementations<CR>]] or vim.lsp.buf.implementation
    map { "gi", impl, desc = "[LSP] Implementation" }
  end
  if caps.referencesProvider then
    local ref = has_glance and [[<CMD>Glance references<CR>]] or vim.lsp.buf.references
    map { "gr", ref, desc = "[LSP] References" }
  end
  if caps.callHierarchyProvider then
    local incoming = has_lspsaga and "<CMD>Lspsaga incoming_calls<CR>" or vim.lsp.buf.incoming_calls
    local outgoing = has_lspsaga and "<CMD>Lspsaga outgoing_calls<CR>" or vim.lsp.buf.outgoing_calls
    map { "ghi", incoming, desc = "[LSP] Incoming Calls" }
    map { "gho", outgoing, desc = "[LSP] Outgoing Calls" }
  end
  if caps.documentHighlightProvider then
    local au = vim.api.nvim_create_augroup("document_highlight", {})
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = au,
      buffer = buffer,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = au,
      buffer = buffer,
      callback = vim.lsp.buf.clear_references,
    })
  end
  if caps.hoverProvider then
    local function hover()
      if vim.tbl_contains({}, vim.bo.filetype) then
        vim.cmd.help { args = { vim.fn.expand "<cword>" } }
      elseif vim.bo.filetype == "man" then
        vim.cmd.Man { args = { vim.fn.expand "<cword>" } }
      elseif
        vim.fn.expand "%:t" == "Cargo.toml"
        and is_plugin_installed "crates"
        and require("crates").popup_available()
      then
        require("crates").show_popup()
      else
        vim.lsp.buf.hover()
      end
    end
    map { "K", hover, desc = "Hover" }
  end
  if caps.codeLensProvider then
    vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged" }, {
      group = vim.api.nvim_create_augroup("codelens", {}),
      buffer = buffer,
      callback = function() vim.lsp.codelens.refresh() end,
    })
    vim.lsp.codelens.refresh() -- NOTE: call it because autocmd will take effect on next event fired.
    map { "<leader>cl", vim.lsp.codelens.run, desc = "Run CodeLens" }
  end
  if caps.documentSymbolProvider then
    local symbol = has_lspsaga and [[<CMD>Lspsaga outline<CR>]] or vim.lsp.buf.document_symbol
    map { "<leader>co", symbol, desc = "Document Symbol" }
  end
  if caps.signatureHelpProvider then
    map { "<leader>cs", vim.lsp.buf.signature_help, desc = "Signature Help" }
  end
  if caps.codeActionProvider then
    local code_action = has_lspsaga and [[<CMD>Lspsaga code_action<CR>]]
      or function() vim.lsp.buf.code_action { apply = true } end
    map { "<leader>ca", code_action, desc = "Run Code Action", mode = { "n", "v" } }
  end
  if caps.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("document_formatting", {}),
      buffer = buffer,
      callback = function() vim.lsp.buf.format() end,
    })
    map { "<leader>cf", vim.lsp.buf.format, desc = "Format" }
  end
  if caps.renameProvider then
    local r = has_lspsaga and [[<CMD>Lspsaga rename<CR>]] or vim.lsp.buf.rename
    map { "<leader>cr", r, desc = "Rename" }
  end
end

local function resolve_workspace_capabilities(client, buffer)
  ---@param keys LazyKeys
  local function map(keys) map_local(keys, buffer) end

  local caps = client.server_capabilities

  --#region workspace start
  if caps.workspaceSymbolProvider then
    map { "<leader>cO", vim.lsp.buf.workspace_symbol, desc = "Workspace Symbol" }
  end
  if caps.workspace and caps.workspace.workspaceFolders then
    map { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "Add Workspace" }
    map { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove Workspace" }
    local print_workspaces = function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end
    map { "<leader>wl", print_workspaces, desc = "List Workspace" }
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf = args.buf
    -- client.offset_encoding = "utf-8"

    resolve_text_document_capabilities(client, buf)
    resolve_workspace_capabilities(client, buf)
  end,
  desc = "setup lsp functions",
})
--#endregion

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    "folke/neoconf.nvim",
  },
  event = "BufReadPost",
  priority = 1000,
  init = function()
    map { "<leader>lr", "<CMD>LspRestart<CR>", desc = "Restart LSP Server" }
    map { "<leader>li", "<CMD>LspInfo<CR>", desc = "Show LSPServer Info" }
  end,
  ---@class LspServerConfig
  ---@field init_options table
  ---@field settings table
  ---@field on_new_config fun(LspServerConfig)
  ---@class LazyLspConfig
  ---@field servers table<string, LspServerConfig>
  ---@field setups table<string, fun(LspServerConfig)>
  opts = { servers = {}, setups = {} },
  ---@param _ LazyPlugin
  ---@param opts LazyLspConfig
  config = function(_, opts)
    require("lspconfig.ui.windows").default_options.border = "double"

    local mason_adapter = require "mason-lspconfig"
    local ensure_installed = {}
    for _, name in pairs(vim.tbl_keys(opts.servers)) do
      ensure_installed[name] = true
    end
    for _, name in pairs(vim.tbl_keys(opts.setups)) do
      ensure_installed[name] = true
    end
    mason_adapter.setup {
      automatic_installation = true,
      ensure_installed = vim.tbl_keys(ensure_installed),
    }
    mason_adapter.setup_handlers {
      function(server_name)
        local server_opts = opts.servers[server_name] or {}
        local setup = opts.setups[server_name]
          or function(param) require("lspconfig")[server_name].setup(param) end
        setup(server_opts)
      end,
      jdtls = function() end, -- NOTE: must setup in ftplugin
    }
  end,
}
