-- name = "Solar Cycle"
-- description = "Shows Sunrise Sunset at your location"
-- data_source = "https://api.sunrise-sunset.org/"
-- type = "widget"
-- author = "Sriram S V, Will Hall"
-- version = "1.0"
-- foldable = "false"

local json = require "json"
local date = require "date"
local md_colors = require "md_colors"

function on_alarm()
    local location=system:location()
    url="https://api.sunrise-sunset.org/json?lat="..location[1].."&lng="..location[2].."&formatted=0"
    http:get(url)
end


function on_network_result(result)
    local t = json.decode(result)

    local times_table = {
        {
            gen_icon("red_900","↦"),
            gen_icon("orange_900", "↗"),
            gen_icon("yellow_900", "☀"),
            gen_icon("orange_900", "↘"),
            gen_icon("red_900", "⇥"),
        },
        {
            time_from_utc(t.results.civil_twilight_begin),
            time_from_utc(t.results.sunrise),
            time_from_utc(t.results.solar_noon),
            time_from_utc(t.results.sunset),
            time_from_utc(t.results.civil_twilight_end),
        }
    }

    ui:show_table(times_table, 0, true)
end

function time_from_utc(utc)
    return date(utc):tolocal():fmt("%H:%M")
end

function gen_icon(md_color, icon)
    return "<font color="..md_colors[md_color].."><b>"..icon.."</b></font>"
end