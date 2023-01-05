-- Catppuccin Macchiato color scheme
local theme = {
	colors = {
		rosewater = "#F4DBD6",
		flamingo = "#F0C6C6",
		pink = "#F5BDE6",
		mauve = "#C6A0F6",
		red = "#ED8796",
		maroon = "#EE99A0",
		peach = "#F5A97F",
		yellow = "#EED49F",
		green = "#A6DA95",
		teal = "#8BD5CA",
		sky = "#91D7E3",
		sapphire = "#7DC4E4",
		blue = "#8AADF4",
		lavender = "#B7BDF8",

		text = "#CAD3F5",
		subtext1 = "#B8C0E0",
		subtext0 = "#A5ADCB",
		overlay2 = "#939AB7",
		overlay1 = "#8087A2",
		overlay0 = "#6E738D",
		surface2 = "#5B6078",
		surface1 = "#494D64",
		surface0 = "#363A4F",

		base = "#24273A",
		mantle = "#1E2030",
		crust = "#181926",
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
