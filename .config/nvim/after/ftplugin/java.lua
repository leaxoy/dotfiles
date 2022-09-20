require("jdtls").start_or_attach {
  cmd = {
    "jdtls",
    "-configuration", os.getenv "HOME" .. "/.cache/jdtls/config",
    "-data", os.getenv "HOME" .. "/.cache/jdlts/workspace"
  },
  settings = {
    java = {
      inlayHints = { parameterNames = { enabled = true } },
    }
  },
  init_options = {
    bundles = {}
  },
}
