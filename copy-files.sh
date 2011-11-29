#!/bin/bash

# This script is designed to dynamically read from the extract-files.sh
# script and pull needed proprietary blobs from an extracted device
# system location instead of the device itself.
# The Source location passed should contain the /system/ folder
# for the specific device

VENDOR=toshiba
DEVICE=folio100

if [ $# -lt 1 ]
then
        echo "Usage:" $0 "<Source>"
        exit
fi

SOURCE=${1//'/'/'\/'}

BASE=../../../vendor/$VENDOR/$DEVICE/proprietary
rm -rf $BASE/*

for FILE in `cat proprietary-files.txt | grep -v ^# | grep -v ^$`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    cp -a $SOURCE/$FILE /system/$FILE $BASE/$FILE
done

./setup-makefiles.sh
