------------------------------------------------- Brightness Widget for Awesome Window Manager Shows the brightness level of the laptop display
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/brightness-widget

-- @author Pavel Makhov
-- @copyright 2021 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local spawn = require("awful.spawn")
local gfs = require("gears.filesystem")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wbutton = require("ui.widgets.button")

local ICON_DIR = gfs.get_configuration_dir() .. "icons/"
local get_brightness_cmd
local set_brightness_cmd
local inc_brightness_cmd
local dec_brightness_cmd

local widget = {}

local function show_warning(message)
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Brightness Widget",
		text = message,
	})
end

local function worker(user_args)
	local args = user_args or {}

	local type = args.type or "arc" -- arc or icon_and_text
	local path_to_icon = args.path_to_icon or ICON_DIR .. "brightness.svg"
	local font = args.font or beautiful.font
	local timeout = args.timeout or 2

	local program = args.program or "light"
	local step = args.step or 5
	local base = args.base or 20
	local current_level = 0 -- current brightness value
	local tooltip = args.tooltip or false
	local percentage = args.percentage or false
	local brightness = {}

	if program == "light" then
		get_brightness_cmd = "light -G"
		set_brightness_cmd = "light -S %d" -- <level>
		inc_brightness_cmd = "light -A " .. step
		dec_brightness_cmd = "light -U " .. step
	elseif program == "xbacklight" then
		get_brightness_cmd = "xbacklight -get"
		set_brightness_cmd = "xbacklight -set %d" -- <level>
		inc_brightness_cmd = "xbacklight -inc " .. step
		dec_brightness_cmd = "xbacklight -dec " .. step
	elseif program == "brightnessctl" then
		get_brightness_cmd = "brightnessctl get"
		set_brightness_cmd = "brightnessctl set %d%%" -- <level>
		inc_brightness_cmd = "brightnessctl set +" .. step .. "%"
		dec_brightness_cmd = "brightnessctl set " .. step .. "-%"
	else
		show_warning(program .. " command is not supported by the widget")
		return
	end

	if type == "icon_and_text" then
		brightness.widget = wibox.widget({
			layout = wibox.layout.fixed.horizontal,
			spacing = 4,
			{
				id = "icon",
				align = "center",
				valign = "center",
				resize = true,
				font = beautiful.alt_font_name .. 24,
				widget = wibox.widget.textbox,
				text = "\u{f00df}",
			},
			{
				id = "txt",
				font = font,
				widget = wibox.widget.textbox,
			},
			set_value = function(self, level)
				local display_level = level
				if percentage then
					display_level = display_level .. "%"
				end
				self:get_children_by_id("txt")[1]:set_text(display_level)
			end,
		})
	elseif type == "arc" then
		brightness.widget = wibox.widget({
			{
				{
					image = path_to_icon,
					resize = true,
					widget = wibox.widget.imagebox,
				},
				valign = "center",
				layout = wibox.container.place,
			},
			max_value = 100,
			thickness = 2,
			start_angle = 4.71238898, -- 2pi*3/4
			forced_height = 18,
			forced_width = 18,
			paddings = 2,
			widget = wibox.container.arcchart,
			set_value = function(self, level)
				self:set_value(level)
			end,
		})
	else
		show_warning(type .. " type is not supported by the widget")
		return
	end

	function brightness:set(value)
		current_level = value
		spawn.easy_async(string.format(set_brightness_cmd, value), function() end)
	end

	local old_level = 0
	function brightness:toggle()
		if old_level < 0.1 then
			-- avoid toggling between '0' and 'almost 0'
			old_level = 1
		end
		if current_level < 0.1 then
			-- restore previous level
			current_level = old_level
		else
			-- save current brightness for later
			old_level = current_level
			current_level = 0
		end
		brightness:set(current_level)
	end

	function brightness:inc()
		spawn.easy_async(inc_brightness_cmd, function() end)
	end

	function brightness:dec()
		spawn.easy_async(dec_brightness_cmd, function() end)
	end

	brightness.widget:buttons(awful.util.table.join(
		awful.button({}, 1, function()
			brightness:set(base)
		end),
		awful.button({}, 3, function()
			brightness:toggle()
		end),
		awful.button({}, 4, function()
			brightness:inc()
		end),
		awful.button({}, 5, function()
			brightness:dec()
		end)
	))

	awesome.connect_signal("signals::brightness", function(value)
		brightness.widget:set_value(value)
	end)

	if tooltip then
		awful.tooltip({
			objects = { brightness.widget },
			timer_function = function()
				return current_level .. " %"
			end,
		})
	end

	widget = wbutton.elevated.state({
		child = brightness.widget,
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
