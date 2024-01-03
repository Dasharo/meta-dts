#!/bin/sh

if [ -d /home/root/.dasharo-gnupg ]; then
    GNUPGHOME=/home/root/.dasharo-gnupg

    export GNUPGHOME
fi

