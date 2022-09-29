local status, jdtls = pcall(require, "jdtls")
if not status then return end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

jdtls.start_or_attach {
  cmd = {
    "jdtls",
    "-configuration",
    os.getenv "HOME" .. "/.cache/jdtls/config",
    "-data",
    os.getenv "HOME" .. "/.cache/jdtls/workspace/" .. project_name,
  },
  settings = {
    java = {
      inlayHints = { parameterNames = { enabled = true } },
    },
  },
  init_options = {
    bundles = {},
  },
}

jdtls.setup.add_commands()

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = jdtls.organize_imports,
  desc = "Organize Imports",
})
