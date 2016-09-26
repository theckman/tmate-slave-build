#!/bin/bash

set -e

function preflight() {
    if [ ! -d "/nexus" ]; then
        echo 'ERROR: you must mount a directory on the host at /nexus for sending the built binary back to the host'
        echo '==> It is recommended to execute `docker run` with: -v $(pwd)/nexus:/nexus'
        exit 2
    fi
}

function clone() {
    echo '--> cloning https://github.com/tmate-io/tmate-slave.git in to /src/tmate-server'
    git clone https://github.com/tmate-io/tmate-slave.git /src/tmate-server
}

function build() {
    echo '--> generating SSH keys'
    ./create_keys.sh

    echo '--> auto-generating build steps'
    ./autogen.sh

    echo '--> configuring build parameters'
    ./configure

    echo '--> building tmate-slave'
    make
}

function copy() {
    echo '--> copying /src/tmate-slave/tmate-slave to /nexus/tmate-slave'
    rm -f /nexus/tmate-slave
    cp ./tmate-slave /nexus/
}

function main() {
    echo '==> running preflight checks'
    preflight

    echo '==> starting clone operations'
    clone

    cd /src/tmate-server

    echo '==> starting build operations'
    build

    echo '==> starting final copy operations'
    copy

    echo '==> DONE!'
}

main
