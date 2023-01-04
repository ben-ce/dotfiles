local theme = {}

-- Catppuccin Frappe color scheme
theme.rosewater = "#F2D5CF"
theme.flamingo = "#EEBEBE"
theme.pink = "#F4B8E4"
theme.mauve = "#CA9EE6"
theme.red = "#E78284"
theme.maroon = "#EA999C"
theme.peach = "#EF9F76"
theme.yellow = "#E5C890"
theme.green = "#A6D189"
theme.teal = "#81C8BE"
theme.sky = "#99D1DB"
theme.sapphire = "#85C1DC"
theme.blue = "#8CAAEE"
theme.lavender = "#BABBF1"

theme.text = "#c6d0f5"
theme.subtext1 = "#b5bfe2"
theme.subtext0 = "#a5adce"
theme.overlay2 = "#949cbb"
theme.overlay1 = "#838ba7"
theme.overlay0 = "#737994"
theme.surface2 = "#626880"
theme.surface1 = "#51576d"
theme.surface0 = "#414559"

theme.base = "#303446"
theme.mantle = "#292C3C"
theme.crust = "#232634"

theme.orange = theme.peach
theme.white = theme.text
theme.gray = theme.surface1
theme.black = theme.surface0
theme.accent = theme.text
theme.color3 = theme.overlay1
theme.color4 = theme.overlay2

theme.bg_normal = theme.base
theme.bg_focus = theme.black
theme.bg_urgent = theme.bg_normal
theme.bg_minimize = theme.bg_normal
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.text
theme.fg_focus = theme.fg_normal
theme.fg_urgent = theme.subtext0
theme.fg_minimize = theme.fg_normal

theme.groups_bg = theme.bg_normal

theme.border_normal = theme.teal
theme.border_marked = theme.red
theme.border_focus = theme.lavender

theme.widget_bg = theme.bg_focus
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
