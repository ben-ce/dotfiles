local awful = require('awful')
local gears = require('gears')
local naughty = require("naughty")
local ruled = require("ruled")
local menubar = require('menubar')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

naughty.config.defaults.ontop = true
naughty.config.defaults.timeout = 10
naughty.config.defaults.screen = awful.screen.focused()

naughty.config.padding = dpi(20)
naughty.config.spacing = dpi(10)
naughty.config.defaults.shape = function(cr, w, h)
	gears.shape.rounded_rect(cr, w, h, dpi(6))
end

naughty.config.defaults.border_width = dpi(4)
naughty.config.defaults.border_color = beautiful.black

naughty.config.defaults.title = "Notification"

naughty.config.defaults.fg = beautiful.fg_focus
naughty.config.defaults.bg = beautiful.bg_normal

ruled.notification.connect_signal("request::rules", function()
  ruled.notification.append_rule {
    rule       = { urgency = "critical" },
    properties = { bg = beautiful.red, fg = beautiful.black, timeout = 0 }
  }

  ruled.notification.append_rule {
    rule       = { urgency = "normal" },
    properties = { bg      = beautiful.bg_normal, fg = beautiful.fg_normal}
  }
end)

-- Error handling
naughty.connect_signal(
	'request::display_error',
	function(message, startup)
		naughty.notification {
			urgency = 'critical',
			title   = 'Oops, an error happened'..(startup and ' during startup!' or '!'),
			message = message,
			app_name = 'System Notification',
		}
	end
)

-- XDG icon lookup
naughty.connect_signal(
	'request::icon',
	function(n, context, hints)
		if context ~= 'app_icon' then return end

		local path = menubar.utils.lookup_icon(hints.app_icon) or
		menubar.utils.lookup_icon(hints.app_icon:lower())

		if path then
			n.icon = path
		end
	end
)
