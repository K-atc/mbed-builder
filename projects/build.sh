#!/bin/sh
usage(){
    echo "usage: $0 SOURCE_DIR TARGET_BARD [MOUNT_POINT]"
    echo "usage: $0 clean"
    echo "TARGET_BARD = DISCO_F746NG, NUCLEO_L152RE, RZ_A1H (GR-PEAH),  ..."
    echo "MOUNT_POINT = /media/mbed"
    exit -1
}
if [ $# -eq 0 ]; then
    usage
fi

# SRC_DIR="${PWD}/$1"
SRC_DIR=$1
TARGET=$2
# MBED_DIR="${PWD}/../mbed"
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd) # see: http://qiita.com/yudoufu/items/48cb6fb71e5b498b2532
MBED_DIR="${script_dir}/../mbed-os"
BUILD_PY="${MBED_DIR}/tools/build.py"

if [ $1 = "clean" ]; then
    python2 $BUILD_PY --clean
    exit
fi

# HACK: prepare required mbed files to compile
if [ ! -e ${MBED_DIR}/BUILD/mbed/TARGET_${TARGET} ]; then
    python2 $BUILD_PY -m $TARGET -t GCC_ARM
fi

echo "build target = $TARGET, src = $SRC_DIR"
if [ $# -eq 3 ]; then
    DOWNLOAD=true
    MNT_POINT=$3
    echo "mount point = $MNT_POINT"
fi

rm $SRC_DIR/build/*.o 2> /dev/null
if [ $DOWNLOAD ]; then
    # NO GOOD
    echo "[*] build & download mode"
    python2 ${MBED_DIR}/tools/make.py -m $TARGET -t GCC_ARM --source $SRC_DIR --build $SRC_DIR/build -d $MNT_POINT
else 
    # python2 ${MBED_DIR}/tools/make.py -m $TARGET -t GCC_ARM --source $SRC_DIR --build $SRC_DIR/build --profile small -D NDEBUG=1 --cflags NDEBUG
    # python2 ${MBED_DIR}/tools/make.py -m $TARGET -t GCC_ARM --source $SRC_DIR --build $SRC_DIR/build -D NDEBUG=1 --cflags "NDEBUG" # for mbed
    python2 ${MBED_DIR}/tools/make.py -m $TARGET -t GCC_ARM --source $SRC_DIR --build $SRC_DIR/build -D NDEBUG=1 # for mbed-os
fi
