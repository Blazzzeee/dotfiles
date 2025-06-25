local upower = require("lgi").require("UPowerGlib")
local gtable = require("gears.table")
local gtimer = require("gears.timer")
local wbase = require("wibox.widget.base")

local setmetatable = setmetatable

local battery_widget = {}
local mt = {}

function battery_widget.list_devices()
    local ret = {}
    local devices = upower.Client():get_devices()
    for _, d in ipairs(devices) do
        table.insert(ret, d:get_object_path())
    end
    return ret
end

function battery_widget.get_device(path)
    local devices = upower.Client():get_devices()
    for _, d in ipairs(devices) do
        if d:get_object_path() == path then
            return d
        end
    end
    return nil
end

function battery_widget.get_BAT0_device_path()
    return "/org/freedesktop/UPower/devices/battery_BAT0"
end

function battery_widget.to_clock(seconds)
    if seconds <= 0 then
        return "00:00"
    else
        local hours = string.format("%02.f", math.floor(seconds / 3600))
        local mins = string.format("%02.f", math.floor(seconds / 60 - hours * 60))
        return hours .. ":" .. mins
    end
end

local function default_template()
    return wbase.empty_widget()
end

function battery_widget.new(args)
    args = gtable.crush({
        widget_template = default_template(),
        device_path = "",
        use_display_device = false,
        instant_update = false,
    }, args or {})

    local widget = wbase.make_widget_from_value(args.widget_template)

    widget.device = args.use_display_device
        and upower.Client():get_display_device()
        or battery_widget.get_device(args.device_path)

    -- Correct signal connection
    widget.device.on_notify = function(d)
        widget:emit_signal("upower::update", d)
    end

    -- Safe delayed update
    if args.instant_update then
        gtimer.delayed_call(function()
            widget:emit_signal("upower::update", widget.device)
        end)
    end

    return widget
end

function mt.__call(_, ...)
    return battery_widget.new(...)
end

return setmetatable(battery_widget, mt)
