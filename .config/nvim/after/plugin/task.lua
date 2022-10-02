local status, overseer = pcall(require, "overseer")
if not status then return end

overseer.setup {
  strategy = "terminal",
  templates = { "builtin" },
  auto_detect_success_color = true,
  dap = true,
  -- actions = {},
  task_list = {
    default_detail = 1,
    max_width = { 100, 0.2 },
    min_width = { 30, 0.1 },
    direction = "right",
    separator = "────────────────────────────────────────",
    bindings = {
      ["L"] = "IncreaseDetail",
      ["H"] = "DecreaseDetail",
      -- ["<C-h>"] = false,
      -- ["<C-l>"] = false,
    },
  },
  -- task_launcher = {},
  -- task_editor = {},
  task_win = {
    padding = 1,
    win_opts = { winblend = 0 },
  },
  confirm = {
    win_opts = { winblend = 0 },
  },
  form = {
    win_opts = { winblend = 0 },
  },
  -- preload_components = {},
}

local fn = require "fn"
local cmd, map, popup = fn.cmd_fn, fn.map_fn, fn.popup_fn
map("n", "<leader>t", popup "<leader>t", { desc = "+Tasks" })
map("n", "<leader>ta", cmd "OverseerTaskAction", { desc = "Task Action" })
map("n", "<leader>tt", cmd "OverseerToggle!", { desc = "Tasks List" })
map("n", "<leader>tb", cmd "OverseerBuild", { desc = "New Task" })
map("n", "<leader>tr", cmd "OverseerRun", { desc = "Run Task" })
