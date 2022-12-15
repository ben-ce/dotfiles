local awful         = require("awful")
local gears         = require("gears")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local rubato		= require("modules.rubato")
local helpers       = require("helpers")

-- widgets themselves
-- ~~~~~~~~~~~~~~~~~~
local circle_animate = wibox.widget{
  widget = wibox.container.background,
  shape = helpers.ui.rrect(beautiful.border_radius),
  bg = beautiful.accent,
  forced_width = 0,
  forced_height = 0,
}

-- arc chart widget
local volume_arc = wibox.widget {
  max_value = 100,
  thickness = dpi(10),
  start_angle = 3 * math.pi / 2,
  rounded_edge = true,
  bg = beautiful.bg_normal,
  paddings = dpi(10),
  colors = {beautiful.blue},
  widget = wibox.container.arcchart
}

-- progress_bar
local textIcon = wibox.widget {
  font = "Font Awesome 6 Free " .. "36",
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox,
}

-- actual popup
return function(s)
  s.pop = awful.popup{
    widget  = {},
    type = 'notification',
    height  = dpi(160),
    width   = dpi(160),
    maximum_height = dpi(160),
    maximum_width = dpi(160),
    preferred_anchors = 'middle',
    preferred_positions = {'left', 'right', 'top', 'bottom'},
    shape   = helpers.ui.rrect(beautiful.border_radius),
    bg      = beautiful.bg_widget,
    ontop   = true,
    visible = false,
    screen = s,
    placement = awful.placement.centered,
  }

  -- placement
  -- awful.placement.centered(pop, {margins = {center = beautiful.useless_gap * 2}})

  -- timeout
  local timeout = gears.timer({
    autostart   = true,
    timeout     = 2.5,
    callback    = function()
      s.pop.visible = false
    end,
    single_shot = true,
  })

  local screen_backup = 1
  local function toggle_pop(screen)
    -- set screen to default, if none were found
    if not screen then
      screen = s
    end

    -- toggle visibility
    if s.pop.visible then
      -- check if screen is different or the same
      if screen_backup ~= screen.index then
        s.pop.visible = true
      else
        timeout:again()
      end
    else
      s.pop.visible = true
      timeout:start()
    end

    -- set screen_backup to new screen
    screen_backup = screen.index
  end

  local volumebar = wibox.widget {
    {
      {
        {
          textIcon,
          widget = wibox.container.margin
        },
        volume_arc,
        layout = wibox.layout.stack
      },
      left = dpi(23),
      bottom = dpi(23),
      right = dpi(23),
      top = dpi(23),
      widget = wibox.container.margin
    },
    layout = wibox.layout.fixed.vertical
  }

  s.pop:setup({
    {
      volumebar,
      margins = dpi(7),
      widget = wibox.container.margin
    },
    layout = wibox.layout.fixed.vertical,
  })

  local animation = rubato.timed{
    pos = 25,
    rate = 60,
    intro = 0.02,
    duration = 0.08,
    awestore_compat = true,
  }

  local animation_button = rubato.timed{
    pos = 0,
    rate = 60,
    intro = 0.02,
    duration = 0.08,
    awestore_compat = true,
    subscribed = function(pos)
      circle_animate.forced_width = pos
      circle_animate.forced_height = pos
    end
  }

  -- icons
  local vol_default = helpers.ui.colorize_text("", beautiful.fg_normal)
  local vol_high = helpers.ui.colorize_text("", beautiful.fg_normal)
  local vol_mid = helpers.ui.colorize_text("", beautiful.fg_normal)
  local vol_low = helpers.ui.colorize_text("", beautiful.fg_normal)
  local vol_off = helpers.ui.colorize_text("",beautiful.fg_normal)
  local vol_muted = helpers.ui.colorize_text( "", beautiful.red)
  local bri_icon = helpers.ui.colorize_text("", beautiful.fg_normal)
  local mic_icon = helpers.ui.colorize_text("", beautiful.fg_normal)
  local mic_muted = helpers.ui.colorize_text("", beautiful.red)

  -- volume signal
  local volume_popup_isActived = true
  awesome.connect_signal("signals::volume", function(value, muted, scr)
    if muted then
      textIcon.markup = vol_muted
    else
      if value <= 0 then
        textIcon.markup = vol_off
      elseif value < 25 then
        textIcon.markup = vol_low
      elseif value < 45 then
        textIcon.markup = vol_mid
      else
        textIcon.markup = vol_high
      end
    end

    volume_arc.value = value

    if volume_popup_isActived then
      volume_popup_isActived = false
    else
      if scr == s then
        toggle_pop(scr)
      end
    end
  end)

  -- brightness signal
  local brightness_popup_isActived = true
  awesome.connect_signal("signals::brightness", function(value, scr)
    textIcon.markup = bri_icon
    volume_arc.value = value

    if brightness_popup_isActived then
      brightness_popup_isActived = false
    else
      if scr == s then
        toggle_pop(scr)
      end
    end
  end)

  -- microphone signal
  local mic_popup_isActived = true
  awesome.connect_signal("signals::microphone", function(muted, scr)
    if muted then
      textIcon.markup = mic_muted
    else
      textIcon.markup = mic_icon
    end

    volume_arc.value = nil

    if mic_popup_isActived then
      mic_popup_isActived = false
    else
      if scr == s then
        toggle_pop(scr)
      end
    end
  end)
end
