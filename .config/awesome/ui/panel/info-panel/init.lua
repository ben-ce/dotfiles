local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")

--- Information Panel
--- ~~~~~~~~~~~~~~~~~

return function(s)
  --- Date
  local time_format = "<span font='" .. beautiful.font_name .. "Light 36'> %H:%M </span> "
  local date_formate = "<span font='" .. beautiful.font_name .. "Bold 12'> %A %B %d </span>"
  local time = wibox.container.place(wibox.widget.textclock(time_format, 60))
  local date = wibox.container.place(wibox.widget.textclock(date_formate, 60))

  local date_time = wibox.widget({
    {
      time,
      date,
      layout = wibox.layout.fixed.vertical,
    },
    margins = dpi(20),
    widget = wibox.container.margin,
  })

  --- Calendar
  s.calendar = require("ui.panel.info-panel.calendar")()

  --- Weather
  s.weather = require("ui.panel.info-panel.weather")

  s.info_panel = awful.popup({
    type = "normal",
    screen = s,
    minimum_width = dpi(350),
    maximum_width = dpi(350),
    border_width = dpi(5),
    border_color = beautiful.bg_focus,
    -- bg = beautiful.bg_normal,
    ontop = true,
    visible = false,
    placement = function(w)
      awful.placement.top(w, {
        margins = { top = beautiful.wibar_height + dpi(5), left = dpi(5), right = dpi(5) },
      })
    end,
    widget = {
      {
        {
          date_time,
          {
            {
              s.calendar,
              margins = { top = dpi(8), left = dpi(16), bottom = dpi(16), right = dpi(16) },
              widget = wibox.container.margin,
            },
            bg = beautiful.widget_bg,
            shape = helpers.ui.rrect(beautiful.border_radius),
            widget = wibox.container.background,
          },
          {
            top = dpi(20),
            widget = wibox.container.margin,
          },
          {
            {
              s.weather,
              margins = dpi(16),
              widget = wibox.container.margin,
            },
            bg = beautiful.widget_bg,
            shape = helpers.ui.rrect(beautiful.border_radius),
            widget = wibox.container.background,
          },
          {
            top = dpi(20),
            widget = wibox.container.margin,
          },
          layout = wibox.layout.fixed.vertical,
        },
        top = dpi(10),
        bottom = dpi(30),
        left = dpi(25),
        right = dpi(25),
        widget = wibox.container.margin,
      },
      -- bg = beautiful.bg_normal,
      widget = wibox.container.background,
    },
  })

  --- Toggle container visibility
  awesome.connect_signal("info_panel::toggle", function(scr)
    if scr == s then
      s.info_panel.visible = not s.info_panel.visible
    end
  end)
  helpers.click_to_hide.popup(s.info_panel, nil, true)
end
