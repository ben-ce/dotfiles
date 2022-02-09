local awful = require("awful")

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag({ " ", " ", " ", " ", " ", " ", " ", " ", " "}, s, awful.layout.layouts[1])
end)
