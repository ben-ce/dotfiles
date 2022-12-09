local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wbutton = require("ui.widgets.button")

--- Mic Widget
--- ~~~~~~~~~~~~~~~~~

local function button(icon)
  return wbutton.text.state({
    forced_width = dpi(60),
    forced_height = dpi(60),
    normal_bg = beautiful.black,
    normal_shape = gears.shape.circle,
    on_normal_bg = beautiful.accent,
    text_normal_bg = beautiful.accent,
    text_on_normal_bg = beautiful.black,
    font = beautiful.icon_font_name,
    size = 18,
    text = icon,
  })
end

local widget = button("\u{f131}")

local update_widget = function()
  awful.spawn.easy_async_with_shell(
    [[
    pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}'
    ]],
    function(stdout)
      if stdout:match("no") then
        widget:turn_off()
      else
        widget:turn_on()
      end
    end
  )
end

--- run once every startup/reload
update_widget()

--- buttons
widget:buttons(gears.table.join(awful.button({}, 1, nil, function()
  awful.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle", false)
  update_widget()
end)))

--- signal to use when using the mute hotkey
awesome.connect_signal("mic_mute::toggle", function ()
  update_widget()
end)

return widget
