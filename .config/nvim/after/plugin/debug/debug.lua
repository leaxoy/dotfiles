local bp = require "persistent-breakpoints"

bp.setup { save_dir = vim.fn.stdpath "data" .. "/dap" }

local bp_api = require "persistent-breakpoints.api"

vim.api.nvim_create_autocmd("BufReadPost", { callback = bp_api.load_breakpoints })
vim.api.nvim_create_autocmd({ "VimLeave", "BufLeave" }, { callback = bp_api.store_breakpoints })

local dap, dapui = require "dap", require "dapui"

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

dapui.setup {
  icons = { expanded = "▾", collapsed = "▸" },
  -- icons = { expanded = "", collapsed = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  expand_lines = vim.fn.has "nvim-0.7",
  layouts = {
    {
      elements = { "scopes", "breakpoints", "stacks", "watches" },
      size = 0.25,
      position = "left",
    },
    {
      elements = { "repl", "console" },
      size = 0.25,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "rounded",
    mappings = { close = { "q", "<Esc>" } },
  },
  windows = { indent = 1 },
  render = {},
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" })
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapBreakpointRejected",
  { text = "", texthl = "FoldColumn", linehl = "", numhl = "" }
)
vim.fn.sign_define("DapStopped", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" }) --  
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "", linehl = "", numhl = "" })

local map = require("fn").map_fn
map("nvi", "<F4>", bp_api.toggle_breakpoint, { desc = "Toggle Breakpoint" })
map("nvi", "<F5>", dap.continue, { desc = "Run | Countine" })
map("nvi", "<F6>", function() dap.step_back() end, { desc = "Step Back" })
map("nvi", "<F7>", function() dap.step_over() end, { desc = "Step Over" })
map("nvi", "<F8>", function() dap.step_into() end, { desc = "Step Into" })
map("nvi", "<F9>", function() dap.step_out() end, { desc = "Step Out" })
-- map({ "n" }, "<leader>dr", function() dap.repl.toggle() end, { desc = "Repl" })
map("nv", "<M-e>", function() dapui.eval(nil, { enter = true }) end, { desc = "Eval Expression" })
map(
  "ni",
  "<M-f>",
  function() dapui.float_element("scopes", { enter = true }) end,
  { desc = "Show Floating Window" }
)
-- map("n", "<leader>du", ui.toggle, { desc = "Debug Window" })
