#!/bin/bash

# Script to share file using web server (busybox)
# Generate qr code at end

set -xe

# test dependencies
type busybox montage qrencode zenity > /dev/null

# test params
if [[ $# = "1" ]];then
    cd "$(dirname $1)"
    # All ip
    ips="$(ip a|egrep -o '([0-9]{1,3}\.){3}[0-9]{1,3}'|egrep -v '255$'|grep -v '127.0.0.1')"
    if [[ "${#ips}" = "0" ]];then
        echo "No ip where found"
        exit 2
    fi
    # If one ip
    if [[ "$(echo "${ips}"|wc -l)" = "1" ]];then
        ip="${ips}"
    else
        # Multiple ip
        ip="$(echo "${ips}"|zenity --list --column ip)"
    fi
    # QRCODE
    echo "http://${ip}:8080/$1"|qrencode -s 15 -o-|montage -label "http://${ip}:8080/$1" - -pointsize 20 -geometry +0+0 -|feh -Z - &
    # SERVER
    busybox httpd -f -vv -p 0.0.0.0:8080
else
    echo "Usage"
    echo "$0 <file_to_share>"
    exit 1
fi