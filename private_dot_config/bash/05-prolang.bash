
################################################################################
# golang: https://go.dev/
export GOROOT=$HOME/.local/golang/go
export GOPATH=$HOME/.local/golang/path

path_add "$GOROOT/bin"
path_add "$GOPATH/bin"

__ go || install-go() {
    mkdir -p $HOME/.local/golang $GOPATH
    local gotar="https://go.dev/dl/go1.21.6.linux-amd64.tar.gz"
    curl -fL --progress-bar $gotar -o /tmp/go.tar.gz
    tar xfzv /tmp/go.tar.gz --directory=$HOME/.local/golang
}

################################################################################
# rust:
export RUSTUP_HOME="$HOME/.local/rustup"
export CARGO_HOME="$HOME/.local/cargo"

# add $HOME/.local/cargo/bin to path if it does not exist
path_add "$HOME/.local/cargo/bin"

__ rustup || install-rustup() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |
        sh -s -- --no-modify-path
}

################################################################################
# odin:
export ODIN_ROOT="$HOME/.local/Odin"
