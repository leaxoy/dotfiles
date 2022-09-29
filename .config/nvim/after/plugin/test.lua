local status, neotest = pcall(require, "neotest")
if not status then return end

neotest.setup {
  adapters = {
    require "neotest-python" {
      dap = { justMyCode = false },
      args = { "--log-level", "DEBUG" },
      runner = "pytest",
    },
    require "neotest-go",
    require "neotest-rust",
    require "neotest-vim-test" { ignore_file_types = { "python", "go", "rust" } },
  },
  icons = { running = "ﭦ" },
  summary = {
    mappings = { jumpto = "<CR>", expand = "<TAB>" },
  },
}

local fn = require "fn"
local map, popup = fn.map_fn, fn.popup_fn
map("n", "t", popup "t", { desc = "+Test" })
map("n", "tf", function() neotest.run.run() end, { desc = "Test Current Function" })
map("n", "tr", function() neotest.run.run(vim.fn.expand "%") end, { desc = "Test Current File" })
map("n", "tt", function() neotest.run.run(vim.fn.getcwd()) end, { desc = "Test Project" })
map("n", "td", function() neotest.run.run { strategy = "dap" } end, { desc = "Debug Test" })
map("n", "ts", neotest.summary.toggle, { desc = "Toggle Test Summary Panel" })
map(
  "n",
  "to",
  function() neotest.output.open { enter = true } end,
  { desc = "Open Test Output Panel" }
)
map(
  "n",
  "tj",
  function() neotest.jump.next { status = "failed" } end,
  { desc = "Next Failed Test" }
)
map(
  "n",
  "tk",
  function() neotest.jump.prev { status = "failed" } end,
  { desc = "Prev Failed Test" }
)
