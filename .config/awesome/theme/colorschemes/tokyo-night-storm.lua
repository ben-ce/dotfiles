-- Tokyo Night color scheme
local theme = {
	colors = {
		lavender = "#2ac3de",
		blue = "#7aa2f7",
		sapphire = "#7dcfff",
		sky = "#89ddff",
		teal = "#73daca",
		green = "#9ece6a",
		yellow = "#e0af68",
		peach = "#ff9e64",
		maroon = "#db4b4b",
		red = "#f7768e",
		magenta = "#ff007c",
		mauve = "#bb9af7",
		purple = "#9d7cd8",

		text = "#c0caf5",
		subtext1 = "#a9b1d6",
		subtext0 = "#9aa5ce",
		overlay2 = "#737aa2",
		overlay1 = "#565f89",
		overlay0 = "#545c7e",
		surface2 = "#506d9b",
		surface1 = "#414868",
		surface0 = "#3b4261",

		mantle = "#292e42",
		base = "#24283b",
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
theme.hotkeys_modifiers_fg = theme.colors.fg_normal
theme.hotkeys_border_color = theme.colors.mantle
theme.window_switcher_widget_bg = theme.colors.base -- the bg color of the widget
theme.window_switcher_widget_border_color = theme.colors.blue -- the border color of the widget
theme.window_switcher_name_normal_color = theme.colors.text -- the color of one title if the client is unfocused
theme.window_switcher_name_focus_color = theme.colors.yellow -- the color of one title if the client is focused

return theme
