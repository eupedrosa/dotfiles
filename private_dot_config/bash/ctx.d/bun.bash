
export BUN_INSTALL=$HOME/.local/bun
# add $HOME/.local/bun/bin to path if it does not exist
[[ ":$PATH:" != *":$HOME/.local/bun/bin:"* ]] && \
    export PATH=$HOME/.local/bun/bin:$PATH

__ bun || {
    install-bun(){ curl -fsSL https://bun.sh/install; }
}
