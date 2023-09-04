__ figlet || return

banner() {
    local d=$(dirname "${BASH_SOURCE}")
    [[ $# -eq 0 ]] && return
    figlet $@ -d "$d/figlet" -f "ANSI Shadow"
}

