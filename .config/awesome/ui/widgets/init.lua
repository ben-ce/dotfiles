local _M = {}

local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

_M.button     = require("ui.widgets.button")
_M.text       = require("ui.widgets.text")
_M.launcher   = require("ui.widgets.launcher")
_M.taglist    = require("ui.widgets.tag")
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

_M.keyboardlayout = awful.widget.keyboardlayout()

function _M.create_keyboardlayout()
  return _M.button.elevated.state({
    child = _M.keyboardlayout,
    normal_bg = beautiful.bg_normal,
  })
end

function _M.create_promptbox() return awful.widget.prompt() end

function _M.create_layoutbox(s)
  return awful.widget.layoutbox{
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
        s.promptbox,
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
        s.volume,
        s.brightness,
        s.battery,
        s.layoutbox,
      }
    }
  }
end

return _M
