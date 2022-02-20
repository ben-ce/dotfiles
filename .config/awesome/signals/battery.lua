-- This uses UPowerGlib.Device (https://lazka.github.io/pgi-docs/UPowerGlib-1.0/classes/Device.html)
-- Provides:
-- signal::battery
--      percentage
--      state
local awful = require'awful'
local naughty = require('naughty')

awful.spawn.easy_async('cat /sys/class/dmi/id/chassis_type', function (out)
  -- check if the host machine is a laptop/desktop with the chassis_type value
  if out ~= "3" then
    local upower_widget = require("modules.awesome-battery_widget")
    local battery_listener = upower_widget({
    	device_path = "/org/freedesktop/UPower/devices/battery_BAT0",
    	instant_update = true,
    })

    battery_listener:connect_signal("upower::update", function(_, device)
    	awesome.emit_signal("signal::battery", device.percentage, device.state)
    end)
  end
end)