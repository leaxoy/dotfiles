return {
  "stevearc/overseer.nvim",
  keys = {
    { "<leader>ti", "<CMD>OverseerInfo<CR>", desc = "Task Info" },
    { "<leader>tr", "<CMD>OverseerRun<CR>", desc = "Run Task" },
  },
  config = function() require("overseer").setup {} end,
}
