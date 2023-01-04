local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wbutton = require("ui.widgets.button")
local helpers = require("helpers")

local notifbox_core = require("ui.panel.notification-panel.notif-center.build-notifbox")
local reset_notifbox_layout = notifbox_core.reset_notifbox_layout
local delete_button = wbutton.text.normal({
	forced_width = dpi(160),
	forced_height = dpi(45),
	font = beautiful.icon_font_name,
	text_normal_bg = beautiful.red,
	normal_bg = beautiful.bg_normal,
	normal_shape = helpers.ui.rrect(12),
	text = "",
	size = 14,
	animate_size = false,
	on_release = function()
		reset_notifbox_layout()
	end,
})

return delete_button
