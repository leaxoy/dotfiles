return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-vim-test",
    "vim-test/vim-test",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-python",
    "rouge8/neotest-rust",
  },
  ---@type LazyKeys[]
  keys = {
    { "tf", [[<CMD>lua require("neotest").run.run()<CR>]], desc = "Current function" },
    {
      "tr",
      [[<CMD>lua require("neotest").run.run(vim.fn.expand "%")<CR>]],
      desc = "Current file",
    },
    { "tt", [[<CMD>lua require("neotest").run.run(vim.loop.cwd())<CR>]], desc = "Project" },
    { "td", [[<CMD>lua require("neotest").run.run { strategy = "dap" }<CR>]], desc = "Debug" },
    { "ta", [[<CMD>lua require("neotest").run.attach()<CR>]], desc = "Attach test" },
    { "ts", [[<CMD>lua require("neotest").summary.toggle()<CR>]], desc = "Explorer" },
    {
      "to",
      [[<CMD>lua require("neotest").output.open { enter = true }<CR>]],
      desc = "Toggle output",
    },
    {
      "[t",
      [[<CMD>lua require("neotest").jump.prev { status = "failed" }<CR>]],
      desc = "Prev failed testCase",
    },
    {
      "]t",
      [[<CMD>lua require("neotest").jump.next { status = "failed" }<CR>]],
      desc = "Next failed testCase",
    },
  },
  config = function()
    local neotest = (require "neotest")

    neotest.setup {
      adapters = {
        require "neotest-python" {
          dap = {
            justMyCode = false,
            cwd = "${workspaceFolder}",
            env = { PYTHONPATH = "${env:PYTHONPATH}:${workspaceFolder}" },
          },
          args = { "--log-level", "DEBUG" },
          runner = "pytest",
        },
        require "neotest-go",
        require "neotest-rust",
        require "neotest-vim-test" { ignore_file_types = { "python", "go", "rust" } },
      },
      summary = { mappings = { jumpto = "<CR>", expand = "<TAB>" } },
    }
  end,
}
