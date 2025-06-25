local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local colors = require("ui.colors.init")

local M = {}

local theme_path = gears.filesystem.get_themes_dir() .. "default/layouts/"

local layout_list = {}
local layout_order = {}

-- Dynamically get layouts from awful.layout.layouts
for _, layout in ipairs(awful.layout.layouts) do
    local name = layout.name
    if name then
        layout_list[name] = theme_path .. name .. "w.png"
        table.insert(layout_order, name)
    end
end

local icon_widgets = {}

local max_per_row = 5
local rows = {}
local current_row = wibox.layout.fixed.horizontal()
local count = 0

for _, name in ipairs(layout_order) do
    local icon_path = layout_list[name]
    local icon_widget = wibox.widget {
        widget = wibox.widget.imagebox,
        image = gears.surface.load_uncached(icon_path),
        forced_height = 48,
        forced_width = 48,
        resize = true,
    }
    icon_widgets[name] = icon_widget

    current_row:add(wibox.container.margin(icon_widget, 8, 8, 8, 8))
    count = count + 1

    if count % max_per_row == 0 then
        table.insert(rows, current_row)
        current_row = wibox.layout.fixed.horizontal()
    end
end

if count % max_per_row ~= 0 then
    table.insert(rows, current_row)
end

local layout_panel_widget = wibox.layout.fixed.vertical()
for _, row in ipairs(rows) do
    layout_panel_widget:add(row)
end

local layout_panel = awful.popup {
    widget = {
        layout_panel_widget,
        margins = 16,
        widget = wibox.container.margin,
    },
    border_color = colors.nord3,
    border_width = 2,
    placement = awful.placement.centered,
    shape = gears.shape.rounded_rect,
    ontop = true,
    visible = false,
    bg = colors.nord0,
}

function M.update_layout_highlight()
    local current = awful.layout.get(mouse.screen).name
    for name, widget in pairs(icon_widgets) do
        if name == current then
            widget.opacity = 1.0
            widget.forced_height = 64
            widget.forced_width = 64
        else
            widget.opacity = 0.4
            widget.forced_height = 48
            widget.forced_width = 48
        end
    end
end

local hide_timer = nil

function M.show()
    M.update_layout_highlight()
    layout_panel.visible = true

    if hide_timer then
        hide_timer:stop()
    end

    hide_timer = gears.timer.start_new(0.7, function()
        layout_panel.visible = false
        hide_timer = nil
        return false
    end)
end

tag.connect_signal("property::layout", function()
    M.update_layout_highlight()
end)

return M
