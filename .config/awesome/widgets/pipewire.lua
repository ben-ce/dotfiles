-------------------------------------------------
-- Speaker Volume Widget for Pipewire-Pulse
-- Also toggles noisetorch
-------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local beautiful = require("beautiful")
local wbutton = require("widgets.button")

local GET_SINK_VOL_CMD = "pactl get-sink-volume @DEFAULT_SINK@"
local GET_SINK_MUTE_CMD = "pactl get-sink-mute @DEFAULT_SINK@"
local GET_SOURCE_VOL_CMD = "pactl get-source-volume @DEFAULT_SOURCE@"
-- local NOISETORCH_CMD = "pactl get-source-volume \'NoiseTorch Microphone\'"

local UPDATE_CMD = string.format("bash -c \"%s && %s\"", GET_SINK_VOL_CMD, GET_SINK_MUTE_CMD)

local widget = {}

local worker = function(user_args)

  local args = user_args or {}

  local icon = args.icon;
  local font = beautiful.font
  local timeout = 2;

  local volume = wibox.widget{
    layout = wibox.layout.fixed.horizontal,
    spacing = 4,
    {
      id = 'icon',
      align = "center",
      valign = "center",
      resize = true,
      font = "Iosevka 24",
      widget = wibox.widget.textbox,
      text = '墳'
    },
    {
      id = "volume",
      font = font,
      widget = wibox.widget.textbox
    },

    update_volume = function(self, volume, is_mute)
      local font_color = beautiful.fg_normal
      local volume_text = string.format("%s", volume);
      if is_mute then
        volume_text = string.format("%s", "mute")
        font_color = beautiful.fg_urgent
      end
      local volume_markup = string.format("<span font='%s' foreground='%s'>%s</span>", font, font_color, volume_text);

      if self.volume:get_markup() ~= volume_markup then
        self.volume:set_markup(volume_markup);
      end
    end
  }

  local update_widget = function(widget, stdout, _, _, _)
    local vol_left, vol_right = string.match(stdout, "/ *(%S+)");
    -- if album ~= nil and title ~= nil and artist ~= nil then
    local is_mute = string.match(stdout, "Mute: yes") or nil
    widget:update_volume(vol_left, is_mute);
    -- end;
  end;

  watch(UPDATE_CMD, timeout, update_widget, volume);

  --- Adds mouse controls to the widget:
  --  - left click - pavucontrol
  --  - scroll up - volume up
  --  - scroll down - volume down
  --  - right click - start noisetorch
  volume:connect_signal("button::press", function(_, _, _, button)
    if button == 3 then
      awful.spawn("pavucontrol");
      return
      -- using amixer instead of pactl to limit volume to 100%
    elseif button == 4 then
      awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%", false);
      -- awful.spawn("amixer set Master 5%+", false);
    elseif button == 5 then
      awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%", false);
      -- awful.spawn("amixer set Master 5%-", false);
    elseif button == 1 then
      awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle", false);
    end;
    awful.spawn.easy_async(UPDATE_CMD, function(stdout, stderr, _, _) update_widget(volume, stdout, stderr) end)
  end
  );

  widget = wbutton.elevated.state({
    child = volume,
    normal_bg = beautiful.bg_normal,
  })

  return widget
end;

return setmetatable(widget, {	__call = function(_, ...)
  return worker(...);
end
});
