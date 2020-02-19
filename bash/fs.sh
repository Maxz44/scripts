#!/bin/bash
# Gui Script to controll cpufreq
# Stop at error
set -e
# Check dependency
type xterm zenity cpupower > /dev/null

if [[ $UID -ne 0 ]];then
    # relaunch as root
    scriptpath="$(cd "$(dirname "$0")";pwd -P)/$(basename $0)"
    xterm -title 'Type your password' -e "sudo ${scriptpath}"
else
    wanted_freq="$(cpupower frequency-info|grep steps|cut -d: -f2-|tr ',' '\n'|sed -e 's/^\s*//g'|zenity --list --column frequency --text='Chose max cpu frequency'|tr -d ' ')" &&\
    cpupower frequency-set -u "${wanted_freq}"
fi
