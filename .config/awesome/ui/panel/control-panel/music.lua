-- music widget
-- ~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local wibox = require("wibox")
local rubato = require("modules.rubato")
local playerctl = require("modules.bling").signal.playerctl.lib()


-- widgets
-- ~~~~~~~

-- album art
local album_art = wibox.widget{
  widget = wibox.widget.imagebox,
  clip_shape = helpers.ui.rrect(beautiful.border_radius),
  forced_height = dpi(85),
  forced_width = dpi(85),
  image = beautiful.music,
  valign = "bottom",
  halign = "center",
  resize = true,
}


-- song artist
local song_artist = wibox.widget{
  widget = wibox.widget.textbox,
  markup = helpers.ui.colorize_text("Unknown", beautiful.bg_normal),
  font = beautiful.font_name .. "11",
  align = "left",
  valign = "center"
}

-- song name
local song_name = wibox.widget{
  widget = wibox.widget.textbox,
  markup = helpers.ui.colorize_text("None", beautiful.bg_normal),
  font = beautiful.font_name .. "Bold 12",
  align = "left",
  valign = "center"
}

-- music
local music_display = wibox.widget{
  {
    {
      {
        widget = wibox.widget.textbox,
        markup = helpers.ui.colorize_text("\u{f7ca}", beautiful.bg_normal),
        font = beautiful.alt_font_name .. "12",
        align = "right",
        valign = "center"
      },
      {
        widget = wibox.widget.textbox,
        id = "music_text_role",
        markup = helpers.ui.colorize_text("Music", beautiful.bg_normal),
        font = beautiful.alt_font_name .. "12",
        align = "right",
        valign = "center"
      },
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(10)
    },
    margins = {left = dpi(12), right = dpi(12), top = dpi(6), bottom = dpi(6)},
    widget = wibox.container.margin
  },
  widget = wibox.container.background,
  bg = beautiful.accent,
  shape = gears.shape.rounded_bar
}


-- bg for animation
local animate_pop = wibox.widget{
  bg = beautiful.bg_focus .. "1A",
  widget = wibox.container.background,
  shape = helpers.ui.rrect(beautiful.border_radius),
  opacity = 0,
}

local animation_button_opacity = rubato.timed{
  pos = 0,
  rate = 60,
  intro = 0.08,
  duration = 0.3,
  awestore_compat = true,
  subscribed = function(pos)
    animate_pop.opacity = pos
  end
}

-- the toggler
local function animate()
  if animate_pop.opacity == 0 then
    animation_button_opacity:set(1)
  end
end

-- once animation ended, set it back to 0
animation_button_opacity.ended:subscribe(function()
  animation_button_opacity:set(0)
end)


-- toggle button
local toggle_button = wibox.widget{
  widget = wibox.widget.textbox,
  markup = helpers.ui.colorize_text("", beautiful.fg_normal),
  font = beautiful.alt_font_name .. "22",
  align = "right",
  valign = "center"
}

-- next button
local next_button = wibox.widget{
  widget = wibox.widget.textbox,
  markup = helpers.ui.colorize_text("", beautiful.fg_normal),
  font = beautiful.alt_font_name .. "18",
  align = "right",
  valign = "center"
}

-- prev button
local prev_button = wibox.widget{
  widget = wibox.widget.textbox,
  markup = helpers.ui.colorize_text("", beautiful.fg_normal),
  font = beautiful.alt_font_name .. "18",
  align = "right",
  valign = "center"
}

-- `progressbar`
local progressbar = wibox.widget {
  forced_height = dpi(3),
  forced_width = dpi(220),
  margins = dpi(5),
  bar_shape = helpers.ui.rrect(beautiful.border_radius),
  shape = helpers.ui.rrect(beautiful.border_radius),
  background_color = beautiful.bg_normal .. 55,
  color = beautiful.fg_normal,
  value = 25,
  max_value = 100,
  widget = wibox.widget.progressbar
}

-- update widgets
-- ~~~~~~~~~~~~~~

local toggle_command = function() playerctl:play_pause() end
local prev_command = function() playerctl:previous() end
local next_command = function() playerctl:next() end

