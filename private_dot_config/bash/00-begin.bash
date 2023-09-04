
# add $HOME/.local/bin to path if it does not exist
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && \
    export PATH=$HOME/.local/bin:$PATH

[[ -z $LANG ]] && export LC_ALL=C.UTF-8

# Auto tmux if:
#   - it is not an SSH session
#   - it is not running
#   - and there is a client connected to a session
[[ -x $(command -v tmux) ]] && [[ -z $SSH_TTY ]] && [[ -z $TMUX ]] && {
    tmux has-session &> /dev/null
    [[ "$?" -eq "1" ]] && exec tmux new -A -s $USER -c $HOME bash
}
