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

theme.taglist_squares_sel                       = ''
theme.taglist_squares_unsel                     = ''

return theme
