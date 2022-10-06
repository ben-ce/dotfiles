 --  __  __
 -- |  \/  | ___ _ __  _   _
 -- | |\/| |/ _ \ '_ \| | | |
 -- | |  | |  __/ | | | |_| |
 -- |_|  |_|\___|_| |_|\__,_|

local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local apps = require("config.apps")
local dpi = beautiful.xresources.apply_dpi
local wbutton = require("ui.widgets.button")

local awesomemenu = {
  {'hotkeys', function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
  {'manual', apps.manual_cmd},
  {'edit config', apps.editor_cmd .. ' ' .. awesome.conffile},
  {'restart', awesome.restart},
  {'quit', function() awesome.quit() end},
}

local mainmenu = awful.menu{
  items = {
    {'awesome', awesomemenu, beautiful.awesome_icon},
    {'open terminal', apps.terminal}
  }
}

local launcher = awful.widget.launcher{
  image = beautiful.menu_icon,
  menu = mainmenu,
}

local widget = wbutton.elevated.state({
  child = launcher,
  paddings = dpi(1),
  margins = dpi(3),
  normal_bg = beautiful.bg_normal,
})

return widget
