local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wbutton = require("ui.widgets.button")

--- Mic Widget
--- ~~~~~~~~~~~~~~~~~

local function button(icon)
	return wbutton.text.state({
		forced_width = dpi(60),
		forced_height = dpi(60),
		normal_bg = beautiful.colors.surface1,
		normal_shape = gears.shape.circle,
		on_normal_bg = beautiful.fg_normal,
		text_normal_bg = beautiful.fg_normal,
		text_on_normal_bg = beautiful.colors.surface1,
		font = beautiful.alt_font_name,
		size = 24,
		text = icon,
	})
end

local widget = button("")

local update_widget = function(is_muted)
	if not is_muted then
		widget:turn_off()
	else
		widget:turn_on()
	end
end

--- buttons
widget:buttons(gears.table.join(awful.button({}, 1, nil, function()
	awful.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle", false)
end)))

--- signal to use when using the mute hotkey
awesome.connect_signal("signals::microphone", function(is_muted)
	update_widget(is_muted)
end)

return widget
