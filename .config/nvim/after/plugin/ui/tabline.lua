local status, bufferline = pcall(require, "bufferline")
if not status then return end

bufferline.setup({
  options = {
    numbers = function(opts) return string.format("[%s]", opts.ordinal) end,
    offsets = {
      { filetype = "NvimTree", text = "File Explorer", highlight = "Directory", text_align = "center" },
      { filetype = "neo-tree", text = "File Explorer", highlight = "Directory", text_align = "center" },
      { filetype = "lspsagaoutline", text = "Outline", highlight = "Directory", text_align = "center" },
      { filetype = "neotest-summary", text = "Tests", highlight = "Directory", text_align = "center" },
    },
    show_close_icon = false,
    show_buffer_close_icons = false,
    show_buffer_icons = true,
    show_tab_indicators = false,
    modified_icon = "●",
    always_show_bufferline = true,
    -- separator_style = "slant",
    tab_size = 16,
    left_trunc_marker = "",
    right_trunc_marker = "",
    color_icons = true,
    hover = { enabled = true, delay = 250, reveal = { "close" } },
  },
})

local map = require("fn").map_fn
map("n", "<C-b>", function() bufferline.go_to(vim.api.nvim_get_vvar("count") or -1) end, { desc = "Goto Buffer" })
map("n", "<leader>bp", bufferline.toggle_pin, { desc = "Pin Buffer" })
