local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wbutton = require("ui.widgets.button")

--- Colorscheme selector Quick Settings button
--- ~~~~~~~~~~~~~~~~~
local function button(icon)
	return wbutton.text.normal({
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

local widget = button("")
-- buttons
widget:buttons(gears.table.join(awful.button({}, 1, nil, function()
	awesome.emit_signal("colorscheme_popup::toggle", awful.screen.focused())
end)))

return widget
