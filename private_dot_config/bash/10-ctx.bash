# load context configurations
[[ -d "$(dirname $BASH_SOURCE)/ctx.d" ]] && {
    for b in $(dirname $BASH_SOURCE)/ctx.d/*.bash; do
        source $b
    done
}
