--  ____            _
-- / ___| _   _ ___| |_ _ __ __ _ _   _
-- \___ \| | | / __| __| '__/ _` | | | |
--  ___) | |_| \__ \ |_| | | (_| | |_| |
-- |____/ \__, |___/\__|_|  \__,_|\__, |
--        |___/                   |___/

local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi
local animation = require("modules.animation")
local wbutton = require("ui.widgets.button")

return function(s)
  local mysystray = wibox.widget.systray()
  mysystray.base_size = beautiful.systray_icon_size

  local widget = wibox.widget({
    widget = wibox.container.constraint,
    strategy = "max",
    width = dpi(0),
    {
      widget = wibox.container.margin,
      margins = dpi(10),
      mysystray,
    },
  })

  local system_tray_animation = animation:new({
    easing = animation.easing.linear,
    duration = 0.125,
    update = function(self, pos)
      widget.width = pos
    end,
  })

  local arrow = wbutton.text.state({
    text_normal_bg = beautiful.accent,
    normal_bg = beautiful.wibar_bg,
    press_bg = beautiful.wibar_bg,
    font = beautiful.icon_font .. "Round ",
    size = 18,
    text = "",
    on_turn_on = function(self)
      system_tray_animation:set(400)
      self:set_text("")
    end,
    on_turn_off = function(self)
      system_tray_animation:set(0)
      self:set_text("")
    end,
    margins = dpi(2),
  })

  return wibox.widget({
    screen = s,
    layout = wibox.layout.fixed.horizontal,
    arrow,
    widget,
  })
end
