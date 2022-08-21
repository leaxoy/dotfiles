require("bufferline").setup({
  options = {
    numbers = function(opts) return string.format("[%s]", opts.ordinal) end,
    offsets = {
      { filetype = "NvimTree", text = "File Explorer", highlight = "Directory", text_align = "center" },
    },
    show_close_icon = false,
    show_buffer_close_icons = false,
    show_buffer_icons = true,
    show_tab_indicators = false,
    modified_icon = "●",
    always_show_bufferline = true,
    separator_style = "slant",
    tab_size = 16,
    left_trunc_marker = "",
    right_trunc_marker = "",
    color_icons = true,
  },
  highlights = {
    fill = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "StatusLineNC" },
    },
    background = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "StatusLine" },
    },
    buffer_visible = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "Normal" },
    },
    buffer_selected = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "Normal" },
    },
    separator = {
      fg = { attribute = "bg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "StatusLine" },
    },
    separator_selected = {
      fg = { attribute = "fg", highlight = "Special" },
      bg = { attribute = "bg", highlight = "Normal" },
    },
    separator_visible = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "StatusLineNC" },
    },
    close_button = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "StatusLine" },
    },
    close_button_selected = {
      fg = { attribute = "fg", highlight = "normal" },
      bg = { attribute = "bg", highlight = "normal" },
    },
    close_button_visible = {
      fg = { attribute = "fg", highlight = "normal" },
      bg = { attribute = "bg", highlight = "normal" },
    },
  },
})
