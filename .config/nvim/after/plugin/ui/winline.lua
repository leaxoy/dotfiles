if not vim.fn.has "nvim-0.8" then return end

local status, symbol = pcall(require, "lspsaga.symbolwinbar")
vim.api.nvim_create_autocmd(
  { "BufEnter", "BufWinEnter", "CursorMoved", "CursorHold", "CursorHoldI" },
  {
    callback = function()
      if vim.bo.filetype == "dap-repl" then return end
      local excludes = {
        "",
        "toggleterm",
        "prompt",
        "help",
        "netrw",
        "lspsagaoutline",
        "qf",
        "packer",
        "git",
        "neotest-summary",
        "dashboard",
        "dapui_scopes",
        "dapui_breakpoints",
        "dapui_stacks",
        "dapui_watches",
        "dapui_console",
      }
      local renamed = {
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
