local wibox = require("wibox")
local awful = require("awful")
local colors = require("ui.colors")

local font = "JetBrainsMono Nerd Font 16"

local battery_widget = wibox.widget {
    widget = wibox.widget.textbox,
    align = "center",
    valign = "center",
    font = font,
    fg=colors.nord4,
}

awful.widget.watch(
    "/home/eliot/.config/awesome/ui/bar/battery.sh",
    60,
    function(widget, stdout)
        local color = colors.nord4 or "#FFFFFF" 
        widget.markup = string.format(
            "<span foreground='%s'>%s</span>",
            color,
            stdout:gsub("\n", "")
        )
    end,
    battery_widget
)

return battery_widget
