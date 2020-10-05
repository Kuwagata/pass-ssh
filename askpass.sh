#!/usr/bin/env bash

# Handle the case when we're connecting for the first time
if echo $1 | grep "fingerprint" > /dev/null; then
    read -p "$1" response 1>&2
    echo "${response}"
    exit 0
fi

# Handle the case where we don't have a key configured for the particular host
# In this the user could easily be using standard SSH, but this maintains compatibility as a system-wide wrapper
if echo $1 | grep "'s password:" > /dev/null; then
    read -sp "$1" response 1>&2
    echo "${response}"
    exit 0
fi

# $1 looks like:
#   "Enter passphrase for /home/user/.ssh/id_rsa:" <- Note the default (no args) does not appear to have single quotes
#   or
#   "Enter passphrase for '/home/user/.ssh/id_ed25519_github':"
key_filename="$(echo "$1" | sed -e "s/^.*\/\(.*[^']\)'\{0,1\}:.*$/\1/")"
pass "${PASS_SSH_FOLDER:-SSH}/${key_filename}" | head -n1

