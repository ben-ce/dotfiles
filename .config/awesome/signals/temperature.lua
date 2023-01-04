local awful = require("awful")
local gears = require("gears")
local helpers = require("helpers")
local fs = gears.filesystem

local temperature = {}

temperature.script_path = fs.get_configuration_dir() .. "scripts/temp.sh"

function temperature._invoke_script(args, cb)
	awful.spawn.easy_async_with_shell(temperature.script_path .. " " .. args, function(out)
		if cb then
			cb(helpers.trim(out))
		end
	end)
end

function temperature.async_get(cb)
	temperature._invoke_script("get", cb)
end

local cmd =
	[[ temp_path=null for i in /sys/class/hwmon/hwmon*/temp*_input; do temp_path="$(echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)");" label="$(echo $temp_path | awk '{print $2}')" if [ "$label" = "Package" ]; then echo ${temp_path} | awk '{print $5}' | tr -d ';\n' exit; fi done ]]

local temp_path = ""
local max_temp = 80

awful.spawn.easy_async_with_shell(cmd, function(stdout)
	temp_path = stdout:gsub("%\n", "")
	if temp_path == "" or not temp_path then
		temp_path = "/sys/class/thermal/thermal_zone0/temp"
	end
end)

gears.timer({
	timeout = 10,
	autostart = true,
	call_now = true,
	callback = function()
		awful.spawn.easy_async_with_shell("cat " .. temp_path, function(stdout)
			local temp = stdout:match("(%d+)")
			local temp_value = (temp / 1000) / max_temp * 100
			awesome.emit_signal("temperature::value", tonumber(temp_value))
		end)
	end,
})

return temperature
