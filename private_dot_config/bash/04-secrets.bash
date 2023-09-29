
# create the secrets file if it does not exist
[[ -f "$HOME/.config/secrets.env" ]] || {
    touch "$HOME/.config/secrets.env"
    chmod 0600 "$HOME/.config/secrets.env"
}

CURRENT_SECRET_KEYS=""

load-secrets() {

    local mod=$(stat "$HOME/.config/secrets.env" | grep -oP "\(\K\d{4}")
    [[ "$mod" == "0600" ]] || {
        echo "INFO: setting '$HOME/.config/secrets.env' permissions to 0600"
        chmod 0600 "$HOME/.config/secrets.env"
    }

    # unset the current keys
    for s in $CURRENT_SECRET_KEYS; do
        unset "$s"
    done

    # make sure the secrets are not exported
    local secrets=$(cat "$HOME/.config/secrets.env" | sed -e 's/^export\s\?//')

    if [[ ! $# -eq "0" ]]; then
        # Load only specific secrets
        local split=$(echo $secrets | awk -F= '{print $1}')
        CURRENT_SECRET_KEYS=$(echo "$split $@" | sed 's/ /\n/g' | sort | uniq -d)
        for s in $CURRENT_SECRET_KEYS; do
            eval "$(echo $secrets | grep $s)"
        done
    else
        eval "$secrets"
        CURRENT_SECRET_KEYS=$(echo $secrets | awk -F= '{print $1}')
    fi

}

load-secrets
export -f load-secrets
