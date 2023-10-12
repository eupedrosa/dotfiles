
# golang: https://go.dev/
export GOROOT=$HOME/.local/golang/go
export GOPATH=$HOME/.local/golang/path

path_add "$GOROOT/bin"
path_add "$GOPATH/bin"

__ go || {
    install-go() {
        mkdir -p $HOME/.local/golang $GOPATH
        local gotar="https://go.dev/dl/go1.21.3.linux-amd64.tar.gz"
        curl -fL --progress-bar $gotar -o /tmp/go.tar.gz
        tar xfzv /tmp/go.tar.gz --directory=$HOME/.local/golang
    }
}
