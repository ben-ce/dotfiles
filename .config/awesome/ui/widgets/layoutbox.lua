local awful = require("awful")
local wbutton = require("ui.widgets.button")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

return function(s)
  local layoutbox = awful.widget.layoutbox{
    screen = s,
    buttons = {
      awful.button{
        modifiers = {},
        button    = 1,
        on_press  = function() awful.layout.inc(1) end,
      },
      awful.button{
        modifiers = {},
        button    = 3,
        on_press  = function() awful.layout.inc(-1) end,
      },
      awful.button{
        modifiers = {},
        button    = 4,
        on_press  = function() awful.layout.inc(-1) end,
      },
      awful.button{
        modifiers = {},
        button    = 5,
        on_press  = function() awful.layout.inc(1) end,
      },
    }
  }
  local widget = wbutton.elevated.state({
    child = layoutbox,
    normal_bg = beautiful.bg_normal,
    margins = dpi(2),
    paddings = dpi(5),
  })
  return widget
end
