return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-python",
    "rouge8/neotest-rust",
  },
  cmd = "Neotest",
  ---@type LazyKeys[]
  keys = {
    { "tf", [[<CMD>Neotest run<CR>]], desc = "Current Function" },
    { "tr", [[<CMD>Neotest run file<CR>]], desc = "Current file" },
    { "tt", string.format("<CMD>Neotest run %s<CR>", vim.loop.cwd()), desc = "Project" },
    { "td", [[<CMD>Neotest run strategy=dap<CR>]], desc = "Debug" },
    { "ta", [[<CMD>Neotest attach<CR>]], desc = "Attach Test" },
    { "ts", [[<CMD>Neotest summary toggle<CR>]], desc = "Test Explorer" },
    { "to", [[<CMD>Neotest output-panel<CR>]], desc = "Toggle Output" },
    { "[t", [[<CMD>Neotest jump prev status=failed<CR>]], desc = "Prev Failed TestCase" },
    { "]t", [[<CMD>Neotest jump next status=failed<CR>]], desc = "Next Failed TestCase" },
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
      },
      summary = { mappings = { jumpto = "<CR>", expand = "<TAB>" } },
    }
  end,
}
