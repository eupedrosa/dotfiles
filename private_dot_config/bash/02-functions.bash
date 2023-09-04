
# check if all the commands exist
__() {
    for cmd in $@; do
        [[ -x $(command -v "$cmd") ]] || return 1
    done
    return 0
}

check_apps() {
    local apps="batcat curl chezmoi direnv exa git nvim fzf xclip zoxide"

    __() { printf "%-10s" $1; [[ -x $(command -v "$1") ]] }
    for a in $apps; do
        __ $a && echo "OK" || echo "FAIL"
    done
}

# ez re-source
.s() {
    source $HOME/.bashrc || echo "bad"
    echo "Done re-sourcing .bashrc"
}

# Improved xdg-open.
#   - do a fuzzy search for a filename when no argument is provided
#   - open text files in the shell, no need to launch a new App
#   - redirect App output to /dev/null
__ fdfind fzf &&
open() {
    [[ $# -eq 0 ]] && {
        target=$(fdfind -d 1 -t f | fzf -i --height=~15 || true)
        [[ -z "$target" ]] && return
        cmd="$target"

    } || cmd="$1"

    xdg-mime query filetype "$cmd" | grep -qE '^text/' &&
        nvim $cmd ||
        nohup xdg-open "$cmd" &> /dev/null;
}

# .gitignore (online) generator
__ curl &&
gi() {
    curl -sL "https://www.toptal.com/developers/gitignore/api/$@"
}

#==================================================
# lots of functions are created for auto completion
source /etc/bash_completion
