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
--      time_to_full
--      kind
local upower_widget = require("modules.awesome-battery_widget")
local battery_listener = upower_widget({
  instant_update = true,
  use_display_device = true,
})

battery_listener:connect_signal("upower::update", function(_, device)
  awesome.emit_signal("signal::battery", device.percentage, device.state, device.time_to_empty, device.time_to_full, device.kind)
end)
--


local battery_widget = wibox.widget{
	layout = wibox.layout.fixed.horizontal,
  spacing = 4,
  {
    id = 'icon',
    align = "center",
    valign = "center",
    resize = true,
    font = "Iosevka 40",
    widget = wibox.widget.textbox,
  },
  {
    id = 'value',
    align = "center",
    valign = "center",
    resize = true,
    widget = wibox.widget.textbox,
  }
}

battery_widget:connect_signal("button::press", function (_,_,_,button)
  if button == 1 then
    awful.spawn(apps.power_manager);
    return
  end
end)

local battery_tooltip = awful.tooltip{
  objects = {battery_widget},
  mode = "outside",
  align = "left",
  margin = 10,
  preferred_positions = {"right", "left", "top", "bottom"}
}


awesome.connect_signal("signal::battery", function(percentage, state, time_to_empty, time_to_full, kind)
	local value = percentage
	local bat_icon = ""
	local bat_color = beautiful.white
  local time = time_to_empty
  local time_to_x = 'empty'

  if kind == 0 then
    bat_icon = ''
    bat_color = beautiful.green
    battery_widget.icon.markup = string.format("<span size='28pt' foreground='%s'>%s</span>", bat_color, bat_icon)
    battery_widget.value.markup = string.format("%s", "N/A")
    battery_tooltip.text = string.format('%s', "Unknown device, likely running on AC Line Power.")
  elseif kind == 1 then
    bat_icon = ''
    bat_color = beautiful.blue
    battery_widget.icon.markup = string.format("<span size='28pt' foreground='%s'>%s</span>", bat_color, bat_icon)
    battery_widget.value.markup = string.format("%s", "value")
    battery_tooltip.text = string.format('%s', "Running on AC Line Power.")
  else
  	if value >= 0 and value <= 20 then
      bat_icon = ""
  		bat_color = beautiful.red
    elseif value > 20 and value <= 40 then
      bat_icon = ""
  		bat_color = beautiful.orange
  	elseif value > 40 and value <= 60 then
      bat_icon = ""
  		bat_color = beautiful.yellow
  	elseif value > 60 and value <= 85 then
      bat_icon = ""
  		bat_color = beautiful.white
  	elseif value > 85 and value <= 100 then
      bat_icon = ""
  	  bat_color = beautiful.white
  	end

  	-- if charging
  	if state == 1 then
      bat_icon = ''
      bat_color = beautiful.green
      time = time_to_full
      time_to_x = 'full'
      battery_widget.icon.markup = string.format("<span size='28pt' foreground='%s'>%s</span>", bat_color, bat_icon)
    else
      battery_widget.icon.markup = string.format("<span foreground='%s'>%s</span>", bat_color, bat_icon)
    end
    battery_widget.value.markup = string.format("%d%%", value)
    battery_tooltip.text = string.format("State: %s \nPercentage: %3d%% \nTime to %s: %s", upower.DeviceState[state], percentage, time_to_x, upower_widget.to_clock(time))
  end
end)


return battery_widget
