local dpi = require("beautiful").xresources.apply_dpi
local gtable = require("gears.table")
local default_theme = require("themes.default.theme")

local theme = {}
-- Override elements in the custom theme table with the default ones
gtable.crush(theme, default_theme)

-- Tokyo Night color scheme
theme.color0 = "#414868"
theme.color1 = "#565f89"
theme.color2 = "#cfc9c2"
theme.color3 = "#9aa5ce"
theme.color4 = "#a9b1d6"
theme.color5 = "#c0caf5"
theme.color6 = "#bb9af7"
theme.color7 = "#7aa2f7"
theme.color8 = "#7dcfff"
theme.color9 = "#2ac3de"
theme.color10 = "#b4f9f8"
theme.color11 = "#73daca"
theme.color12 = "#9ece6a"
theme.color13 = "#e0af68"
theme.color14 = "#ff9e64"
theme.color15 = "#f7768e"
theme.background = "#24283b"
theme.foreground = "#c0caf5"

theme.red    = theme.color15
theme.orange = theme.color14
theme.yellow = theme.color13
theme.green  = theme.color12
theme.blue   = theme.color7
theme.white  = theme.color5
theme.gray   = theme.color1
theme.black  = theme.color0
theme.accent    = theme.white

theme.bg_normal   = theme.background
theme.bg_focus    = theme.black
theme.bg_urgent   = theme.bg_normal
theme.bg_minimize = theme.bg_normal
theme.bg_systray  = theme.bg_normal

theme.fg_normal   = theme.foreground
theme.fg_focus    = theme.fg_normal
theme.fg_urgent   = theme.color1
theme.fg_minimize = theme.fg_normal

theme.groups_bg   = theme.bg_normal

theme.useless_gap   = dpi(10)
theme.border_width  = dpi(0)
theme.border_normal = theme.color7
theme.border_marked = theme.color15
theme.border_focus  = theme.color7

-- theme.taglist_spacing = dpi(5)
theme.taglist_bg_focus    = theme.bg_focus
theme.taglist_fg_focus    = theme.fg_normal
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_fg_occupied = theme.green
theme.taglist_bg_empty    = theme.bg_normal
theme.taglist_fg_empty    = theme.gray
theme.taglist_bg_urgent   = theme.bg_normal
theme.taglist_fg_urgent   = theme.red

theme.taglist_squares_sel   = nil
theme.taglist_squares_unsel = nil

theme.hotkeys_modifiers_fg = theme.white
theme.hotkeys_border_width = 3
theme.hotkeys_border_color = theme.gray

theme.window_switcher_widget_bg = theme.bg_normal -- The bg color of the widget
theme.window_switcher_widget_border_width = 0 -- The border width of the widget
theme.window_switcher_widget_border_radius = 10 -- The border radius of the widget
theme.window_switcher_widget_border_color = theme.border_normal -- The border color of the widget
theme.window_switcher_clients_spacing = 20 -- The space between each client item
theme.window_switcher_client_icon_horizontal_spacing = 5 -- The space between client icon and text
theme.window_switcher_client_width = 150 -- The width of one client widget
theme.window_switcher_client_height = 250 -- The height of one client widget
theme.window_switcher_client_margins = 10 -- The margin between the content and the border of the widget
theme.window_switcher_thumbnail_margins = 10 -- The margin between one client thumbnail and the rest of the widget
theme.thumbnail_scale = false -- If set to true, the thumbnails fit policy will be set to "fit" instead of "auto"
theme.window_switcher_name_margins = 10 -- The margin of one clients title to the rest of the widget
theme.window_switcher_name_valign = "center" -- How to vertically align one clients title
theme.window_switcher_name_forced_width = 200 -- The width of one title
theme.window_switcher_name_font = theme.font -- The font of all titles
theme.window_switcher_name_normal_color = theme.fg_normal -- The color of one title if the client is unfocused
theme.window_switcher_name_focus_color = theme.yellow -- The color of one title if the client is focused
theme.window_switcher_icon_valign = "center" -- How to vertically align the one icon
theme.window_switcher_icon_width = 24 -- The width of one icon

theme.widget_bg = theme.bg_normal
theme.wibar_bg = theme.bg_normal
theme.wibar_height = dpi(35)
theme.border_radius = 10
theme.notification_margin = dpi(5)

return theme
