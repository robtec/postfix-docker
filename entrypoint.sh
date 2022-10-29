#!/bin/bash

set -e

USERS_FILE="users.txt"

function load_users() {

    while read username || [ -n "$username" ]; do
        echo -e "Setting up system user ${username}"
        adduser "$username" --quiet --disabled-password --shell /usr/sbin/nologin --gecos "" --force-badname || true
        password=$(diceware -d-)
        echo "$username:$password" | chpasswd || true
    done < $USERS_FILE
    
}

function update_configs() {
    if [ "$MY_DOMAIN" == "localhost" ]; then
        echo -e "setting cert/key to default for localhost"
        export CERT_FILE="/etc/ssl/certs/ssl-cert-snakeoil.pem"
        export KEY_FILE="/etc/ssl/private/ssl-cert-snakeoil.key"
        envsubst '\$MY_DOMAIN \$CERT_FILE \$KEY_FILE' < /tmp/main.cf > /etc/postfix/main.cf
    else
        echo -e "setting cert/key to certbot for ${MY_DOMAIN}"
        export CERT_FILE="/run/ssl/${MY_DOMAIN}/fullchain.pem"
        export KEY_FILE="/run/ssl/${MY_DOMAIN}/privkey.pem"
        envsubst '\$MY_DOMAIN \$CERT_FILE \$KEY_FILE' < /tmp/main.cf > /etc/postfix/main.cf
    fi
}

# check if users file exists
if [ -f "$USERS_FILE" ]; then
    echo -e "Found users file to process"
    load_users
fi

update_configs

exec "$@"