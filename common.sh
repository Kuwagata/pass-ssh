#!/usr/bin/env bash

set -euo pipefail
DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

require(){ hash "$@" || exit 127; }
require pass
require ssh
require ssh-add

# Make sure the SSH agent is running
if ! pidof "ssh-agent" > /dev/null; then
    printf 'No SSH agent running\n'
    exit 1
fi

export SSH_ASKPASS_REQUIRE=force
export SSH_ASKPASS="$DIR/askpass.sh"

