local wez = require("wezterm")

return {
	allow_square_glyphs_to_overflow_width = "Always",
	automatically_reload_config = true,
	bold_brightens_ansi_colors = true,
	color_scheme = "Catppuccin Mocha",
	enable_kitty_keyboard = true,
	font = wez.font_with_fallback({
		{ family = "FiraCode Nerd Font Mono", weight = 500 },
		{ family = "Mononoki Nerd Font Mono", weight = 500 },
	}),
	font_size = 20.0,
	hide_tab_bar_if_only_one_tab = true,
	keys = {},
	key_tables = {},
	line_height = 1.0,
	initial_cols = 120,
	initial_rows = 40,
	native_macos_fullscreen_mode = true,
	pane_focus_follows_mouse = true,
	tab_bar_at_bottom = true,
	text_background_opacity = 1.0,
	unicode_version = 15,
	use_cap_height_to_scale_fallback_fonts = true,
	use_fancy_tab_bar = false,
	use_ime = true,
	use_resize_increments = true,
	window_background_opacity = 0.95,
	window_decorations = "RESIZE",
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
}
