-- Rosé Pine Moon color scheme
-- color names and values defined by the original palette
local palette = {
	love = "#eb6f92",
	gold = "#f6c177",
	rose = "#ea9a97",
	pine = "#3e8fb0",
	foam = "#9ccfd8",
	iris = "#c4a7e7",
	base = "#232136",
	surface = "#2a273f",
	overlay = "#393552",
	highlight_low = "#2a283e",
	highlight_med = "#44415a",
	highlight_high = "#56526e",
	muted = "#6e6a86",
	subtle = "#908caa",
	text = "#e0def4",
}
-- override used color names
local theme = {
	colors = {
		lavender = "#2ac3de",
		blue = palette.pine,
		sapphire = "#9ccfd8",
		sky = "#89ddff",
		teal = palette.foam,
		green = palette.foam,
		yellow = palette.gold,
		peach = palette.rose,
		maroon = "#db4b4b",
		red = palette.love,
		magenta = "#ff007c",
		mauve = "#bb9af7",
		purple = palette.iris,

		text = palette.text,
		subtext1 = "#a9b1d6",
		subtext0 = palette.subtle,
		overlay2 = palette.subtle,
		overlay1 = palette.muted,
		overlay0 = palette.overlay,
		surface2 = palette.highlight_high,
		surface1 = palette.highlight_med,
		surface0 = palette.highlight_low,

		mantle = palette.surface,
		base = palette.base,
		crust = "#1f2335",
		black = "#1d202f",
	},
}

theme.taglist_slidey_color = theme.colors.overlay2
theme.warn_color = theme.colors.peach
theme.err_color = theme.colors.red
theme.battery_charging_color = theme.colors.teal
theme.bg_normal = theme.colors.base
theme.bg_focus = theme.colors.mantle
theme.bg_urgent = theme.colors.base
theme.bg_minimize = theme.colors.base
theme.bg_systray = theme.colors.base
theme.fg_normal = theme.colors.text
theme.fg_focus = theme.colors.text
theme.fg_urgent = theme.colors.mantle
theme.fg_minimize = theme.colors.text
theme.groups_bg = theme.colors.base
theme.border_normal = theme.colors.blue
theme.border_marked = theme.colors.red
theme.border_focus = theme.colors.blue
theme.widget_bg = theme.colors.surface0
theme.wibar_bg = theme.colors.base
theme.taglist_bg_focus = theme.colors.mantle
theme.taglist_fg_focus = theme.colors.text
theme.taglist_bg_occupied = theme.colors.base
theme.taglist_fg_occupied = theme.colors.green
theme.taglist_bg_empty = theme.colors.base
theme.taglist_fg_empty = theme.colors.mantle
theme.taglist_bg_urgent = theme.colors.base
theme.taglist_fg_urgent = theme.colors.red
theme.hotkeys_modifiers_fg = theme.colors.text
theme.hotkeys_border_color = theme.colors.mantle
theme.window_switcher_widget_bg = theme.colors.base -- the bg color of the widget
theme.window_switcher_widget_border_color = theme.colors.blue -- the border color of the widget
theme.window_switcher_name_normal_color = theme.colors.text -- the color of one title if the client is unfocused
theme.window_switcher_name_focus_color = theme.colors.yellow -- the color of one title if the client is focused

return theme
