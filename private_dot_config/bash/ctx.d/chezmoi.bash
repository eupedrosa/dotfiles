__ chezmoi || return

# Extra test for busybox.
# It does not run on a alpine container.
[[ -h /bin/ls ]] && { readlink /bin/ls | grep -q busybox; } && return

alias chez='chezmoi'
alias cs='chezmoi status'
alias cf='chezmoi diff'
alias ca='chezmoi add'
alias cra='chezmoi re-add'
alias cg='chezmoi git'
alias ccd='chezmoi cd'

eval "$(chezmoi completion bash)" 2> /dev/null
