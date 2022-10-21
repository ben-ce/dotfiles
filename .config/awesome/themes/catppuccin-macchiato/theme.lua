local gtable = require("gears.table")
local default_theme = require("themes.default.theme")
local theme_assets = require("beautiful.theme_assets")

local theme = {}
-- Override elements in the custom theme table with the default ones
gtable.crush(theme, default_theme)

-- Catppuccin Macchiato color scheme
theme.rosewater = "#F4DBD6"
theme.flamingo  = "#F0C6C6"
theme.pink      = "#F5BDE6"
theme.mauve     = "#C6A0F6"
theme.red       = "#ED8796"
theme.maroon    = "#EE99A0"
theme.peach     = "#F5A97F"
theme.yellow    = "#EED49F"
theme.green     = "#A6DA95"
theme.teal      = "#8BD5CA"
theme.sky       = "#91D7E3"
theme.sapphire  = "#7DC4E4"
theme.blue      = "#8AADF4"
theme.lavender  = "#B7BDF8"

theme.text      = "#CAD3F5"
theme.subtext1  = "#B8C0E0"
theme.subtext0  = "#A5ADCB"
theme.overlay2  = "#939AB7"
theme.overlay1  = "#8087A2"
theme.overlay0  = "#6E738D"
theme.surface2  = "#5B6078"
theme.surface1  = "#494D64"
theme.surface0  = "#363A4F"

theme.base      = "#24273A"
theme.mantle    = "#1E2030"
theme.crust     = "#181926"

theme.orange    = theme.peach
theme.white     = theme.text
theme.gray      = theme.surface1
theme.black     = theme.surface0
theme.accent    = theme.text

theme.bg_normal   = theme.base
theme.bg_focus    = theme.surface0
theme.bg_urgent   = theme.bg_normal
theme.bg_minimize = theme.bg_normal
theme.bg_systray  = theme.bg_normal

theme.fg_normal   = theme.text
theme.fg_focus    = theme.fg_normal
theme.fg_urgent   = theme.subtext0
theme.fg_minimize = theme.fg_normal

theme.groups_bg   = theme.bg_normal

theme.border_normal = theme.teal
theme.border_marked = theme.red
theme.border_focus  = theme.lavender

theme.widget_bg = theme.bg_focus
theme.wibar_bg = theme.bg_normal

-- theme.taglist_spacing = dpi(5)
theme.taglist_bg_focus    = theme.bg_focus
theme.taglist_fg_focus    = theme.fg_normal
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_fg_occupied = theme.green
theme.taglist_bg_empty    = theme.bg_normal
theme.taglist_fg_empty    = theme.overlay0
theme.taglist_bg_urgent   = theme.bg_normal
theme.taglist_fg_urgent   = theme.red

theme.hotkeys_modifiers_fg = theme.text
theme.hotkeys_border_color = theme.gray

theme.window_switcher_widget_bg = theme.bg_normal -- The bg color of the widget
theme.window_switcher_widget_border_color = theme.border_normal -- The border color of the widget
theme.window_switcher_name_normal_color = theme.fg_normal -- The color of one title if the client is unfocused
theme.window_switcher_name_focus_color = theme.yellow -- The color of one title if the client is focused

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height*2, theme.bg_focus, theme.fg_focus
)

return theme
