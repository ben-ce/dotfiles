local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
-- require("signal.battery")
local gears = require("gears")
local apps = require("config.apps")
local dpi = require("beautiful").xresources.apply_dpi
local helpers = require("helpers")
local upower = require('lgi').require('UPowerGlib')
local wbutton = require("ui.widgets.button")

--- Battery Widget
--- ~~~~~~~~~~~~~~
local upower_widget = require("modules.awesome-battery_widget")
local battery_listener = upower_widget({
	instant_update = true,
  use_display_device = true,
})

battery_listener:connect_signal("upower::update", function(_, device)
  awesome.emit_signal("signal::battery", device.percentage, device.state, device.time_to_empty, device.time_to_full, device.kind)
end)

return function()
	local happy_color = beautiful.fg_normal
	-- local ok_color = beautiful.color2
  local warn_color = beautiful.orange
	local sad_color = beautiful.red
	local charging_color = beautiful.teal

	local charging_icon = wibox.widget({
		markup = helpers.ui.colorize_text("", beautiful.white),
		font = beautiful.icon_font_name .. " 14",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	local battery_bar = wibox.widget({
		max_value = 100,
		value = 50,
		forced_width = dpi(30),
		border_width = dpi(1),
    -- forced_height = dpi(10),
		paddings = dpi(1),
		bar_shape = helpers.ui.rrect(2),
		shape = helpers.ui.rrect(4),
		color = beautiful.white,
		background_color = beautiful.transparent,
		border_color = beautiful.white .. 'BB',
		widget = wibox.widget.progressbar,
	})

	local battery_decoration = wibox.widget({
		{
			wibox.widget.textbox,
			widget = wibox.container.background,
			bg = beautiful.white .. 'BB',
			forced_width = dpi(7.2),
			forced_height = dpi(7.2),
			shape = function(cr, width, height)
				gears.shape.pie(cr, width, height, 0, math.pi)
			end,
		},
		direction = "east",
		widget = wibox.container.rotate(),
	})

	local battery = wibox.widget({
		charging_icon,
		{
			battery_bar,
			battery_decoration,
			layout = wibox.layout.fixed.horizontal,
			spacing = dpi(-2.0),
		},
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(1),
	})

	local battery_percentage_text = wibox.widget({
		id = "percent_text",
		text = "50%",
		font = beautiful.font_name .. "Medium 12",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	local battery_widget = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(5),
    battery,
		battery_percentage_text,
	})
  local battery_tooltip = awful.tooltip{
    objects = {battery},
    mode = "outside",
    align = "left",
    margin = 10,
    preferred_positions = {"right", "left", "top", "bottom"}
  }

	local widget = wbutton.elevated.state({
		child = battery_widget,
		normal_bg = beautiful.wibar_bg,
		on_release = function()
			awful.spawn(apps.power_manager, false)
		end,
    margins = dpi(2),
	})

	local last_value = 100
	awesome.connect_signal("signal::battery", function(value, state, time_to_empty, time_to_full, kind)
		battery_bar.value = value
		last_value = value
    local time = time_to_empty
    local time_to_x = 'empty'

		battery_percentage_text:set_text(math.floor(value) .. "%")

    if kind == 0 then
      battery_tooltip.text = string.format('%s', "Unknown device, likely running on AC Line Power.")
      charging_icon:set_markup(helpers.ui.colorize_text("", beautiful.white))
      battery_bar.visible = false
      battery_decoration.visible = false
      battery_percentage_text.visible = false
    elseif kind == 1 then
      battery_tooltip.text = string.format('%s', "Running on AC Line Power.")
      charging_icon:set_markup(helpers.ui.colorize_text("", beautiful.white))
      battery_bar.visible = false
      battery_decoration.visible = false
      battery_percentage_text.visible = false
    else
      if charging_icon.visible then
        battery_bar.color = charging_color
      elseif value <= 15 then
        battery_bar.color = sad_color
      elseif value <= 30 then
        battery_bar.color = warn_color
      else
        battery_bar.color = happy_color
      end

      if state == 1 then
        charging_icon.visible = true
        battery_bar.color = charging_color
        time = time_to_full
        time_to_x = 'full'
      elseif last_value <= 15 then
        charging_icon.visible = false
        battery_bar.color = sad_color
      elseif last_value <= 30 then
        charging_icon.visible = false
        battery_bar.color = warn_color
      else
        charging_icon.visible = false
        battery_bar.color = happy_color
      end
      battery_tooltip.text = string.format("State: %s \nPercentage: %3d%% \nTime to %s: %s", upower.DeviceState[state], value, time_to_x, upower_widget.to_clock(time))
    end
	end)

	return widget
end
