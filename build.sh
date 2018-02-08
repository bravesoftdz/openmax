#!/bin/bash
set -e # exit script on any error

PROGRAM=$1
if [[ $PROGRAM == "" ]]
then
    echo "first arg selects program (lpr/lpi file): VideoTest or Working or Components"
    exit 1
fi

LPI=$PROGRAM.lpi

if [[ -e /c/Ultibo/Core ]]
then
    rm -rf lib/*
    pushd /c/Ultibo/Core/ # for some reason at this time, need to run from this folder
    ./lazbuild.exe $(dirs -l +1)/$LPI
    popd
else
    export PATH=$HOME/ultibo/core:$PATH
    lazbuild $LPI
fi
