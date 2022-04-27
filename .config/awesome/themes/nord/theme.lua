local dpi = require("beautiful").xresources.apply_dpi
local gtable = require("gears.table")
local default_theme = require("themes.default.theme")
local gears = require("gears")

local theme = {}
-- Override elements in the custom theme table with the default ones
gtable.crush(theme, default_theme)

-- Nord color scheme
theme.color0  = "#2E3440"
theme.color1  = "#3B4252"
theme.color2  = "#434C5E"
theme.color3  = "#4C566A"
theme.color4  = "#D8DEE9"
theme.color5  = "#E5E9F0"
theme.color6  = "#ECEFF4"
theme.color7  = "#8FBCBB"
theme.color8  = "#88C0D0"
theme.color9  = "#81A1C1"
theme.color10 = "#5E81AC"
theme.color11 = "#BF616A"
theme.color12 = "#D08770"
theme.color13 = "#EBCB8B"
theme.color14 = "#A3BE8C"
theme.color15 = "#B48EAD"

theme.red    = theme.color11
theme.orange = theme.color12
theme.green  = theme.color14
theme.yellow = theme.color13
theme.blue   = theme.color8
theme.white  = theme.color4
theme.black  = theme.color0
theme.black2 = theme.color1
theme.gray   = theme.color2
theme.gray2  = theme.color3

--
theme.font_name            = "JetBrainsMono Nerd Font "
theme.font                 = theme.font_name .. "12"
theme.icon_font_name       = "Ionicons "
theme.icon_font            = theme.icon_font_name .. "24"
theme.title_font           = theme.font
theme.transparent          = "#00000000"
theme.systray_icon_spacing = dpi(8)

theme.bg_normal   = theme.background
theme.bg_focus    = theme.black
theme.bg_urgent   = theme.bg_normal
theme.bg_minimize = theme.bg_normal
theme.bg_systray  = theme.bg_normal

theme.fg_normal   = theme.foreground
theme.fg_focus    = theme.fg_normal
theme.fg_urgent   = theme.color1
theme.fg_minimize = theme.fg_normal

theme.useless_gap   = dpi(10)
theme.border_width  = dpi(0)
theme.border_normal = theme.color7
theme.border_marked = theme.color15
theme.border_focus  = theme.color7

-- theme.taglist_spacing = dpi(5)
theme.taglist_font        = "Iosevka 24"
theme.taglist_bg_focus    = theme.bg_focus
theme.taglist_fg_focus    = theme.fg_normal
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_fg_occupied = theme.green
theme.taglist_bg_empty    = theme.bg_normal
theme.taglist_fg_empty    = theme.gray2
theme.taglist_bg_urgent   = theme.bg_normal
theme.taglist_fg_urgent   = theme.red

theme.taglist_squares_sel   = nil
theme.taglist_squares_unsel = nil

theme.hotkeys_modifiers_fg = theme.white
theme.hotkeys_border_width = 3
theme.hotkeys_border_color = theme.gray

local icondir         = gears.filesystem.get_configuration_dir() .. "icons/"
theme.wallpaper       = '~/Pictures/wallpaper/Monterey.png'
theme.wallpaper_dir   = '~/Pictures/wallpaper/macos/'
theme.menu_icon       = icondir .. 'arch.png'
theme.widget_vol      = icondir .. 'volume/mirage/volume.png'
theme.widget_icon_gap = 2

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

return theme
