local wibox = require("wibox")
local beautiful = require("beautiful")
-- local helpers = require("helpers")
local wbutton = require("ui.widgets.button")
local gfs = require("gears.filesystem")

--- Clock Widget
--- ~~~~~~~~~~~~

local ICON_DIR = gfs.get_configuration_dir() .. "icons/"

return function(s)
  local accent_color = beautiful.fg_normal
  local path_to_icon = ICON_DIR .. 'sideBar-controlCentre-white.svg'
  local control = wibox.widget({
    widget = wibox.widget.imagebox,
    image = path_to_icon,
    resize = true,
    auto_dpi = true,
    stylesheet = "#surface1 path { fill: " .. beautiful.fg_normal .. " }"
  })

  -- clock.markup = helpers.ui.colorize_text(clock.text, accent_color)
  -- clock:connect_signal("widget::redraw_needed", function()
  --   clock.markup = helpers.ui.colorize_text(clock.text, accent_color)
  -- end)

  local widget = wbutton.elevated.state({
    child = control,
    normal_bg = beautiful.bg_normal,
    on_release = function()
      awesome.emit_signal("control_panel::toggle", s)
    end,
  })

  return widget
end
