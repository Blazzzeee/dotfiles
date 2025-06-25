local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local colors = require("ui.colors")

local power_profile_text = wibox.widget {
    align  = "center",
    valign = "center",
    font   = "JetBrains Mono Nerd Font 14",
    widget = wibox.widget.textbox,
}

local profile_map = {
    performance = "REACTOR CRITICAL",
    balanced = "REACTOR MIDLOAD",
    ["power-saver"] = "REACTOR SLEEP",
}

local profiles_cycle = { "performance", "balanced", "power-saver" }

local styled_power_profile -- forward declare

local function update_widget(profile)
    local name = profile_map[profile] or "CRUISE"

    local fg_color_map = {
        performance = colors.nord11,
        balanced = colors.nord9,
        ["power-saver"] = colors.nord7,
    }

    local fg_color = fg_color_map[profile] or colors.nord4

    power_profile_text.markup = string.format(
        "<span foreground='%s'>[ %s ]</span>",
        fg_color, name
    )

    -- Update container fg
    styled_power_profile.fg = fg_color
end

local current_profile_index = 2 -- default to balanced

local function get_current_profile(callback)
    awful.spawn.easy_async_with_shell("powerprofilesctl get", function(stdout)
        local prof = stdout:gsub("%s+", "")
        if not profile_map[prof] then
            prof = "balanced"
        end
        callback(prof)
    end)
end

local function set_profile(prof, callback)
    awful.spawn.easy_async_with_shell("powerprofilesctl set " .. prof, function()
        if callback then callback() end
    end)
end

local function toggle_profile()
    current_profile_index = current_profile_index % #profiles_cycle + 1
    local new_profile = profiles_cycle[current_profile_index]
    set_profile(new_profile, function()
        update_widget(new_profile)
    end)
end

styled_power_profile = wibox.widget {
    {
        power_profile_text,
        left   = 14,
        right  = 14,
        top    = 6,
        bottom = 6,
        widget = wibox.container.margin,
    },
    fg     = colors.nord4,
    shape  = function(cr, w, h) return gears.shape.rounded_rect(cr, w, h, 10) end,
    widget = wibox.container.background,
}

-- Initial fetch and update
get_current_profile(function(profile)
    for i, v in ipairs(profiles_cycle) do
        if v == profile then
            current_profile_index = i
            break
        end
    end
    update_widget(profile)
end)

styled_power_profile:buttons(gears.table.join(
    awful.button({}, 1, nil, function()
        toggle_profile()
    end)
))

return styled_power_profile
