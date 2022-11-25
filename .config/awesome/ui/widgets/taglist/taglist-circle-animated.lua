local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local rubato = require("modules.rubato")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- local circle = function(cr, width, height)
-- gears.shape.transform(gears.shape.circle) : scale(1, 1)(cr, 20, 20)
-- end

return function(s)
  return wibox.widget({
    {
      {
        nil,
        {
          awful.widget.taglist{
            screen = s,
            filter = awful.widget.taglist.filter.all,
            style = {
              shape = gears.shape.circle,
              bg_empty = beautiful.taglist_fg_empty,
              bg_focus = beautiful.taglist_fg_focus,
              bg_urgent = beautiful.taglist_fg_urgent,
              bg_occupied = beautiful.taglist_fg_occupied,
            },
            layout = {
              spacing = 14,
              layout = wibox.layout.fixed.horizontal,
            },
            buttons = {
              awful.button({}, 1, function (t)
                t:view_only()
              end),
              awful.button({}, 4, function (t)
                awful.tag.viewprev(t.screen)
              end),
              awful.button({}, 5, function (t)
                awful.tag.viewnext(t.screen)
              end)
            },
            widget_template = {
              id = 'background_role',
              widget = wibox.container.background,
              create_callback = function (self, tag)
                self.animate = rubato.timed {
                  intro = 0.075,
                  duration = 0.2,
                  easing = rubato.linear,
                  subscribed = function (h)
                    self:get_children_by_id('background_role')[1].forced_width = h
                  end
                }

                self.update = function ()
                  if tag.selected then
                    self.animate.target = 20
                  elseif #tag:clients() > 0 then
                    self.animate.target = 14
                  else
                    self.animate.target = 10
                  end
                end

                self.update()
              end,
              update_callback = function (self)
                self.update()
              end,
            }
          },
          left = dpi(10),
          right = dpi(10),
          widget = wibox.container.margin,
        },
        nil,
        layout = wibox.layout.align.horizontal,
        expand = 'none',
      },
      bg = beautiful.widget_bg,
      shape = gears.shape.rounded_rect,
      shape_clip = true,
      forced_width = 5 * 18 + 80,
      widget = wibox.container.background,
    },
    margins = dpi(2),
    widget = wibox.container.margin,
  })
end


