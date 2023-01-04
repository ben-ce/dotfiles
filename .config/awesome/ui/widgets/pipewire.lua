-- __     __    _
-- \ \   / /__ | |_   _ _ __ ___   ___
--  \ \ / / _ \| | | | | '_ ` _ \ / _ \
--   \ V / (_) | | |_| | | | | | |  __/
--    \_/ \___/|_|\__,_|_| |_| |_|\___|
--

-------------------------------------------------
-- Speaker Volume Widget for Pipewire-Pulse
-------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wbutton = require("ui.widgets.button")

local get_volume_cmd
local inc_volume_cmd
local dec_volume_cmd
local mute_volume_cmd

local widget = {}

local function worker(user_args)
	local args = user_args or {}

	local icon = args.icon
	local font = args.font or beautiful.font
	local timeout = args.timeout or 2
	local program = args.program or "pactl"

	if program == "pactl" then
		get_volume_cmd = 'bash -c "pactl get-sink-volume @DEFAULT_SINK@ && pactl get-sink-mute @DEFAULT_SINK@"'
		inc_volume_cmd = "pactl set-sink-volume @DEFAULT_SINK@ +5%"
		dec_volume_cmd = "pactl set-sink-volume @DEFAULT_SINK@ -5%"
		mute_volume_cmd = "pactl set-sink-mute @DEFAULT_SINK@ toggle"
	end

	local volume = {}
	volume.widget = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = 4,
		{
			id = "icon",
			align = "center",
			valign = "center",
			resize = true,
			font = "Iosevka 24",
			widget = wibox.widget.textbox,
		},
		{
			id = "volume",
			font = font,
			widget = wibox.widget.textbox,
		},

		update_volume = function(self, value, is_mute)
			local font_color = beautiful.fg_normal
			local volume_icon
			local volume_text = string.format("%d", value) .. "%"
			if is_mute then
				volume_icon = string.format("%s", "\u{fc5d}")
				volume_text = string.format("%s", "mute")
				font_color = beautiful.gray
			elseif value >= 50 then
				volume_icon = string.format("%s", "\u{f028}")
			elseif value >= 25 then
				volume_icon = string.format("%s", "\u{f027}")
			else
				volume_icon = string.format("%s", "\u{f026}")
			end
			local volume_icon_markup =
				string.format("<span font='%s' foreground='%s'>%s</span>", self.icon.font, font_color, volume_icon)
			local volume_markup =
				string.format("<span font='%s' foreground='%s'>%s</span>", font, font_color, volume_text)

			if self.icon:get_markup() ~= volume_icon_markup then
				self.icon:set_markup(volume_icon_markup)
			end
			if self.volume:get_markup() ~= volume_markup then
				self.volume:set_markup(volume_markup)
			end
		end,
	})

	function volume:mute()
		awful.spawn.easy_async(mute_volume_cmd, function() end)
	end

	function volume:inc()
		awful.spawn.easy_async(inc_volume_cmd, function() end)
	end

	function volume:dec()
		awful.spawn.easy_async(dec_volume_cmd, function() end)
	end

	function volume:open()
		awful.spawn("pavucontrol")
	end

	--- Adds mouse controls to the widget:
	--  - left click - pavucontrol
	--  - scroll up - volume up
	--  - scroll down - volume down
	--  - right click - start noisetorch
	volume.widget:buttons(awful.util.table.join(
		awful.button({}, 1, function()
			volume:mute()
		end),
		awful.button({}, 3, function()
			volume:open()
		end),
		awful.button({}, 4, function()
			volume:inc()
		end),
		awful.button({}, 5, function()
			volume:dec()
		end)
	))
	awesome.connect_signal("signals::volume", function(value, muted)
		volume.widget:update_volume(value, muted)
	end)

	widget = wbutton.elevated.state({
		child = volume.widget,
		normal_bg = beautiful.bg_normal,
		margins = dpi(2),
	})
	return widget
end

return setmetatable(widget, {
	__call = function(_, ...)
		return worker(...)
	end,
})
