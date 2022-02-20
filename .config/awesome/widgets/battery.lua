local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local apps = require("config.apps")
local upower = require('lgi').require('UPowerGlib')
-- This uses UPowerGlib.Device (https://lazka.github.io/pgi-docs/UPowerGlib-1.0/classes/Device.html)
-- Provides:
-- signal::battery
--      percentage
--      state
--      time_to_empty

-- awful.spawn.easy_async('cat /sys/class/dmi/id/chassis_type', function (out)
  -- check if the host machine is a laptop/desktop with the chassis_type value
  -- if out ~= "3" then
    local upower_widget = require("modules.awesome-battery_widget")
    local battery_listener = upower_widget({
      instant_update = true,
      use_display_device = true,
    })

    battery_listener:connect_signal("upower::update", function(_, device)
      awesome.emit_signal("signal::battery", device.percentage, device.state, device.time_to_empty, device.time_to_full)
    end)
  -- end
-- end)

local battery_icon = wibox.widget({
	align = "center",
	valign = "center",
  resize = true,
	widget = wibox.widget.textbox,
})

local battery_tooltip = awful.tooltip({
  objects = {battery_icon},
  mode = "outside",
  align = "left",
  margin = 10,
  referred_positions = {"right", "left", "top", "bottom"}
})

awesome.connect_signal("signal::battery", function(percentage, state, time_to_empty, time_to_full)
	local value = percentage

	local bat_icon = "  "
	local bat_color = beautiful.white
  battery_icon.font = "JetBrains Mono Nerd Font 15"
  local time = time_to_empty
  local time_to_x = 'empty'
  local percentage_font = beautiful.font_name .. "10"

	if value >= 0 and value <= 15 then
		bat_icon = "  "
		bat_color = beautiful.red
	elseif value > 15 and value <= 20 then
		bat_icon = "  "
		bat_color = beautiful.red
  elseif value > 20 and value <= 30 then
		bat_icon = "  "
		bat_color = beautiful.orange
	elseif value > 30 and value <= 40 then
		bat_icon = "  "
		bat_color = beautiful.orange
	elseif value > 40 and value <= 50 then
		bat_icon = "  "
		bat_color = beautiful.yellow
	elseif value > 50 and value <= 60 then
		bat_icon = "  "
		bat_color = beautiful.yellow
	elseif value > 60 and value <= 70 then
		bat_icon = "  "
		bat_color = beautiful.yellow
	elseif value > 70 and value <= 80 then
		bat_icon = "  "
		bat_color = beautiful.white
	elseif value > 80 and value <= 90 then
		bat_icon = "  "
		bat_color = beautiful.white
	elseif value > 90 and value <= 100 then
		bat_icon = "  "
	  bat_color = beautiful.white
	end

	-- if charging
	if state == 1 then
    battery_icon.font = beautiful.icon_font
		bat_icon = ""
		bat_color = beautiful.blue
    time = time_to_full
    time_to_x = 'full'
	end
	battery_icon.markup = "<span font='" .. percentage_font .. "' rise='3pt'>" .. string.format('%3d', percentage) .. "% " .. "</span><span foreground='" .. bat_color .. "'>"  .. bat_icon .. "</span>"
  battery_tooltip.text = string.format('State: %s \nPercentage: %3d%% \nTime to %s: %s', upower.DeviceState[state], percentage, time_to_x, upower_widget.to_clock(time))
end)

return battery_icon
