#!/bin/bash

# This is a script building libraries for travis-ci
# It is *not* for general audience

SRC=../../3rdparty/

if [ ${TRAVIS_OS_NAME} == "linux" ] ; then
    LIBS="libapogee libfishcamp libfli libqhy libqsi libsbig"
else 
    LIBS="libqsi"
fi

if [ .${TRAVIS_BRANCH%_*} == '.drv' ] ; then 
    DRV=lib"${TRAVIS_BRANCH#drv_}"
    if [ -d $SRC/$DRV ] ; then
        LIBS="$DRV"
    fi
fi

for lib in $LIBS ; do
(
    echo "Building $lib ..."
    mkdir -p build/$lib
    pushd build/$lib
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local . $SRC/$lib
    make
    sudo make install
    popd
)
done
