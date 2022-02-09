local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- {{{ Menu
-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

local theme = {}

-- {{{ Wibar
-- Create a clock widget
local textclock = wibox.widget.textclock(" %I:%M ")
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local date = wibox.widget.textclock(" %d.%m.%Y")
local clock = wibox.widget.textclock(" %H:%M")

