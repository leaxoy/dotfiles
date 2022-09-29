local status, Input = pcall(require, "nui.input")
if not status then return end

local event = require("nui.utils.autocmd").event
vim.ui.input = function(opts, on_confirm)
  local input = Input({
    relative = "cursor",
    position = { row = 1, col = 0 },
    size = {
      width = math.max(30, vim.api.nvim_strwidth(opts.default)),
    },
    border = {
      style = "rounded",
      text = {
        top = opts.prompt or "",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
    -- prompt = opts.prompt or "Input: ",
    default_value = opts.default or "Hello",
    on_close = function() print "Input Closed!" end,
    on_submit = function(value) on_confirm(value) end,
  })
  input:map("n", "<Esc>", function() input:unmount() end, { noremap = true, silent = true })
  input:map("i", "<Esc>", function() input:unmount() end, { noremap = true, silent = true })
  input:map("n", "q", function() input:unmount() end, { noremap = true, silent = true })

  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function() input:unmount() end)

  -- mount/open the component
  input:mount()
end
