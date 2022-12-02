local lsp_status, lsp = pcall(require, "lspconfig")
if not lsp_status then return end

local mason_status, mason_adapter = pcall(require, "mason-lspconfig")
if not mason_status then return end

-- Add lsp info border
local win_opts = require("lspconfig.ui.windows").default_options
win_opts.border = "double"

mason_adapter.setup {
  automatic_installation = true,
  ensure_installed = vim.g.lsp_servers or {},
}

mason_adapter.setup_handlers {
  function(server_name) lsp[server_name].setup {} end,
  clangd = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.offsetEncoding = { "utf-16" }
    lsp.clangd.setup { capabilities = capabilities }
  end,
  gopls = function()
    lsp.gopls.setup {
      init_options = { allExperiments = true },
      settings = {
        gopls = {
          -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
          allExperiments = true,
          deepCompletion = true,
        },
      },
    }
  end,
  hls = function() end,
  jdtls = function() end,
  jsonls = function()
    lsp.jsonls.setup { settings = { json = { schemas = require("schemastore").json.schemas() } } }
  end,
  omnisharp = function()
    lsp.omnisharp.setup {
      cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/OmniSharp.dll" },
    }
  end,
  rust_analyzer = function()
    require("rust-tools").setup {
      tools = { inlay_hints = { auto = false } },
      server = { standalone = true },
      dap = {
        adapter = {
          type = "executable",
          command = "codelldb",
          name = "codelldb",
        },
      },
    }
  end,
  sumneko_lua = function()
    require("neodev").setup {}
    local root_dir = require("lspconfig").util.root_pattern("init.lua", "lua")
    lsp.sumneko_lua.setup { root_dir = root_dir }
  end,
  tsserver = function()
    lsp.tsserver.setup {
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
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
          },
        },
      },
    }
  end,
}
