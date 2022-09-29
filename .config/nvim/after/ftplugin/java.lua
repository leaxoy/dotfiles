local cwd = vim.fn.getcwd()

require("jdtls").start_or_attach {
  cmd = {
    "jdtls",
    "-configuration",
    os.getenv "HOME" .. "/.cache/jdtls/config",
    "-data",
    os.getenv "HOME" .. "/.cache/jdtls/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
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
