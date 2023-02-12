-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
require("theme")

-- Set keys
require("bindings")
-- }}}

-- {{{ Rules
require("rules")
-- }}}

-- {{{ Signals and startup error handling
require("signals")
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
