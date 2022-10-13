local awful = require 'awful'
local gears = require 'gears'

local cmd = [[vmstat 1 2 | tail -1 | awk '{printf "%d", $15}']]

gears.timer {
  timeout = 5,
  call_now = true,
  autostart = true,
  callback = function ()
    awful.spawn.easy_async_with_shell(cmd, function (stdout)
      local cpu_idle = stdout
      cpu_idle = cpu_idle:gsub("^%s*(.-)%s*$", "%1")
      local cpu_value = 100 - tonumber(cpu_idle)
      awesome.emit_signal('cpu::percent', cpu_value)
      collectgarbage("collect")
    end)
  end
}
