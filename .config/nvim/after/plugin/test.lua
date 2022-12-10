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
  summary = { mappings = { jumpto = "<CR>", expand = "<TAB>" } },
}

keymap("n", "t", partial(show_keymap, "t"), { desc = "+Test" })
keymap("n", "tf", function() neotest.run.run() end, { desc = "Test Current Function" })
keymap("n", "tr", function() neotest.run.run(vim.fn.expand "%") end, { desc = "Test Current File" })
keymap("n", "tt", function() neotest.run.run(vim.fn.getcwd()) end, { desc = "Test Project" })
keymap("n", "td", function() neotest.run.run { strategy = "dap" } end, { desc = "Debug Test" })
keymap("n", "ts", neotest.summary.toggle, { desc = "Toggle Test Summary Panel" })
local function neotest_output() neotest.output.open { enter = true } end
keymap("n", "to", neotest_output, { desc = "Open Test Output Panel" })
local function neotest_next_failed() neotest.jump.next { status = "failed" } end
keymap("n", "tj", neotest_next_failed, { desc = "Next Failed Test" })
local function neotest_prev_failed() neotest.jump.prev { status = "failed" } end
keymap("n", "tk", neotest_prev_failed, { desc = "Prev Failed Test" })
