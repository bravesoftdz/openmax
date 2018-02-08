#!/bin/bash
set -e

# on raspbian, build the program and reboot to it

PROGRAM=$1
PROGRAM=$1
if [[ $PROGRAM == "" ]]
then
    echo "first arg selects program (lpr/lpi file): VideoTest or Working or Components"
    exit 1
fi

ULTIBO=$HOME/ultibo/core
ULTIBOBIN=$ULTIBO/fpc/bin
export PATH=$ULTIBOBIN:$PATH
rm -rf lib/*
fpc -B -O2 -Tultibo -Parm -CpARMV7a -WpRPI3B -Fi$ULTIBO/source/rtl/ultibo/core @$ULTIBOBIN/RPI3.CFG $PROGRAM.lpr >& errors.log
sudo cp kernel7.img /boot/test-kernel7.img
sudo cp /boot/test-config.txt /boot/config.txt
sudo reboot
