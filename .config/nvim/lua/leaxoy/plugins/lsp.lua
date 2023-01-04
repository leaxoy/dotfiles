--#region Lsp Client Configuration
local function resolve_text_document_capabilities(client, buffer)
  local function map(mode, lhs, rhs, opts) buffer_keymap(mode, lhs, rhs, buffer, opts) end

  local caps = client.server_capabilities
  local has_glance = is_plugin_installed "glance"
  local has_lspsaga = is_plugin_installed "lspsaga"

  if caps.declarationProvider then
    map("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration" })
  end
  if caps.definitionProvider then
    if has_lspsaga then
      map("n", "gf", [[<CMD>Lspsaga lsp_finder<CR>]], { desc = "[LSP] Finder" })
    end
    local def = has_glance and [[<CMD>Glance definitions<CR>]] or vim.lsp.buf.definition
    map("n", "gd", def, { desc = "[LSP] Definition" })
  end
  if caps.typeDefinitionProvider then
    local type_def = has_glance and [[<CMD>Glance type_definitions<CR>]]
      or vim.lsp.buf.type_definition
    map("n", "gt", type_def, { desc = "[LSP] Type Definition" })
  end
  if caps.implementationProvider then
    local impl = has_glance and [[<CMD>Glance implementations<CR>]] or vim.lsp.buf.implementation
    map("n", "gi", impl, { desc = "[LSP] Implementation" })
  end
  if caps.referencesProvider then
    local ref = has_glance and [[<CMD>Glance references<CR>]] or vim.lsp.buf.references
    map("n", "gr", ref, { desc = "[LSP] References" })
  end
  if caps.callHierarchyProvider then
    local ch_status, ch = pcall(require, "lspsaga.callhierarchy")
    if ch_status then
      map("n", "ghi", function() ch:incoming_calls() end, { desc = "[LSP] Incoming Calls" })
      map("n", "gho", function() ch:outgoing_calls() end, { desc = "[LSP] Incoming Calls" })
    else
      map("n", "ghi", vim.lsp.buf.incoming_calls, { desc = "[LSP] Incoming Calls" })
      map("n", "gho", vim.lsp.buf.outgoing_calls, { desc = "[LSP] Outgoing Calls" })
    end
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
      elseif vim.fn.expand "%:t" == "Cargo.toml" and is_plugin_installed "crates.nvim" then
        require("crates").show_popup()
      else
        vim.lsp.buf.hover()
      end
    end
    map("n", "K", hover, { desc = "Hover" })
  end
  if caps.codeLensProvider then
    vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged" }, {
      group = vim.api.nvim_create_augroup("codelens", {}),
      buffer = buffer,
      callback = function() vim.lsp.codelens.refresh() end,
    })
    map("n", "<leader>cl", vim.lsp.codelens.run, { desc = "Run CodeLens" })
  end
  if caps.documentSymbolProvider then
    local symbol = has_lspsaga and [[<CMD>Lspsaga outline<CR>]] or vim.lsp.buf.document_symbol
    map("n", "<leader>co", symbol, { desc = "Document Symbol" })
  end
  if caps.signatureHelpProvider then
    map("n", "<leader>cs", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  end
  if caps.codeActionProvider then
    local code_action = function() vim.lsp.buf.code_action { apply = true } end
    map("nv", "<leader>ca", code_action, { desc = "Run Code Action" })
  end
  if caps.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("document_formatting", {}),
      buffer = buffer,
      callback = function() vim.lsp.buf.format() end,
    })
    map("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format" })
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
--#endregion

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "folke/neoconf.nvim",
    "folke/neodev.nvim",
    "simrat39/rust-tools.nvim",
    "b0o/SchemaStore.nvim",
  },
  config = function()
    require("neoconf").setup {}
    local lsp = require "lspconfig"
    require("lspconfig.ui.windows").default_options.border = "double"

    local mason_adapter = require "mason-lspconfig"
    mason_adapter.setup {
      automatic_installation = true,
      ensure_installed = {
        "gopls", -- go
        "jdtls", -- java
        "jsonls", -- json
        "pyright", -- python
        "ruff_lsp", -- python
        "rust_analyzer", -- rust
        "sumneko_lua", -- lua
        "taplo", -- toml
      },
    }

    mason_adapter.setup_handlers {
      function(server_name) lsp[server_name].setup {} end,
      clangd = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.offsetEncoding = {
          "utf-16",
        }
        lsp.clangd.setup { capabilities = capabilities }
      end,
      jdtls = function() end,
      jsonls = function()
        lsp.jsonls.setup {
          settings = { json = { schemas = require("schemastore").json.schemas() } },
        }
      end,
      omnisharp = function()
        lsp.omnisharp.setup {
          cmd = {
            "dotnet",
            vim.fn.stdpath "data" .. "/mason/packages/omnisharp/OmniSharp.dll",
          },
        }
      end,
      rust_analyzer = function()
        require("rust-tools").setup {
          tools = { inlay_hints = { auto = false } },
          server = { standalone = true },
          dap = {
            adapter = { type = "executable", command = "codelldb", name = "codelldb" },
          },
        }
      end,
      sumneko_lua = function()
        require("neodev").setup {}
        local root_dir = lsp.util.root_pattern("init.lua", "lua")
        lsp.sumneko_lua.setup { root_dir = root_dir }
      end,
    }
  end,
}
