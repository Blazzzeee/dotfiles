#!/bin/bash
BAT=$(acpi -b | grep -P -o '[0-9]+(?=%)')
STATUS=$(acpi -b | grep -P -o 'Charging|Discharging|Full')

status=""
if [ "$STATUS" == "Charging" ]; then
    status="󱐋"
    fi

if [ "$BAT" -ge 90 ]; then
    ICON=""
elif [ "$BAT" -ge 70 ]; then
    ICON=""
elif [ "$BAT" -ge 50 ]; then
    ICON=""
elif [ "$BAT" -ge 30 ]; then
    ICON=""
else
    ICON=""
fi

echo " $status$ICON $BAT%"
