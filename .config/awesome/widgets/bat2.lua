local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local clickable_container = require("widgets.clickable-container")
local dpi = require("beautiful").xresources.apply_dpi
local apps = require("config.apps")
-- Load the module
local battery_widget = require("modules.awesome-battery_widget")

-- Create the battery widget:
local my_battery_widget = battery_widget {
    screen = s,
    use_display_device = true,
    widget_template = wibox.widget.textbox
}

-- When UPower updates the battery status, the widget is notified
-- and calls a signal you need to connect to:
my_battery_widget:connect_signal('upower::update', function (widget, device)
    widget.text = string.format('%3d', device.percentage) .. '%'
end)

local widget_button = clickable_container(wibox.container.margin(my_battery_widget, dpi(7), dpi(7), dpi(7), dpi(7)))
widget_button:buttons(
   gears.table.join(
      awful.button({}, 1, nil,
         function()
            awful.spawn(apps.power_manager)
         end
      )
   )
)
return widget_button
