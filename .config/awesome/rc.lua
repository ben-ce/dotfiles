-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Theme handling library
local beautiful = require("beautiful")

-- Standard awesome library
local gears = require("gears")

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
local themes = {
  "nord", -- 1
  "tokyonight", -- 2
  "catppuccin-frappe", -- 3
}

local chosen_theme = themes[2]
beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- Set keys
require("bindings")
-- }}}

-- {{{ Rules
require("rules")
-- }}}

-- {{{ Signals and startup error handling
require("signals")
-- }}}

-- {{{ Modules
require('modules.notifications')
-- }}}

-- {{{ Autostart applications
require("config.xdg_autostart")
-- }}}

require("ui")

-- {{{ Enable for lower memory consumption
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
gears.timer({
	timeout = 5,
	autostart = true,
	call_now = true,
	callback = function()
		collectgarbage("collect")
	end,
})
-- }}}
