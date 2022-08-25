if not vim.fn.has("nvim-0.8") then return end

local status, symbol = pcall(require, "lspsaga.symbolwinbar")
vim.api.nvim_create_autocmd(
  { "BufEnter", "BufWinEnter", "CursorMoved", "CursorHold", "CursorHoldI" },
  {
    pattern = "*",
    callback = function()
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
        "git"
      }
      if vim.api.nvim_win_get_config(0).zindex or vim.tbl_contains(excludes, vim.bo.filetype) then
        vim.wo.winbar = ""
      else
        if not status then
          vim.wo.winbar = vim.fn.bufname()
          return
        end
        vim.wo.winbar = symbol:get_symbol_node() or ""
      end
    end
  })
