local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local colors = require("ui.colors")

local wifi_widget = wibox.widget {

    font         = "DaddyTimeMono NF 16",
    forced_width = 27,
    widget       = wibox.widget.textbox,
    align        = "center",
    valign       = "center"
}

local styled = wibox.widget {
    {
        wifi_widget,
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
        awful.spawn("/home/eliot/.config/scripts/nm_ui")
    end)
))

local function update_wifi()
    awful.spawn.easy_async_with_shell(
        "nmcli -t -f DEVICE,TYPE,STATE dev",
        function(stdout)
            local state = "disconnected"
            for line in stdout:gmatch("[^\r\n]+") do
                local dev, type, conn_state = line:match("([^:]+):([^:]+):([^:]+)")
                if type == "wifi" then
                    state = conn_state
                    break
                end
            end

            local icon
            if state == "connected" then
                icon = "󰤥"
            else
                icon = "󰤮"
            end

            wifi_widget.markup = icon
        end
    )
end

-- Initial call and timer
update_wifi()
gears.timer {
    timeout = 10,
    autostart = true,
    callback = update_wifi
}

return styled
