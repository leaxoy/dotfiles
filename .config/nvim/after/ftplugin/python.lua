local dap = require "dap"

dap.adapters.python = {
  type = "executable",
  -- command = "/usr/local/bin/python3",
  command = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python3",
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = "launch",
    name = "Python: Current File",

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}", -- This configuration will launch the current file if used.
    justMyCode = true,
    cwd = "${workspaceFolder}",
    env = { PYTHONPATH = "${PYTHONPATH}:${workspaceRoot}" },
    pythonPath = function()
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
    end,
  },
}
