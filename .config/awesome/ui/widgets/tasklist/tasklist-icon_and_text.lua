--  _____         _    _ _     _   
-- |_   _|_ _ ___| | _| (_)___| |_ 
--   | |/ _` / __| |/ / | / __| __|
--   | | (_| \__ \   <| | \__ \ |_ 
--   |_|\__,_|___/_|\_\_|_|___/\__|
--                                 

local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local gears = require'gears'

return function(s)
  local widget_spacing = dpi(0)
  local task_width = dpi(192)
  local task = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    style = {
      shape = gears.shape.rounded_rect,
      bg_focus = beautiful.bg_focus,
      bg_normal = beautiful.bg_focus .. "4d",
      bg_minimize = beautiful.bg_normal,
      fg_minimize = beautiful.gray
    },
    buttons = {
      awful.button({ }, 1, function(c) c:activate {context = "tasklist", action = "toggle_minimization"} end)
    },
    layout = { spacing = widget_spacing, layout = wibox.layout.flex.horizontal },
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
      {
        {
          {
            {
              awful.widget.clienticon,
              margins = dpi(5),
              widget  = wibox.container.margin,
            },
            { id = "text_role", widget = wibox.widget.textbox, },
            layout = wibox.layout.fixed.horizontal,
          },
          widget = wibox.container.margin
        },
        id = "background_role",
        forced_width = task_width,
        widget = wibox.container.background,
      },
      margins = dpi(3),
      widget = wibox.container.margin,
    },
  }
  return task
end
