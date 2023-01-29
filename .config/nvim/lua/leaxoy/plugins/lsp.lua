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
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    ---@type LazyKeys[]
    keys = {
      { "gf", "<CMD>Lspsaga lsp_finder<CR>", desc = "[LSP] Finder" },
      { "gp", "<CMD>Lspsaga peek_definition<CR>", desc = "[LSP] Peek Definition" },
    },
    cmd = "Lspsaga",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    config = function()
      local function icon_kind()
        return require("catppuccin.groups.integrations.lsp_saga").custom_kind()
      end
      require("lspsaga").setup {
        ui = {
          border = "rounded",
          preview = " ",
          expand = " ",
          collapse = " ",
          code_action = " ",
          diagnostic = " ",
          incoming = " ",
          outgoing = " ",
          kind = icon_kind(),
        },
        diagnostic = {},
        symbol_in_winbar = {
          enable = true,
          in_custom = false,
          show_file = true,
          separator = "  ",
          respect_root = true,
        },
        code_action = {
          num_shortcut = true,
          keys = { quit = "q", exec = "<CR>" },
        },
        lightbulb = {
          enable = false,
          enable_in_insert = false,
          cache_code_action = true,
          sign = false,
          sign_priority = 40,
          virtual_text = true,
          update_time = 100,
        },
        preview = { lines_above = 0, lines_below = 20 },
        scroll_preview = { scroll_down = "<C-d>", scroll_up = "<C-u>" },
        outline = { auto_enter = false, keys = { jump = "<CR>" } },
        callhierarchy = { show_detail = true, keys = { jump = "<CR>" } },
        request_timeout = 5000,
        finder = {
          open = { "o", "<CR>" },
          quit = { "q", "<Esc>" },
          vsplit = "v",
          split = "s",
        },
        definition = { quit = "q" },
        rename = { quit = "<Esc>" },
      }
      map_local { "[x", "<CMD>Lspsaga diagnostic_jump_prev<CR>", desc = "Previous Diagnostic" }
      map_local { "]x", "<CMD>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" }
      map_local { "<leader>xc", "<CMD>Lspsaga show_cursor_diagnostics<CR>", desc = "Cursor" }
      map_local { "<leader>xx", "<CMD>Lspsaga show_line_diagnostics<CR>", desc = "Line" }
      map_local { "<leader>xb", "<CMD>Lspsaga show_buf_diagnostics<CR>", desc = "Buffer" }

      -- update color highlight
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          require("lspsaga").config =
            vim.tbl_extend("force", require("lspsaga").config, { ui = { kind = icon_kind() } })
          require("lspsaga.highlight").init_highlight()
          require("lspsaga.lspkind").init_kind_hl()
        end,
      })
    end,
  },
  {
    "dnlhc/glance.nvim",
    cmd = "Glance",
    config = function()
      local glance = require "glance"
      glance.setup {
        border = { enable = true, top_char = "─", bottom_char = "─" },
        folds = { folded = true, fold_open = "▾", fold_closed = "▸" },
        list = { position = "right", width = 0.3 },
        theme = { enable = true, mode = "auto" },
        mappings = {
          list = {
            q = glance.actions.close,
            v = glance.actions.jump_vsplit,
            s = glance.actions.jump_split,
            t = glance.actions.jump_tab,
            ["<Esc>"] = glance.actions.close,
            ["<Tab>"] = glance.actions.enter_win "preview",
            ["<CR>"] = glance.actions.jump,
          },
          preview = {
            q = glance.actions.close,
            ["<Esc>"] = glance.actions.close,
            ["<Tab>"] = glance.actions.enter_win "list",
          },
        },
        winbar = { enable = false },
        hooks = {
          ---@param results table
          ---@param open fun(table)
          ---@param jump fun(any)
          ---@param method string
          ---@diagnostic disable-next-line: unused-local
          before_open = function(results, open, jump, method)
            if #results == 1 then
              jump(results[1]) -- argument is optional
            else
              open(results) -- argument is optional
            end
          end,
        },
      }
    end,
  },
}
