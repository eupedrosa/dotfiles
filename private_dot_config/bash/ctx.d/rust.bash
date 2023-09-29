
export RUSTUP_HOME="$HOME/.local/rustup"
export CARGO_HOME="$HOME/.local/cargo"

# add $HOME/.local/cargo/bin to path if it does not exist
[[ ":$PATH:" != *":$HOME/.local/cargo/bin:"* ]] && \
    export PATH=$HOME/.local/cargo/bin:$PATH

__ rustup || {

# Expose a function to install rust from the web
install-rustup() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path
}
    return
}
