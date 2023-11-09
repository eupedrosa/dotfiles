#!/usr/bin/env bash

source "$HOME/.config/bash/04-secrets.bash"
load-secrets

wifi() {
    [[ -f /sbin/iwgetid ]] || { echo ""; return 0; }

    local ssid="  "
    ssid+="$(/sbin/iwgetid | grep -oP 'ESSID:"\K.*[^"]')"
    [[ -z "$ssid" ]] && ssid+="<none>"

    echo $ssid
}

cpu_bars() {
    # see https://github.com/LukeSmithxyz/voidrice/blob/master/.local/bin/statusbar/sb-cpubars
    # Cache in tmpfs to improve speed and reduce SSD load
    cache=/tmp/cpubarscache
    # id total idle
    stats=$(awk '/cpu[0-9]+/ {printf "%d %d %d\n", substr($1,4), ($2 + $3 + $4 + $5), $5 }' /proc/stat)

    [ ! -f $cache ] && echo "$stats" > "$cache"
    old=$(cat "$cache")
    echo "$stats" | while read -r row; do
        id=${row%% *}
        rest=${row#* }
        total=${rest%% *}
        idle=${rest##* }

        case "$(echo "$old" | awk '{if ($1 == id)
            printf "%d\n", (1 - (idle - $3)  / (total - $2))*100 /12.5}' \
            id="$id" total="$total" idle="$idle")" in

            "0") printf "▁";;
            "1") printf "▂";;
            "2") printf "▃";;
            "3") printf "▄";;
            "4") printf "▅";;
            "5") printf "▆";;
            "6") printf "▇";;
            "7") printf "█";;
            "8") printf "█";;
        esac
    done; printf "\\n"
    echo "$stats" > "$cache"
}

cpu_temp() {
    cputemp=$(sensors | awk '/Package id 0/ {print $4}' | grep -oP '\+\K\d+\.\d+')
    [[ -z "$cputemp" ]] &&
        cputemp=$(sensors | awk '/Tctl:/ {print $2}' | grep -oP '\+\K\d+\.\d+')

    temp=$(echo "$cputemp" | grep -oP '^\d+')

    if [[ "$temp" -gt "80" ]]; then
        therm="#[fg=red]#[fg=default]"
    elif [[ "$temp" -gt "60" ]]; then
        therm="#[fg=yellow]#[fg=default]"
    else
        therm="#[fg=green]#[fg=default]"
    fi

    echo "$therm$cputempºC"
}

watts() {
    [[ "$DESKTOP_HOSTNAME" == "$(hostname)" ]] || return
    [[ -z "$IOT_URL" ]] && return

    w=$(curl -s "$IOT_URL/state/SP02" | jq .power)

    printf "%03s W" "$w"
}

battery() {

    [[ $(upower -e | grep -s BAT0 ) ]] && {
        battery_pct=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | \
                awk '/percentage:/ {print $2}' | tr -d '%')

        if [[ "$battery_pct" -lt "25" ]]; then
            battery+="#[fg=red]󰂎#[fg=default]"$battery_pct"%"
        elif [[ "$battery_pct" -lt "50" ]]; then
            battery+="#[fg=yellow]󱊡#[fg=default]"$battery_pct"%"
        elif [[ "$battery_pct" -lt "75" ]]; then
            battery+="#[fg=green]󱊢#[fg=default]"$battery_pct"%"
        else
            battery+="#[fg=green]󱊣#[fg=default]"$battery_pct"%"
        fi
    }

    # Get the battery of my MX Master 3S
    mx=$(bluetoothctl devices | awk '/MX Master 3S/ {print $2}')
    [[ ! -z "$mx" ]] && {
        battery_pct=$(bluetoothctl info $mx | grep -oP 'Battery Per.*\(\K\d{2}\d?')

        if [[ "$battery_pct" -lt "25" ]]; then
            battery+="#[fg=red]󰂎#[fg=default]"$battery_pct"%"
        elif [[ "$battery_pct" -lt "50" ]]; then
            battery+="#[fg=yellow]󱊡#[fg=default]"$battery_pct"%"
        elif [[ "$battery_pct" -lt "75" ]]; then
            battery+="#[fg=green]󱊢#[fg=default]"$battery_pct"%"
        else
            battery+="#[fg=green]󱊣#[fg=default]"$battery_pct"%"
        fi
    }

    echo "$battery"
}

echo "$(wifi) $(battery) $(cpu_temp) $(cpu_bars) $(watts)"
