require("persistent-breakpoints").setup { save_dir = vim.fn.stdpath("data") .. "/dap" }

local breakpoints = require("dap.breakpoints")

local get_project_name = function()
  local cp_filename = (vim.fn.getcwd()):gsub("/", "_") .. ".json"
  return vim.fn.stdpath("data") .. "/dap/" .. cp_filename
end

vim.api.nvim_create_autocmd({ "BufReadPost" }, { callback = require("persistent-breakpoints.api").load_breakpoints })

local dap, dapui = require("dap"), require("dapui");

require("nvim-dap-virtual-text").setup({})

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

dapui.setup({
  -- icons = { expanded = "▾", collapsed = "▸" },
  icons = { expanded = "", collapsed = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  expand_lines = vim.fn.has("nvim-0.7"),
  layouts = {
    {
      elements = { "scopes", "breakpoints", "stacks", "watches" },
      size = 40,
      position = "left",
    },
    {
      elements = { "repl", "console" },
      size = 10,
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
})

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "FoldColumn", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" }) --  
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "", linehl = "", numhl = "" })

dap.adapters.lldb = { type = "executable", command = "lldb-vscode" }

local c_config = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}

dap.configurations.c = c_config
dap.configurations.cpp = c_config
dap.configurations.rust = c_config
