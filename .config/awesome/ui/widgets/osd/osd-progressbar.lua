local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local rubato = require("modules.rubato")
local helpers = require("helpers")

-- ~~~~~~~~~~~
-- uses rubato for smooth animations

-- widgets themselves
-- ~~~~~~~~~~~~~~~~~~
local circle_animate = wibox.widget{
  widget = wibox.container.background,
  shape = helpers.ui.rrect(beautiful.border_radius),
  bg = beautiful.accent,
  forced_width = 0,
  forced_height = 0,
}

-- progress bar widget
local progressbar = wibox.widget {
  nil,
  {
    id = 'bar',
    forced_height = dpi(20),
    bar_shape = gears.shape.rounded_bar,
    shape = gears.shape.rounded_bar,
    background_color = beautiful.bg_normal .. 77,
    color = beautiful.fg_normal,
    value = 25,
    max_value = 100,
    widget = wibox.widget.progressbar
  },
  nil,
  expand = 'none',
  layout = wibox.layout.align.vertical
}

-- icon widget
local textIcon = wibox.widget {
  {
    id = 'icon',
    font = "Font Awesome 6 Free 54",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox,
  },
  forced_height = dpi(165),
  forced_width = dpi(165),
  top = dpi(14),
  widget = wibox.container.margin
}

-- actual popup
return function(s)
  s.pop = awful.popup{
    widget  = {},
    type = 'notification',
    height  = dpi(190),
    width   = dpi(190),
    maximum_height = dpi(190),
    maximum_width = dpi(190),
    preferred_anchors = 'middle',
    preferred_positions = {'left', 'right', 'top', 'bottom'},
    shape   = helpers.ui.rrect(beautiful.border_radius),
    bg      = beautiful.bg_focus .. 77,
    ontop   = true,
    visible = false,
    screen = s,
    placement = function(w)
      awful.placement.centered(w)
    end
  }
  s.pop:setup{
    {
      layout = wibox.layout.fixed.vertical
        {
          {
            textIcon,
            layout = wibox.layout.fixed.vertical
          },
          {
            progressbar,
            layout = wibox.layout.fixed.vertical
          },
          layout = wibox.layout.fixed.vertical
        },
    },
    left = dpi(14),
    right = dpi(14),
    bottom = dpi(14),
    widget = wibox.container.margin
  }

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
      textIcon.icon.markup = vol_muted
    else
      if value <= 0 then
        textIcon.icon.markup = vol_off
      elseif value < 25 then
        textIcon.icon.markup = vol_low
      elseif value < 45 then
        textIcon.icon.markup = vol_mid
      else
        textIcon.icon.markup = vol_high
      end
    end

    progressbar.bar.value = value
    progressbar.bar.visible = true

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
    textIcon.icon.markup = bri_icon
    progressbar.bar.value = value
    progressbar.bar.visible = true
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
      textIcon.icon.markup = mic_muted
    else
      textIcon.icon.markup = mic_icon
    end
    progressbar.bar.value = nil
    progressbar.bar.visible = false
    if mic_popup_isActived then
      mic_popup_isActived = false
    else
      if scr == s then
        toggle_pop(scr)
      end
    end
  end)
end
