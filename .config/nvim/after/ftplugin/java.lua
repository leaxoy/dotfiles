local status, jdtls = pcall(require, "jdtls")
if not status then return end

jdtls.setup_dap { hotcodereplace = "auto" }
jdtls.setup.add_commands()

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = jdtls.organize_imports,
  desc = "Organize Imports",
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.name ~= "jdtls" then return end
    vim.cmd [[JdtRefreshDebugConfigs]]
  end,
})

local project_name = vim.fn.fnamemodify(vim.loop.cwd(), ":p:h:t")

local function split_by_line(str) return vim.split(str, "\n", {}) end

local debug_bundles = split_by_line(
  vim.fn.glob(
    vim.fn.stdpath "data"
      .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
    true
  )
)
local test_bundles = split_by_line(
  vim.fn.glob(vim.fn.stdpath "data" .. "/mason/packages/java-test/extension/server/*.jar", true)
)

jdtls.start_or_attach {
  cmd = {
    "jdtls",
    "-configuration",
    os.getenv "HOME" .. "/.cache/jdtls/config",
    "-data",
    os.getenv "HOME" .. "/.cache/jdtls/workspace/" .. project_name,
  },
  init_options = {
    bundles = vim.list_extend(debug_bundles, test_bundles),
  },
}
