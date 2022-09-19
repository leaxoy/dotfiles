local lsp_status, lsp = pcall(require, "lspconfig")
if not lsp_status then return end

local mason_status, mason_adapter = pcall(require, "mason-lspconfig")
if not mason_status then return end

-- TODO: hook make opts function before https://github.com/neovim/neovim/pull/20184 merged
local origin_make_floating_popup_options = vim.lsp.util.make_floating_popup_options
function vim.lsp.util.make_floating_popup_options(width, height, opts)
  local inner_opts = origin_make_floating_popup_options(width, height, opts)
  return vim.tbl_extend("force", inner_opts, { title = opts.title, title_pos = opts.title_pos })
end

-- Add lsp info border
local win_opts = require("lspconfig.ui.windows").default_options
win_opts.border = "double"

local base_opts = {
  capabilities = (function()
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
    textDocument.typeHierarchy = { dynamicRegistration = false }
    textDocument.colorProvider = { dynamicRegistration = true }
    workspace.semanticTokens = { refreshSupport = true }
    capabilities = require("nvim-semantic-tokens").extend_capabilities(capabilities)
    return capabilities
  end)(),
  flags = { debounce_text_changes = 150 },
  handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "double", title = "Hover" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
      { border = "double", title = "Signature" }),
    ["window/showMessage"] = function(_, result, ctx)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      local lvl = ({ "ERROR", "WARN", "INFO", "DEBUG" })[result.type]
      require("fn").lsp_notify(client.name, result.message, lvl, 3000, function()
        return lvl == "ERROR" or lvl == "WARN"
      end)
    end,
    ["textDocument/publishDiagnostics"] = vim.lsp.diagnostic.on_publish_diagnostics,
  }
}

local function extend_opts(extra_opts) return vim.tbl_deep_extend("force", base_opts, extra_opts) end

mason_adapter.setup_handlers {
  function(server_name)
    lsp[server_name].setup(base_opts)
  end,
  gopls = function()
    local local_opts = extend_opts {
      init_options = { usePlaceholders = true },
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
          semanticTokens = true,
          matcher = "Fuzzy",
          diagnosticsDelay = "500ms",
          experimentalWatchedFileDelay = "100ms",
          symbolMatcher = "fuzzy",
          gofumpt = true,

        }
      }
    }
    lsp["gopls"].setup(local_opts)
  end,
  jdtls = function()
    local local_opts = extend_opts {
      init_options = {
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
          }
        }
      },
      use_lombok_agent = true,
      settings = {
        java = {
          inlayHints = { parameterNames = { enabled = "all" } },
          typeHierarchy = { lazyLoad = true },
        }
      },
    }
    lsp["jdtls"].setup(local_opts)
  end,
  jsonls = function()
    local local_opts = extend_opts {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas()
        }
      }
    }
    lsp["jsonls"].setup(local_opts)
  end,
  rust_analyzer = function()
    local local_opts = extend_opts {
      settings = {
        ["rust-analyzer"] = {
          -- checkOnSave = { command = "clippy" },
          imports = {
            granularity = { group = "module", },
            prefix = "self",
          },
          cargo = {
            buildScripts = { enable = true, },
            allFeatures = true,
            features = { "all" },
            autoReload = true,
          },
          procMacro = { enable = true },
        },
      }
    }
    lsp["rust_analyzer"].setup(local_opts)
  end,
  sumneko_lua = function()
    local local_opts = extend_opts {
      root_dir = require "lspconfig".util.root_pattern("init.lua", "lua"),
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
          workspace = { checkThirdParty = false, },
        }
      }
    }
    lsp["sumneko_lua"].setup(require("lua-dev").setup { lspconfig = local_opts })
  end,
  tsserver = function()
    local local_opts = extend_opts {
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
    lsp["tsserver"].setup(local_opts)
  end,
}
