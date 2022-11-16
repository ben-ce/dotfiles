local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local wbutton = require("ui.widgets.button")

--- Clock Widget
--- ~~~~~~~~~~~~

return function(s)
  local accent_color = beautiful.accent
  local clock = wibox.widget({
    widget = wibox.widget.textclock,
    format = " %Y %b %d  %H:%M",
    align = "center",
    valign = "center",
    font = beautiful.font_name .. "Medium 12",
  })

  clock.markup = helpers.ui.colorize_text(clock.text, accent_color)
  clock:connect_signal("widget::redraw_needed", function()
    clock.markup = helpers.ui.colorize_text(clock.text, accent_color)
  end)

  local widget = wbutton.elevated.state({
    child = clock,
    normal_bg = beautiful.bg_normal,
    on_release = function()
      awesome.emit_signal("info_panel::toggle", s)
    end,
    margins = dpi(2),
  })

  return widget
end
