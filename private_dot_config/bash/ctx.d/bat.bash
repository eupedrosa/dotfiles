__ batcat || return

alias cat='batcat -n --theme OneHalfDark'
# use bat as the man pager
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
