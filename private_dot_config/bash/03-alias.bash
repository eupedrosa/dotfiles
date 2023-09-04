
# let us start by removing all aliases
unalias -a

# allow sudo with alias
alias sudo='sudo '

alias rm='rm -I --preserve-root'
alias cp='cp -i'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

alias du='du -ch'
alias df='df -H'
alias grep='grep --color'
alias path='echo -e ${PATH//:/\\n}'
alias kill='pkill'
alias pgrep='pgrep -a'

alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'

# clipboard
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -o -selection clipboard'


__ batcat && {
alias cat='batcat -n --theme OneHalfDark'

# use bat as the man pager
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
}
