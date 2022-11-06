local status, silicon = pcall(require, "silicon")
if not status then return end

silicon.setup {
  font = "FiraCode Nerd Font Mono=30",
  -- font = "Sarasa Mono SC=30",
  -- theme = "gruvbox",
  shadow = {
    blur_radius = 8.0,
    offset_x = 0,
    offset_y = 0,
    color = "#777",
  },
  pad_horiz = 20,
  pad_vert = 20,
  line_number = false,
  line_pad = 0,
  line_offset = 0,
  tab_width = 2,
  round_corner = true,
  window_controls = false,
  watermark = {
    text = "By Lixiaohui",
  },
}
