local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local colors = require("ui.colors")

local bluetooth_widget = wibox.widget {

    font         = "DaddyTimeMono NF 16",
    forced_width = 27,
    widget       = wibox.widget.textbox,
    align        = "center",
    valign       = "center"
}

local styled = wibox.widget {
    {
        bluetooth_widget,
        left   = 6,
        right  = 6,
        top    = 6,
        bottom = 6,
        widget = wibox.container.margin,

    },
    fg = colors.nord4,
    widget = wibox.container.background,
}

styled:buttons(gears.table.join(
    awful.button({}, 1, function()
        awful.spawn(
        "/home/eliot/.config/scripts/bzmenu -l custom --launcher-command 'rofi -dmenu -theme /home/eliot/.config/rofi/wifi/config.rasi -matching fuzzy'")
    end)
))

local function update_bluetooth()
    awful.spawn.easy_async_with_shell(
        "bluetoothctl show | grep Powered",
        function(stdout)
            local icon
            if stdout:match("yes") then
                icon = "󰂯" -- Bluetooth on
            else
                icon = "󰂲" -- Bluetooth off
            end
            bluetooth_widget.markup = icon
        end
    )
end
-- Initial call and timer
update_bluetooth()
gears.timer {
    timeout = 10,
    autostart = true,
    callback = update_bluetooth
}

return styled
