local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local colors = require("ui.colors")

-- Widget to display current layout
local layout_text = wibox.widget {
    align  = "center",
    valign = "center",
    font   = "JetBrains Mono Nerd Font 13",
    widget = wibox.widget.textbox,
}

local function capitalize_all(str)
    return string.upper(str)
end

-- Function to update the layout display
local function update_layout()
    local layout = awful.layout.get(mouse.screen)
    local name = awful.layout.getname(layout)
    local capitalized_name = capitalize_all(name)
    layout_text.markup = "<span foreground='" .. colors.nord4 .. "'>| [ " .. capitalized_name .. " ]</span>"
end

-- Connect signal to update layout on change
awful.tag.attached_connect_signal(nil, "property::layout", update_layout)

-- Initial update
update_layout()

-- Styled container
local styled_layout = wibox.widget {
    {
        layout_text,
        left   = 8,
        right  = 8,
        top    = 6,
        bottom = 6,
        widget = wibox.container.margin,
    },
    fg     = colors.nord4,
    shape  = function(cr, w, h) return gears.shape.rounded_rect(cr, w, h, 10) end,
    widget = wibox.container.background,
}

return styled_layout
