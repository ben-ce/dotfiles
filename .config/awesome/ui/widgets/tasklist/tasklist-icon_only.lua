--  _____         _    _ _     _   
-- |_   _|_ _ ___| | _| (_)___| |_ 
--   | |/ _` / __| |/ / | / __| __|
--   | | (_| \__ \   <| | \__ \ |_ 
--   |_|\__,_|___/_|\_\_|_|___/\__|
--                                 

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gears = require("gears")

local function tasklist(s)
  local task = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    style = {
      shape = gears.shape.circle,
      bg_focus = beautiful.gray,
      bg_normal = beautiful.bg_focus .. "4d",
      bg_minimize = beautiful.bg_normal,
      fg_minimize = beautiful.gray
    },
    buttons = {
      awful.button({ }, 1, function(c) c:activate {context = "tasklist", action = "toggle_minimization"} end)
    },
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
      {
        {
            awful.widget.clienticon,
            margins = dpi(5),
            widget  = wibox.container.margin,
        },
        id = "background_role",
        widget = wibox.container.background,
      },
      margins = dpi(3),
      widget = wibox.container.margin,
    },
  }
  return task
end

return function(s)
  return wibox.widget{
    {
      tasklist(s),
      widget = wibox.container.background,
      bg = beautiful.widget_bg,
      shape = gears.shape.rounded_rect,
    },
    margins = dpi(2),
    widget = wibox.container.margin,
  }
end
