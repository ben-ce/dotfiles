-- volume signal
-- credits to Javacafe01

local awful = require("awful")

local volume_old = -1
local muted_old = -1
local mic_muted_old = -1
local function emit_volume_info()
	-- Get volume info of the currently active sink
	local get_volume_cmd = "pactl get-sink-volume @DEFAULT_SINK@ && pactl get-sink-mute @DEFAULT_SINK@"
	awful.spawn.easy_async_with_shell(get_volume_cmd, function(stdout, stderr)
		local vol_left, vol_right = string.match(stdout, "/ *(%S+)")
		local is_mute = string.match(stdout, "Mute: yes") or nil
		local vol_value = vol_left:gsub("%%", "")
		local volume_int = tonumber(vol_value)
		local muted_int = is_mute and 1 or 0
		-- Only send signal if there was a change
		-- We need this since we use `pactl subscribe` to detect
		-- volume events. These are not only triggered when the
		-- user adjusts the volume through a keybind, but also
		-- through `pavucontrol` or even without user intervention,
		-- when a media file starts playing.
		if volume_int ~= volume_old or muted_int ~= muted_old then
			awesome.emit_signal("signals::volume", volume_int, is_mute, awful.screen.focused({}))
			volume_old = volume_int
			muted_old = muted_int
		end
	end)
end

local function emit_mic_info()
	local get_mic_status_cmd = "pactl get-source-mute @DEFAULT_SOURCE@"
	awful.spawn.easy_async_with_shell(get_mic_status_cmd, function(stdout, stderr)
		local mic_is_mute = string.match(stdout, "Mute: yes") or nil
		local mic_muted_int = mic_is_mute and 1 or 0
		if mic_muted_int ~= mic_muted_old then
			awesome.emit_signal("signals::microphone", mic_is_mute, awful.screen.focused({}))
			mic_muted_old = mic_muted_int
		end
	end)
end

-- Run once to initialize widgets
emit_volume_info()
emit_mic_info()

-- Sleeps until pactl detects an event (volume up/down/toggle mute)
local volume_script = [[
    bash -c "
    LANG=C pactl subscribe 2> /dev/null | grep --line-buffered \"Event 'change' on sink #\"
    "]]

-- Kill old pactl subscribe processes
awful.spawn.easy_async({ "pkill", "--full", "--uid", os.getenv("USER"), "^pactl subscribe" }, function()
	-- Run emit_volume_info() with each line printed
	awful.spawn.with_line_callback(volume_script, {
		stdout = function(line)
			emit_volume_info()
			emit_mic_info()
		end,
	})
end)