toggle_button:buttons(gears.table.join(
  awful.button({}, 1, function() toggle_command() animate() end)))

next_button:buttons(gears.table.join(
  awful.button({}, 1, function() next_command() animate() end)))

prev_button:buttons(gears.table.join(
  awful.button({}, 1, function() prev_command() animate() end)))


playerctl:connect_signal("metadata", function(_, title, artist, album_path, _, __, player_name)
  if title == "" then
    title = "None"
  end
  if artist == "" then
    artist = "Unknown"
  end
  if album_path == "" then
    album_path = beautiful.images.album_art
  end
  if player_name == "" then
    player_name = "None"
  end

  if player_name:match("mpd") then
    music_display:buttons(gears.table.join(
      awful.button({}, 1, function() dash_toggle() awful.spawn(user_likes.music, false) end)
    ))
  elseif player_name ~= "None" then
    music_display:buttons(gears.table.join(
      awful.button({}, 1, function() dash_toggle() awful.spawn(string.lower(player_name), false) end)
    ))
  end

  album_art:set_image(gears.surface.load_uncached(album_path))
  song_name:set_markup_silently(helpers.ui.colorize_text(title, beautiful.fg_normal))
  song_artist:set_markup_silently(helpers.ui.colorize_text(artist, beautiful.fg_normal))
  music_display:get_children_by_id("music_text_role")[1].markup = helpers.ui.colorize_text(player_name, beautiful.bg_normal)


end)

playerctl:connect_signal("position", function(_, current_pos, total_pos, _)
  progressbar.value = (current_pos / total_pos) * 100

end)

playerctl:connect_signal("playback_status", function(_, playing)
  if playing then
    toggle_button.markup = helpers.ui.colorize_text("", beautiful.fg_normal)
  else
    toggle_button.markup = helpers.ui.colorize_text("", beautiful.fg_normal)
  end
end)





local mainbox =  wibox.widget{
  {
    {
      animate_pop,
      {
        {
          {
            album_art,
            {
              nil,
              nil,
              {
                -- {
                  {
                    step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
                    widget = wibox.container.scroll.horizontal,
                    forced_width = dpi(330),
                    speed = 30,
                    song_name,
                  },
                  {
                    step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
                    widget = wibox.container.scroll.horizontal,
                    speed = 30,
                    song_artist,
                  },
                  layout = wibox.layout.fixed.vertical,
                  spacing = dpi(3)
                -- },
                -- widget = wibox.container.margin,
                -- margins = {bottom = dpi(0)}
              },
              layout = wibox.layout.align.vertical,
              expand = "none"
            },
            spacing = dpi(10),
            layout = wibox.layout.fixed.horizontal
          },
          {
            {
              progressbar,
              margins = {top = dpi(5), bottom = dpi(5)},
              widget = wibox.container.margin
            },
            {
              prev_button,
              toggle_button,
              next_button,
              layout = wibox.layout.fixed.horizontal,
              spacing = dpi(6)
            },
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(10)
          },
          layout = wibox.layout.fixed.vertical,
          spacing = dpi(10)
        },
        widget = wibox.container.margin,
        margins = dpi(15)
      },
      {
        nil,
        nil,
        {
          {
            music_display,
            margins = dpi(15),
            widget = wibox.container.margin
          },
          nil,
          {
            margins = {right = dpi(15), bottom = dpi(22)},
            widget = wibox.container.margin
          },
          layout = wibox.layout.align.vertical
        },
        layout = wibox.layout.align.horizontal,
        expand = "none"
      },
      layout = wibox.layout.stack
    },
    widget = wibox.container.background,
    shape = helpers.ui.rrect(beautiful.border_radius),
    forced_height = dpi(210),
    forced_width = dpi(350),
    bg = gears.color({ type = "linear",
      from = { 0, 0 },
      to = { 350, 0 },
      stops = { { 0, beautiful.color3 },
        { 1, beautiful.bg_focus },
      },
    })
  },
  margins = dpi(10),
  widget = wibox.container.margin,
}

return mainbox
