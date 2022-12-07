local qf_status, qf = pcall(require, "bqf")
if not qf_status then return end

qf.setup {
  auto_enable = true,
  auto_resize_height = true,
  magic_window = true,
  preview = {
    auto_preview = true,
    show_title = true,
  },
}
