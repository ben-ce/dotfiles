-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Theme handling library
local beautiful = require("beautiful")

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
local themes = {
    "nord"           -- 1
}

local chosen_theme = themes[1]
beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- Set keys
require("bindings")
-- }}}

-- {{{ Rules
require("rules")
-- }}}


-- require("themes.wallpaper")


-- A random wallpaper with images from multiple folders
-- bling.module.wallpaper.setup {
--     set_function = bling.module.wallpaper.setters.random,
--     screen = nil,
--     wallpaper = {"~/Pictures"},
--     change_timer = 7, -- prime numbers are better for timers
--     position = "fit",
-- }

-- {{{ Signals and startup error handling
require("signals")
-- }}}

-- {{{ Autostart applications
require("config.xdg_autostart")
-- }}}
