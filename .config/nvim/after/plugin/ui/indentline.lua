local status, indentline = pcall(require, "indent_blankline")
if not status then return end

indentline.setup {
  show_current_context = true,
  filetype_exclude = { "OverseerForm" },
}
