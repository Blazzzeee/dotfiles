local awful = require("awful")
local wibox = require("wibox")
local colors = require("ui.colors")

local taglist = {}

taglist.create = function(s, modkey)
    return awful.widget.taglist {
        screen          = s,
        filter          = function(t)
            return t.index <= 7
        end,
        buttons         = {
            awful.button({}, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),
            awful.button({}, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end),
            awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
        },
        widget_template = {
            {
                {
                    id     = "icon_text",
                    widget = wibox.widget.textbox,
                },
                margins = 6,
                widget  = wibox.container.margin,
            },
            id              = "background_role",
            widget          = wibox.container.background,

            create_callback = function(self, t, index, tags)
                local text_widget = self:get_children_by_id("icon_text")[1]
                text_widget.font = "JetBrainsMono Nerd Font 10"

                local icons = {
                    [1] = "[   ]",
                    [2] = "   ",
                    [3] = "  ",
                    [4] = "  ",
                    [5] = "  ",
                    [6] = "  ",
                    [7] = "  ",
                }

                local icon = icons[index] or "" -- No fallback, empty for tags > 6
                text_widget.markup = "<span foreground='" .. colors.nord4 .. "'>" .. icon .. "</span>"

                self.bg = t.selected and colors.nord10 or colors.nord0

                self:connect_signal("mouse::enter", function()
                    if not t.selected then
                        self.bg = colors.nord2
                    end
                end)
                self:connect_signal("mouse::leave", function()
                    if not t.selected then
                        self.bg = colors.nord0
                    end
                end)
            end,

            update_callback = function(self, t, index, tags)
                local text_widget = self:get_children_by_id("icon_text")[1]
                text_widget.font = "JetBrainsMono Nerd Font 10"

                local icons = {
                    [1] = "  ",
                    [2] = "   ",
                    [3] = "  ",
                    [4] = "  ",
                    [5] = "  ",
                    [6] = "  ",
                    [7] = "  ",
                }

                local icon = icons[index] or ""
                if t.selected then
                    icon = "[" .. icon .. "]" -- Wrap icon in square brackets
                end
                text_widget.markup = "<span foreground='" ..
                    (t.selected and colors.nord6 or colors.nord4) .. "'>" .. icon .. "</span>"
                self.bg = t.selected and colors.nord10 or colors.nord0
            end
        }
    }
end

return taglist
