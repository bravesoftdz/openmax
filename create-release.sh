#!/bin/bash
set -e # exit script on any error

VERSION=v$(date +%Y.%m.%d.%H%M)
PREFIX=ultibo-openmax
ZIPFILE=$PREFIX-$VERSION.zip
PATH=$HOME/hub-linux-arm-2.3.0-pre10/bin:$PATH

mkdir -p release
rm -rf release/*

./build.sh VideoTest
cp -a kernel7.img release/ultibo-openmax-kernel7.img
cp -a ultibo-openmax-config.txt ultibo-openmax-cmdline.txt release/
cp -a release/ultibo-openmax-config.txt release/config.txt
cp -a test.h264 release
echo "ultibo-openmax $VERSION" >> release/release-message.md
echo >> release/release-message.md
cat release-message.md >> release/release-message.md
cp -a firmware/boot/bootcode.bin firmware/boot/start.elf firmware/boot/fixup.dat release/
cd release
zip $ZIPFILE *
cd ..

hub release create -d -p -F release/release-message.md -a release/$ZIPFILE $VERSION
