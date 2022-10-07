local dpi = require("beautiful").xresources.apply_dpi
local gtable = require("gears.table")
local default_theme = require("themes.default.theme")
local theme_assets = require("beautiful.theme_assets")

local theme = {}
-- Override elements in the custom theme table with the default ones
gtable.crush(theme, default_theme)

-- Catppuccin Frappe color scheme
theme.color0 = "#51576D"
theme.color1 = "#626880"
theme.color2 = "#F2D5CF"
theme.color3 = "#737994"
theme.color4 = "#A5ADCE"
theme.color5 = "#B5BFE2"
theme.color6 = "#CA9EE6"
theme.color7 = "#8CAAEE"
theme.color8 = "#85c1dc"
theme.color9 = "#99d1db"
theme.color10 = "#81c8be"
theme.color11 = "#81c8be"
theme.color12 = "#A6D189"
theme.color13 = "#E5C890"
theme.color14 = "#ef9f76"
theme.color15 = "#E78284"
theme.background = "#303446"
theme.foreground = "#C6D0F5"

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

theme.border_normal = theme.color7
theme.border_marked = theme.color15
theme.border_focus  = theme.color7

theme.widget_bg = theme.black
theme.wibar_bg = theme.bg_normal

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

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height*2, theme.bg_focus, theme.fg_focus
)

return theme
