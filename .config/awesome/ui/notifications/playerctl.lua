local beautiful = require("beautiful")
local naughty = require("naughty")
local playerctl = require("modules.bling").signal.playerctl.lib({
  ignore = "firefox",
})

-- buttons
local prev_button = naughty.action {name = "previous"}
local next_button = naughty.action {name = "next"}

-- actual buttons
prev_button:connect_signal('invoked', function()
    playerctl:previous()
end)

next_button:connect_signal('invoked', function()
    playerctl:next()
end)

playerctl:connect_signal("metadata", function (_, title, artist, album_path, album, new, player_name)
  if album_path == "" then
    album_path = beautiful.music
  end
  if new then
    naughty.notification{
      app_name = player_name,
      title    = title,
      message     = artist,
      actions = {
        prev_button,
        next_button,
      },
      image = album_path,
    }
  end
end)
