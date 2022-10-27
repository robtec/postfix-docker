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
    envsubst '\$MY_DOMAIN' < /tmp/main.cf > /etc/postfix/main.cf
}

# check if users file exists
if [ -f "$USERS_FILE" ]; then
    echo -e "Found users file to process"
    load_users
fi

update_configs

# update default postfix config
# postconf -e "maillog_file=/dev/stdout"

exec "$@"