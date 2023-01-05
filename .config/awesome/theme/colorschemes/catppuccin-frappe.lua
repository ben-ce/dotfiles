-- Catppuccin Frappe color scheme
local theme = {
	colors = {
		rosewater = "#F2D5CF",
		flamingo = "#EEBEBE",
		pink = "#F4B8E4",
		mauve = "#CA9EE6",
		red = "#E78284",
		maroon = "#EA999C",
		peach = "#EF9F76",
		yellow = "#E5C890",
		green = "#A6D189",
		teal = "#81C8BE",
		sky = "#99D1DB",
		sapphire = "#85C1DC",
		blue = "#8CAAEE",
		lavender = "#BABBF1",

		text = "#c6d0f5",
		subtext1 = "#b5bfe2",
		subtext0 = "#a5adce",
		overlay2 = "#949cbb",
		overlay1 = "#838ba7",
		overlay0 = "#737994",
		surface2 = "#626880",
		surface1 = "#51576d",
		surface0 = "#414559",

		base = "#303446",
		mantle = "#292C3C",
		crust = "#232634",
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
