#!/bin/bash

set -e

function clone() {
    git clone https://github.com/tmate-io/tmate-slave.git /src/tmate-server
}

function build() {
    ./create_keys.sh
    ./autogen.sh
    ./configure
    make
}

function copy() {
    rm -f /nexus/tmate-slave
    cp ./tmate-slave /nexus/
}

function main() {
    clone

    cd /src/tmate-server

    build

    copy
}

main
