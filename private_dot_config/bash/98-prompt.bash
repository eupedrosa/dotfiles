
bold="\[\e[1m\]"

green="\[\e[32m\]"
yellow="\[\e[33m\]"
blue="\[\e[34m\]"
cyan="\[\e[36m\]"
reset_color="\[\\e[0m\]"

PS1=""

[[ -n $SSH_TTY ]] && \
    PS1+="${bold}${yellow}\u${reset_color} in ${bold}${blue} "

PS1+="${bold}${green}\h${reset_color}"
if [ -f /etc/bash_completion.d/git-prompt ]; then
    source /etc/bash_completion.d/git-prompt
    export GIT_PS1_SHOWDIRTYSTATE=1
    PS1+=" in ${bold}${blue}\w\$(__git_ps1)\n"
else
    PS1+=" in ${bold}${blue}\w\n"
fi

[[ -f /run/.containerenv ]] || [[ -f /.dockerenv ]] && \
    PS1+="${bold}${cyan} "

PS1+="${bold}${green}❯ ${reset_color}"

# add a new line after executing a command
__nl_prompt() {
    local pos
    IFS='[;' read -p $'\e[6n' -d R -a pos -rs || echo "failed with error: $? ; ${pos[*]}"

    [[ "${pos[1]}" -gt 2 ]] && echo
}

[[ ";$PROMPT_COMMAND;" != *";__nl_prompt;"* ]] && \
    PROMPT_COMMAND="__nl_prompt;$PROMPT_COMMAND"
