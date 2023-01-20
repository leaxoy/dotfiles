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
    { "tf", [[<CMD>lua require('neotest').run.run()<CR>]], desc = "Test Current Function" },
    {
      "tr",
      [[<CMD>lua require('neotest').run.run(vim.fn.expand '%')<CR>]],
      desc = "Test Current File",
    },
    { "tt", [[<CMD>lua require('neotest').run.run(vim.fn.getcwd())<CR>]], desc = "Test Project" },
    { "td", [[<CMD>lua require('neotest').run.run { strategy = 'dap' }<CR>]], desc = "Debug Test" },
    { "ts", [[<CMD>lua require('neotest').summary.toggle()<CR>]], desc = "Toggle Test Summary" },
    {
      "to",
      [[<CMD>lua require('neotest').output.open { enter = true }<CR>]],
      desc = "Toggle Test Output",
    },
    {
      "[t",
      [[<CMD>lua require('neotest').jump.prev { status = "failed" }<CR>]],
      desc = "Prev Failed TestCase",
    },
    {
      "]t",
      [[<CMD>lua require('neotest').jump.next { status = "failed" }<CR>]],
      desc = "Next Failed TestCase",
    },
  },
  config = function()
    local neotest = (require "neotest")

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
  end,
}
