local _M = {}

local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")

_M.button     = require("ui.widgets.button")
_M.text       = require("ui.widgets.text")
_M.launcher   = require("ui.widgets.launcher")
_M.taglist    = require("ui.widgets.taglist")
_M.tasklist   = require("ui.widgets.task")
_M.clock      = require("ui.widgets.clock")
_M.systray    = require("ui.widgets.systray")
_M.volume     = require("ui.widgets.pipewire")
_M.battery    = require("ui.widgets.battery")
_M.brightness = require("ui.widgets.brightness"){
  type = "icon_and_text",
  program = "light",
  percentage = true,
}
_M.controlcenter = require("ui.widgets.controlcenter")
_M.layoutbox = require("ui.widgets.layoutbox")
_M.notification_button = require("ui.widgets.notification_button")

_M.keyboardlayout = awful.widget.keyboardlayout()

function _M.create_keyboardlayout()
  return _M.button.elevated.state({
    child = _M.keyboardlayout,
    normal_bg = beautiful.bg_normal,
    margins = dpi(2),
  })
end

function _M.create_wibox(s)
  return awful.wibar{
    screen = s,
    position = 'top',
    widget = {
      layout = wibox.layout.align.horizontal,
      expand = 'none',
      -- left widgets
      {
        layout = wibox.layout.fixed.horizontal,
        s.launcher,
        s.taglist,
        s.tasklist,
      },
      -- middle widgets
      {
        layout = wibox.layout.fixed.horizontal,
        s.clock,
      },
      -- right widgets
      {
        layout = wibox.layout.fixed.horizontal,
        s.kblayout,
        s.systray,
        s.controlcenter,
        s.notification_button,
        s.volume,
        s.brightness,
        s.battery,
        s.layoutbox,
      }
    }
  }
end

return _M
