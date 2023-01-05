local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local wbutton = require("ui.widgets.button")
local apps = require("config.apps")

--- Screenshot Widget
--- ~~~~~~~~~~~~~~~~~

local screenshot = {}

local function button(icon, command)
	return wbutton.text.normal({
		forced_width = dpi(60),
		forced_height = dpi(60),
		normal_bg = beautiful.bg_normal,
		normal_shape = gears.shape.circle,
		on_normal_bg = beautiful.fg_normal,
		text_normal_bg = beautiful.fg_normal,
		text_on_normal_bg = beautiful.bg_normal,
		font = beautiful.icon_font .. "Round ",
		size = 18,
		text = icon,
		on_release = function()
			awesome.emit_signal("control_panel::toggle", awful.screen.focused())
			gears.timer({
				timeout = 1,
				autostart = true,
				single_shot = true,
				callback = function()
					awful.spawn.with_shell(command)
				end,
			})
		end,
	})
end

screenshot.area = button("", apps.utils.area_screenshot)
screenshot.full = button("", apps.utils.full_screenshot)

return screenshot
