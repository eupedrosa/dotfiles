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
    cputemp=$(sensors | awk '/Package id 0/ {print $4}')
    [[ -z "$cputemp" ]] &&
        cputemp=$(sensors | awk '/Tctl:/ {print $2}')

    echo "🌡️ $cputemp"
}

watts() {
    [[ "$DESKTOP_HOSTNAME" == "$(hostname)" ]] || return
    [[ -z "$IOT_URL" ]] && return

    w=$(curl -s "$IOT_URL/state/SP02" | jq .power)
    echo "$w W"
}

battery() {
    battery_pct=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | \
                awk '/percentage:/ {print $2}' | tr -d '%')

    [[ "$battery_pct" -lt "25" ]] \
        && battery="🪫"$battery_pct"%" \
        || battery="🔋"$battery_pct"%"
}

echo "$(wifi) $(cpu_temp) $(cpu_bars) $(watts)"
