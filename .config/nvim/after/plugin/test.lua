local status, neotest = pcall(require, "neotest")

if not status then return end

neotest.setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      args = { "--log-level", "DEBUG" },
      runner = "pytest",
    }),
    require("neotest-go"),
    require("neotest-rust"),
    require("neotest-vim-test")({ ignore_file_types = { "python", "go", "rust" } }),
  },
  icons = { running = "ﭦ" },
  summary = {
    mappings = { jumpto = "<CR>", expand = "<TAB>" }
  },
})
