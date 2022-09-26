local _M = {}

local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")
local wibox = require("wibox")
local apps = require("config.apps")

_M.button     = require("widgets.button")
_M.text       = require("widgets.text")
_M.taglist    = require("widgets.tag")
_M.tasklist   = require("widgets.task")
_M.clock      = require("widgets.clock")
_M.systray    = require("widgets.systray")
_M.volume     = require("widgets.pipewire")
_M.battery    = require("widgets.battery")
_M.brightness = require("widgets.brightness"){
  type = "icon_and_text",
  program = "light",
  percentage = true,
}

_M.awesomemenu = {
  {'hotkeys', function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
  {'manual', apps.manual_cmd},
  {'edit config', apps.editor_cmd .. ' ' .. awesome.conffile},
  {'restart', awesome.restart},
  {'quit', function() awesome.quit() end},
}

_M.mainmenu = awful.menu{
  items = {
    {'awesome', _M.awesomemenu, beautiful.awesome_icon},
    {'open terminal', apps.terminal}
  }
}

_M.launcher = awful.widget.launcher{
  image = beautiful.menu_icon,
  menu = _M.mainmenu
}

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
        _M.launcher,
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
        s.volume,
        s.brightness,
        s.battery,
        s.layoutbox,
      }
    }
  }
end

return _M
