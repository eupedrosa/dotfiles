
# check the window size after each command
shopt -s checkwinsize

# helpfull cd
shopt -s autocd     2> /dev/null
shopt -s dirspell   2> /dev/null
shopt -s cdspell    2> /dev/null

# do not overwrite with stout redirection
set -o noclobber

# better tab completion
bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set show-all-if-ambiguous on"
bind "set mark-symlinked-directories on"

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

# save it in the cache directory
HISTFILE="$HOME/.cache/bash_history"

# large history size
HISTSIZE=100000
HISTFILESIZE=200000
HISTTIMEFORMAT='%F %T '

# avoid duplicates and unecessary entries
HISTCONTROL="erasedups:ignoreboth"
HISTIGNORE="&:[ ]*:exit:ls:bg:fb:history:exit:cd:.s"

shopt -s histappend
shopt -s cmdhist
shopt -s histreedit
shopt -s histverify
shopt -s lithist
