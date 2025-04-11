local battery_widget = require("plugins.battery")
local wibox = require("wibox")
local colors = require("ui.colors")

local color = colors.white

local icon_widget = wibox.widget {
    markup = "",
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local percent_widget = wibox.widget {
    markup = "",
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local battery_template = wibox.widget {
    icon_widget,
    percent_widget,
    spacing = 6,
    layout = wibox.layout.fixed.horizontal
}

local my_battery_widget = battery_widget {
    screen = screen,
    use_display_device = true,
    widget_template = battery_template,
    instant_update = true
}

my_battery_widget:connect_signal("upower::update", function(widget, device)
    local percentage = device.percentage or 0
    local icon = ""
    -- TODO charging state
    local charging = false

    if charging then
        if percentage >= 90 then
            icon = " " -- Charging full
        elseif percentage >= 70 then
            icon = " " -- Charging more than 70%
        elseif percentage >= 50 then
            icon = " "
        elseif percentage >= 30 then
            icon = " "
        elseif percentage >= 10 then
            icon = " "
        else
            icon = " " -- Critical charging
        end
    else
        -- Battery Icons without charging
        if percentage >= 90 then
            icon = ""
        elseif percentage >= 70 then
            icon = ""
        elseif percentage >= 50 then
            icon = ""
        elseif percentage >= 25 then
            icon = ""
        elseif percentage >= 10 then
            icon = ""
        else
            icon = "" -- Critical
        end
    end

    -- Update the widgets' markup
    icon_widget.markup = string.format(
        "<span font='DaddyTimeMono NF 30' foreground='%s'>%s</span>",
        color, icon
    )

    percent_widget.markup = string.format(
        "<span font='DaddyTimeMono NF 14' foreground='%s'>%d%%</span>",
        color, percentage
    )
end)

return my_battery_widget
