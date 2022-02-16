local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gtable = require("gears.table")
local default_theme = require("themes.default.theme")

local theme = {}
-- Override elements in the custom theme table with the default ones
gtable.crush(theme, default_theme)

theme.nord0  = "#2E3440"
theme.nord1  = "#3B4252"
theme.nord2  = "#434C5E"
theme.nord3  = "#4C566A"
theme.nord4  = "#D8DEE9"
theme.nord5  = "#E5E9F0"
theme.nord6  = "#ECEFF4"
theme.nord7  = "#8FBCBB"
theme.nord8  = "#88C0D0"
theme.nord9  = "#81A1C1"
theme.nord10 = "#5E81AC"
theme.nord11 = "#BF616A"
theme.nord12 = "#D08770"
theme.nord13 = "#EBCB8B"
theme.nord14 = "#A3BE8C"
theme.nord15 = "#B48EAD"

theme.font          = "JetBrainsMono Nerd Font 12"
theme.title_font    = theme.font
theme.transparent   = "#00000000"

theme.bg_normal     = theme.nord0
theme.bg_focus      = theme.bg_normal
theme.bg_urgent     = theme.bg_normal
theme.bg_minimize   = theme.bg_normal
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = theme.nord4
theme.fg_focus      = theme.fg_normal
theme.fg_urgent     = theme.fg_normal
theme.fg_minimize   = theme.fg_normal

theme.useless_gap   = dpi(15)
theme.border_width  = dpi(0)
theme.border_normal = theme.nord9
theme.border_marked = theme.nord11
theme.border_focus  = theme.nord0

-- theme.taglist_spacing = dpi(5)
theme.taglist_bg_focus = theme.bg_normal
theme.taglist_fg_focus = theme.fg_normal
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_fg_occupied = theme.nord14
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_fg_empty = theme.nord3
theme.taglist_bg_urgent = theme.bg_normal
theme.taglist_fg_urgent = theme.nord11

theme.taglist_squares_sel                       = nil
theme.taglist_squares_unsel                     = nil

theme.hotkeys_modifiers_fg = theme.nord7
theme.hotkeys_border_width = 3
theme.hotkeys_border_color = theme.nord2

theme.wallpaper = '~/Pictures/wallpaper/WhiteSur-light.png'

theme.window_switcher_widget_bg = theme.bg_normal              -- The bg color of the widget
theme.window_switcher_widget_border_width = 0            -- The border width of the widget
theme.window_switcher_widget_border_radius = 10           -- The border radius of the widget
theme.window_switcher_widget_border_color = theme.border_normal    -- The border color of the widget
theme.window_switcher_clients_spacing = 20               -- The space between each client item
theme.window_switcher_client_icon_horizontal_spacing = 5 -- The space between client icon and text
theme.window_switcher_client_width = 150                 -- The width of one client widget
theme.window_switcher_client_height = 250                -- The height of one client widget
theme.window_switcher_client_margins = 10                -- The margin between the content and the border of the widget
theme.window_switcher_thumbnail_margins = 10             -- The margin between one client thumbnail and the rest of the widget
theme.thumbnail_scale = false                            -- If set to true, the thumbnails fit policy will be set to "fit" instead of "auto"
theme.window_switcher_name_margins = 10                  -- The margin of one clients title to the rest of the widget
theme.window_switcher_name_valign = "center"             -- How to vertically align one clients title
theme.window_switcher_name_forced_width = 200            -- The width of one title
theme.window_switcher_name_font = theme.font             -- The font of all titles
theme.window_switcher_name_normal_color = theme.fg_normal      -- The color of one title if the client is unfocused
theme.window_switcher_name_focus_color = theme.nord13       -- The color of one title if the client is focused
theme.window_switcher_icon_valign = "center"             -- How to vertically align the one icon
theme.window_switcher_icon_width = 24                    -- The width of one icon

return theme
