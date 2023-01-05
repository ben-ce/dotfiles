local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wbutton = require("ui.widgets.button")
local helpers = require("helpers")

--- Notif panel
--- ~~~~~~~~~~~
return function(s)
	local icon = wibox.widget({
		markup = helpers.ui.colorize_text("", beautiful.fg_normal),
		align = "center",
		valign = "center",
		font = beautiful.font_name .. "Medium 12",
		widget = wibox.widget.textbox,
	})

	local widget = wbutton.elevated.state({
		child = icon,
		normal_bg = beautiful.wibar_bg,
		on_release = function()
			awesome.emit_signal("notification_panel::toggle", s)
		end,
		margins = dpi(2),
	})

	return widget
end
