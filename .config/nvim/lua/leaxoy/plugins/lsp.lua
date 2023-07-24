--#region Lsp Client Configuration
---@param client lsp.Client
---@param buffer integer
local function resolve_text_document_capabilities(client, buffer)
  --#region HACK
  --hack ruff_lsp
  if client.name == "ruff_lsp" then client.server_capabilities.hoverProvider = nil end
  --#endregion

  ---@param keys LazyKeys
  local function map(keys) map_local(keys, buffer) end

  local caps = client.server_capabilities
  assert(caps)
  local has_lspsaga = vim.fn.exists ":Lspsaga" > 0

  if caps.declarationProvider then
    map { "gD", vim.lsp.buf.declaration, desc = "[LSP] Declaration" }
  end
  if caps.definitionProvider then
    map { "gd", vim.lsp.buf.definition, desc = "[LSP] Definition" }
  end
  if caps.typeDefinitionProvider then
    map { "gt", vim.lsp.buf.type_definition, desc = "[LSP] Type Definition" }
  end
  if caps.implementationProvider then
    map { "gi", vim.lsp.buf.implementation, desc = "[LSP] Implementation" }
  end
  if caps.referencesProvider then
    map { "gr", vim.lsp.buf.references, desc = "[LSP] References" }
  end
  if caps.inlayHintProvider then vim.lsp.inlay_hint(buffer, true) end
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
    local function format() vim.lsp.buf.format { timeout_ms = 3000 } end
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("document_formatting", {}),
      buffer = buffer,
      callback = format,
    })
    map { "<leader>cf", format, desc = "Format", mode = { "n", "v" } }
  end
  if caps.renameProvider then
    local rn = has_lspsaga and [[<CMD>Lspsaga rename<CR>]] or vim.lsp.buf.rename
    map { "<leader>cr", rn, desc = "Rename", mode = { "n", "v" } }
  end
end

local function resolve_workspace_capabilities(client, buffer)
  ---@param keys LazyKeys
  local function map(keys) map_local(keys, buffer) end

  local caps = client.server_capabilities

  --#region workspace start
  if caps.workspaceSymbolProvider then
    local sym = vim.fn.exists ":FzfLua" > 0 and [[<CMD>FzfLua lsp_live_workspace_symbols<CR>]]
      or vim.lsp.buf.workspace_symbol
    map { "<leader>cO", sym, desc = "Workspace Symbol" }
  end
  if caps.workspace and caps.workspace.workspaceFolders then
    map { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "Add Workspace" }
    map { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove Workspace" }
    local print_workspaces = function() vim.print(vim.lsp.buf.list_workspace_folders()) end
    map { "<leader>wl", print_workspaces, desc = "List Workspace" }
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf = args.buf
    assert(client)

    resolve_text_document_capabilities(client, buf)
    resolve_workspace_capabilities(client, buf)
  end,
  desc = "setup lsp functions",
})
--#endregion

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
      "folke/neoconf.nvim",
    },
    event = "BufReadPre",
    priority = 1000,
    init = function()
      map { "<leader>lr", "<CMD>LspRestart<CR>", desc = "Restart LSP Server" }
      map { "<leader>li", "<CMD>LspInfo<CR>", desc = "Show LSPServer Info" }
    end,
    ---@class LspServerConfig
    ---@field init_options table
    ---@field settings table
    ---@field on_new_config fun(opts: LspServerConfig)
    ---@class LazyLspConfig
    ---@field servers table<string, LspServerConfig>
    ---@field setups table<string, fun(opts: LspServerConfig)>
    opts = { servers = {}, setups = {} },
    ---@param _ LazyPlugin
    ---@param opts LazyLspConfig
    config = function(_, opts)
      require("lspconfig.ui.windows").default_options.border = "double"

      local lsp = require "lspconfig"
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
            or function(param) lsp[server_name].setup(param) end
          setup(server_opts)
        end,
        jdtls = function() end, -- NOTE: must setup in ftplugin
      }
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    ---@type LazyKeys[]
    keys = {
      { "gf", "<CMD>Lspsaga finder def+ref+imp<CR>", desc = "[LSP] Finder" },
      { "gp", "<CMD>Lspsaga peek_definition<CR>", desc = "[LSP] Peek Definition" },
      { "[x", "<CMD>Lspsaga diagnostic_jump_prev<CR>", desc = "Previous Diagnostic" },
      { "]x", "<CMD>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" },
      { "<leader>xc", "<CMD>Lspsaga show_cursor_diagnostics<CR>", desc = "Cursor" },
      { "<leader>xx", "<CMD>Lspsaga show_line_diagnostics<CR>", desc = "Line" },
    },
    cmd = "Lspsaga",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    config = function()
      require("lspsaga").setup {
        ui = { code_action = " ", actionfix = " ", imp_sign = " " },
        finder = { silent = true, default = "def+imp+ref", keys = { quit = { "q", "<Esc>" } } },
        callhierarchy = { keys = { toggle_or_req = "o" } },
        implement = { enable = true },
        lightbulb = { sign = false },
        outline = { auto_enter = false, auto_resize = true },
        request_timeout = 5000,
        rename = { in_select = false, keys = { quit = "<Esc>" } },
        scroll_preview = { scroll_down = "<C-d>", scroll_up = "<C-u>" },
      }
    end,
  },
}
