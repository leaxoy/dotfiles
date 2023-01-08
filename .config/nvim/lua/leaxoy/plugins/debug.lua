return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "rcarriga/cmp-dap",
    "Weissle/persistent-breakpoints.nvim",
    "jayp0521/mason-nvim-dap.nvim",
  },
  event = "BufReadPost",
  keys = {
    {
      "<F4>",
      [[<CMD>PBToggleBreakpoint<CR>]],
      desc = "Toggle Breakpoint",
      mode = { "n", "v", "i" },
    },
    { "<F5>", [[<CMD>DapContinue<CR>]], desc = "Run | Continue", mode = { "n", "v", "i" } },
    { "<F7>", [[<CMD>DapStepBack<CR>]], desc = "Step Back", mode = { "n", "v", "i" } },
    { "<F7>", [[<CMD>DapStepOver<CR>]], desc = "Step Over", mode = { "n", "v", "i" } },
    { "<F8>", [[<CMD>DapStepInto<CR>]], desc = "Step Into", mode = { "n", "v", "i" } },
    { "<F9>", [[<CMD>DapStepOut<CR>]], desc = "Step Out", mode = { "n", "v", "i" } },
  },
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"
    local bp = require "persistent-breakpoints"
    local bp_api = require "persistent-breakpoints.api"

    bp.setup { save_dir = vim.fn.stdpath "data" .. "/dap" }

    vim.api.nvim_create_autocmd("BufReadPost", { callback = bp_api.load_breakpoints })
    vim.api.nvim_create_autocmd({ "VimLeave", "BufLeave" }, { callback = bp_api.store_breakpoints })
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
      controls = {
        element = "repl",
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "",
          terminate = "",
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

    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "ErrorMsg" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "ErrorMsg" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "FoldColumn" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "ErrorMsg" }) --  
    vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "" })

    local function eval() dapui.eval(nil, { enter = true }) end
    keymap("nv", "<M-e>", eval, { desc = "Eval Expression" })
    local dap_float = function() dapui.float_element("scopes", { enter = true }) end
    keymap("ni", "<M-f>", dap_float, { desc = "Show Floating Window" })

    local mason_adapter = require "mason-nvim-dap"

    mason_adapter.setup {
      automatic_installation = true,
      automatic_setup = true,
      ensure_installed = { "delve", "javadbg", "javatest", "lldb", "python" },
    }

    mason_adapter.setup_handlers {
      codelldb = function()
        local lldb_path = vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension"

        dap.adapters.codelldb = {
          type = "server",
          port = "${port}",
          executable = {
            -- command = "codelldb",
            command = lldb_path .. "/adapter/codelldb",
            args = {
              "--port",
              "${port}",
              "--liblldb",
              lldb_path .. "/lldb/lib/liblldb.dylib",
            },
          },
        }

        local codelldb = {
          {
            name = "Launch",
            type = "codelldb",
            request = "launch",
            program = function()
              return vim.fn.input {
                prompt = "Path to executable: ",
                default = vim.fn.getcwd() .. "/a.out",
              }
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = true,
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

        dap.configurations.c = codelldb
        dap.configurations.cpp = codelldb
        dap.configurations.rust = codelldb
      end,
      python = function()
        dap.adapters.python = {
          type = "executable",
          command = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python3",
          args = { "-m", "debugpy.adapter" },
        }

        local function python_path_fn()
          -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
          -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
          -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
          local virtual_env = vim.fn.getenv "VIRTUAL_ENV"
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(virtual_env .. "/bin/python") == 1 then
            return virtual_env .. "/bin/python"
          elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
            return cwd .. "/venv/bin/python"
          elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
            return cwd .. "/.venv/bin/python"
          else
            return "/usr/local/bin/python3"
          end
        end

        dap.configurations.python = {
          {
            -- The first three options are required by nvim-dap
            type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
            request = "launch",
            name = "Current File",

            -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

            program = "${file}", -- This configuration will launch the current file if used.
            justMyCode = true,
            cwd = "${workspaceFolder}",
            env = { PYTHONPATH = "${env:PYTHONPATH}:${workspaceFolder}" },
            pythonPath = python_path_fn,
          },
        }
      end,
    }
  end,
}
