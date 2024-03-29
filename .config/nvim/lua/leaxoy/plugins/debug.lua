return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      config = function() require("dapui").setup { icons = { current_frame = "" } } end,
    },
    {
      "rcarriga/cmp-dap",
      config = function()
        require("cmp").setup.filetype({ "dap-repl" }, { sources = { { name = "dap" } } })
      end,
    },
    "hrsh7th/nvim-cmp",
    {
      "Weissle/persistent-breakpoints.nvim",
      config = function()
        local bp = require "persistent-breakpoints"
        local bp_api = require "persistent-breakpoints.api"

        bp.setup {
          save_dir = vim.fn.stdpath "data" .. "/dap",
          load_breakpoints_event = "BufReadPost",
        }

        vim.api.nvim_create_autocmd(
          { "VimLeave", "BufLeave" },
          { callback = bp_api.store_breakpoints }
        )
      end,
    },
    "jay-babu/mason-nvim-dap.nvim",
  },
  ---@type LazyKeys[]
  keys = {
    {
      "<F4>",
      [[<CMD>PBToggleBreakpoint<CR>]],
      desc = "Toggle Breakpoint",
      mode = { "n", "v", "i" },
    },
    { "<F5>", [[<CMD>DapContinue<CR>]], desc = "Run | Continue", mode = { "n", "v", "i" } },
    { "<F6>", [[<CMD>DapStepBack<CR>]], desc = "Step Back", mode = { "n", "v", "i" } },
    { "<F7>", [[<CMD>DapStepOver<CR>]], desc = "Step Over", mode = { "n", "v", "i" } },
    { "<F8>", [[<CMD>DapStepInto<CR>]], desc = "Step Into", mode = { "n", "v", "i" } },
    { "<F9>", [[<CMD>DapStepOut<CR>]], desc = "Step Out", mode = { "n", "v", "i" } },
    { "<F10>", [[<CMD>DapTerminate<CR>]], desc = "Terminate", mode = { "n", "v", "i" } },

    {
      "<M-e>",
      [[<CMD>lua require('dapui').eval(nil, { enter = true })<CR>]],
      desc = "Eval Expression",
      mode = { "n", "v", "i" },
    },

    {
      "<M-f>",
      [[<CMD>lua require('dapui').float_element("scopes", { enter = true })<CR>]],
      desc = "Show Floating Window",
      mode = { "n", "v", "i" },
    },
  },
  init = function()
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "WarningMsg" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "WarningMsg" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "FoldColumn" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "WarningMsg" }) --  
    vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "" })
  end,
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    dap.listeners.after.event_initialized = {
      dapui_config = function(_, _) dapui.open {} end,
    }
    dap.listeners.before.event_terminated = {
      dapui_config = function(_, _) dapui.close {} end,
    }
    dap.listeners.before.event_exited = {
      dapui_config = function(_, _) dapui.close {} end,
    }

    local mason_adapter = require "mason-nvim-dap"

    mason_adapter.setup {
      automatic_installation = true,
      ensure_installed = { "delve", "javadbg", "javatest", "lldb", "python" },
      handlers = {
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
                  default = vim.loop.cwd() .. "/a.out",
                }
              end,
              cwd = "${workspaceFolder}",
              stopOnEntry = true,
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
            local virtual_env = vim.fn.getenv "VIRTUAL_ENV"
            local cwd = vim.loop.cwd()
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
              name = "Python: Launch File",

              -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

              program = "${file}", -- This configuration will launch the current file if used.
              justMyCode = true,
              cwd = "${workspaceFolder}",
              env = { PYTHONPATH = "${env:PYTHONPATH}:${workspaceFolder}" },
              pythonPath = python_path_fn,
            },
          }
        end,
      },
    }
  end,
}
