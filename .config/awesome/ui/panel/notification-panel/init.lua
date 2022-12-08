local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")
local gears = require("gears")
local rubato = require("modules.rubato")

--- Notification Panel
--- ~~~~~~~~~~~~~~~~~~
local notif_header = wibox.widget {
  markup = helpers.ui.colorize_text('Notifications', beautiful.fg_normal),
  font = beautiful.font_name .. "Bold 14",
  align = 'center',
  valign = 'center',
  widget = wibox.widget.textbox
}

return function(s)
  s.notification_panel = awful.popup({
    type = "normal",
    screen = s,
    border_width = dpi(5),
    border_color = beautiful.bg_focus,
    -- minimum_height = s.geometry.height - (beautiful.wibar_height + beautiful.useless_gap * 4 + dpi(50) + dpi(4) + dpi(5) * 2),
    minimum_height = dpi(700),
    maximum_height = dpi(700),
    -- maximum_height = s.geometry.height - (beautiful.wibar_height + beautiful.useless_gap * 4 + dpi(50) + dpi(4) + dpi(5) * 2),
    minimum_width = dpi(350),
    maximum_width = dpi(350),
    bg = beautiful.transparent,
    ontop = true,
    visible = false,
    placement = function(w)
      awful.placement.top_right(w, {
        margins = { top = beautiful.wibar_height + dpi(beautiful.useless_gap * 2),bottom =  dpi(5), left = dpi(5), right = dpi(beautiful.useless_gap * 2) },
      })
    end,
    widget = {
      {
        -- { ----------- TOP GROUP -----------
        -- helpers.ui.vertical_pad(dpi(30)),
        {
          nil,
          {
            notif_header,
            margins = dpi(20),
            widget = wibox.container.margin,
          },
          {
            require("ui.panel.notification-panel.notif-center.clear-all"),
            margins = dpi(20),
            widget = wibox.container.margin,
          },
          expand = 'none',
          layout = wibox.layout.align.horizontal,
        },
        {
          require("ui.panel.notification-panel.notif-center")(s),
          margins = dpi(20),
          widget = wibox.container.margin,
        },
        layout = wibox.layout.fixed.vertical,
        -- },
        -- { ----------- MIDDLE GROUP -----------
        --   {
        --     {
        --       require("ui.panel.notification-panel.github-activity"),
        --       margins = dpi(20),
        --       widget = wibox.container.margin,
        --     },
        --     helpers.ui.vertical_pad(dpi(30)),
        --     layout = wibox.layout.fixed.vertical,
        --   },
        --   shape = helpers.ui.prrect(beautiful.border_radius * 2, true, false, false, false),
        --   bg = beautiful.widget_bg,
        --   widget = wibox.container.background,
        -- },
        -- layout = wibox.layout.flex.vertical,
      },
      -- shape = helpers.ui.prrect(beautiful.border_radius * 2, true, false, false, false),
      bg = beautiful.wibar_bg,
      widget = wibox.container.background,
    },
  })

  -- sliding animation
  local slide = rubato.timed {
    pos = s.geometry.y - s.geometry.height,
    rate = 60,
    intro = 0.2,
    duration = 0.4,
    subscribed = function(pos)
      s.notification_panel.y = pos
    end
  }

  local slide_end = gears.timer({
    single_shot = true,
    timeout = 0.4 + 0.08,
    callback = function()
      s.notification_panel.visible = false
    end,
  })
  -- Toggle function
  local screen_backup = 1

  s.notification_panel.toggle = function(screen)
    -- set screen to default, if none were found
    if not screen then
      screen = s
    end

    -- popup x position is in the hands of the screen and placement function
    -- toggle visibility
    if s.notification_panel.visible then
      -- check if screen is different or the same
      if screen_backup ~= screen.index then
        s.notification_panel.visible = true
      else
        slide_end:again()
        slide.target = s.geometry.y - s.geometry.height
      end
    elseif not s.notification_panel.visible then
      slide.target = s.geometry.y + (beautiful.wibar_height + beautiful.useless_gap * 2)
      s.notification_panel.visible = true
    end

    -- set screen_backup to new screen
    screen_backup = screen.index
  end

  --- Toggle container visibility
  awesome.connect_signal("notification_panel::toggle", function(scr)
    if scr == s then
      s.notification_panel.toggle(scr)
      -- s.notification_panel.visible = not s.notification_panel.visible
    end
  end)
  helpers.click_to_hide.popup(s.notification_panel, nil, true, s, 'notification_panel')
end
