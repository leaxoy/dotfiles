return {
  "dnlhc/glance.nvim",
  config = function()
    local glance = require "glance"
    glance.setup {
      border = { enable = true, top_char = "─", bottom_char = "─" },
      folds = { folded = true, fold_open = "▾", fold_closed = "▸" },
      list = { position = "right", width = 0.3 },
      theme = { enable = true, mode = "auto" },
      mappings = {
        list = {
          q = glance.actions.close,
          v = glance.actions.jump_vsplit,
          s = glance.actions.jump_split,
          t = glance.actions.jump_tab,
          ["<Esc>"] = glance.actions.close,
          ["<Tab>"] = glance.actions.enter_win "preview",
          ["<CR>"] = glance.actions.jump,
        },
        preview = {
          q = glance.actions.close,
          ["<Esc>"] = glance.actions.close,
          ["<Tab>"] = glance.actions.enter_win "list",
        },
      },
      winbar = { enable = false },
      hooks = {
        ---@param results table
        ---@param open fun(table)
        ---@param jump fun(any)
        ---@param method string
        ---@diagnostic disable-next-line: unused-local
        before_open = function(results, open, jump, method)
          if #results == 1 then
            jump(results[1]) -- argument is optional
          else
            open(results) -- argument is optional
          end
        end,
      },
    }
  end,
}
