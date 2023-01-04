local theme = {}

-- Nord color scheme
theme.color0 = "#2E3440"
theme.color1 = "#3B4252"
theme.color2 = "#434C5E"
theme.color3 = "#4C566A"
theme.color4 = "#D8DEE9"
theme.color5 = "#E5E9F0"
theme.color6 = "#ECEFF4"
theme.color7 = "#8FBCBB"
theme.color8 = "#88C0D0"
theme.color9 = "#81A1C1"
theme.color10 = "#5E81AC"
theme.color11 = "#BF616A"
theme.color12 = "#D08770"
theme.color13 = "#EBCB8B"
theme.color14 = "#A3BE8C"
theme.color15 = "#B48EAD"
theme.background = theme.color0
theme.foreground = theme.color4

theme.red = theme.color11
theme.orange = theme.color12
theme.yellow = theme.color13
theme.green = theme.color14
theme.blue = theme.color8
theme.white = theme.color4
theme.gray = theme.color2
theme.black = theme.color0
theme.accent = theme.white

theme.bg_normal = theme.background
theme.bg_focus = theme.black
theme.bg_urgent = theme.bg_normal
theme.bg_minimize = theme.bg_normal
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.foreground
theme.fg_focus = theme.fg_normal
theme.fg_urgent = theme.color1
theme.fg_minimize = theme.fg_normal

theme.groups_bg = theme.bg_normal

theme.border_normal = theme.color7
theme.border_marked = theme.color15
theme.border_focus = theme.color7

theme.widget_bg = theme.bg_normal
theme.wibar_bg = theme.bg_normal

-- theme.taglist_spacing = dpi(5)
theme.taglist_bg_focus = theme.bg_focus
theme.taglist_fg_focus = theme.fg_normal
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_fg_occupied = theme.green
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_fg_empty = theme.gray
theme.taglist_bg_urgent = theme.bg_normal
theme.taglist_fg_urgent = theme.red

theme.hotkeys_modifiers_fg = theme.white
theme.hotkeys_border_color = theme.gray

theme.window_switcher_widget_bg = theme.bg_normal -- The bg color of the widget
theme.window_switcher_widget_border_color = theme.border_normal -- The border color of the widget
theme.window_switcher_name_normal_color = theme.fg_normal -- The color of one title if the client is unfocused
theme.window_switcher_name_focus_color = theme.yellow -- The color of one title if the client is focused

return theme
