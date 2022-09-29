local lsp_status, lsp = pcall(require, "lspconfig")
if not lsp_status then return end

local mason_status, mason_adapter = pcall(require, "mason-lspconfig")
if not mason_status then return end

-- Add lsp info border
local win_opts = require("lspconfig.ui.windows").default_options
win_opts.border = "double"

mason_adapter.setup_handlers {
  function(server_name)
    local excludes = { "jdtls", "rust_analyzer" }
    if vim.tbl_contains(excludes, server_name) then return end
    lsp[server_name].setup {}
  end,
  clangd = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.offsetEncoding = { "utf-18" }
    lsp["clangd"].setup { capabilities = capabilities }
  end,
  gopls = function()
    lsp["gopls"].setup {
      init_options = { allExperiments = true },
      settings = {
        gopls = {
          -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
          allExperiments = true,
          deepCompletion = true,
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
          matcher = "Fuzzy",
          diagnosticsDelay = "500ms",
          symbolMatcher = "fuzzy",
          gofumpt = true,
        },
      },
    }
  end,
  jsonls = function()
    lsp["jsonls"].setup { settings = { json = { schemas = require("schemastore").json.schemas() } } }
  end,
  rust_analyzer = function()
    require("rust-tools").setup {
      tools = {
        inlay_hints = { auto = false },
      },
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
    lsp["sumneko_lua"].setup(require("lua-dev").setup {
      lspconfig = {
        root_dir = require("lspconfig").util.root_pattern("init.lua", "lua"),
        settings = {
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
            hint = {
              enable = true,
              arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
              await = true,
              paramName = "Disable", -- "All", "Literal", "Disable"
              paramType = false,
              semicolon = "Disable", -- "All", "SameLine", "Disable"
              setType = true,
            },
            runtime = { version = "LuaJIT" },
            workspace = { checkThirdParty = false },
          },
        },
      },
    })
  end,
  tsserver = function()
    lsp["tsserver"].setup {
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
