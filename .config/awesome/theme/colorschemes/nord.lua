-- Nord color scheme
local theme = {
	colors = {
		teal = "#8FBCBB",
		blue = "#88C0D0",
		sapphire = "#81A1C1",
		lavender = "#5E81AC",
		red = "#BF616A",
		peach = "#D08770",
		yellow = "#EBCB8B",
		green = "#A3BE8C",
		mauve = "#B48EAD",

		text = "#D8DEE9",
		subtext1 = "#E5E9F0",
		subtext0 = "#ECEFF4",
		surface1 = "#3B4252",
		surface0 = "#3B4252",
		overlay2 = "#4C566A",
		overlay1 = "#4C566A",

		base = "#2E3440",
		mantle = "#434C5E",
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
