if not vim.fn.has "nvim-0.8" then return end

local status, symbol = pcall(require, "lspsaga.symbolwinbar")
vim.api.nvim_create_autocmd(
  { "BufEnter", "BufWinEnter", "CursorMoved", "CursorHold", "CursorHoldI" },
  {
    pattern = "*",
    callback = function()
      if vim.bo.filetype == "dap-repl" then return end
      local excludes = {
        "",
        "toggleterm",
        "prompt",
        "NvimTree",
        "help",
        "netrw",
        "lspsagaoutline",
        "qf",
        "packer",
        "git",
        "neo-tree",
        "neotest-summary",
        "dashboard",
      }
      local renamed = {
        dapui_scopes = "Dap Scopes",
        dapui_breakpoints = "Dap Breakpoints",
        dapui_stacks = "Dap Stacks",
        dapui_watches = "Dap Watches",
        dapui_console = "Dap Console",
        OverseerList = "Tasks List",
        tsplayground = "TreeSitter Playground",
      }
      if vim.api.nvim_win_get_config(0).zindex or vim.tbl_contains(excludes, vim.bo.filetype) then
        vim.wo.winbar = ""
      elseif vim.tbl_contains(vim.tbl_keys(renamed), vim.bo.filetype) then
        vim.wo.winbar = renamed[vim.bo.filetype]
      else
        vim.wo.winbar = not status and vim.fn.bufname() or symbol:get_symbol_node() or ""
      end
    end,
  }
)
