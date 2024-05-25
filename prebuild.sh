#!/bin/bash

CURRENT_DIR=$(pwd)
PREBUILT_DIR=${CURRENT_DIR}/prebuilt_dir
export PATH=${PREBUILT_DIR}:$PATH
nproc=2


function build_protobuf()
{
    # git submodule update --init --recursive
    PROTOBUF_INSTALL_PATH=${PREBUILT_DIR}/protobuf
    cd ${CURRENT_DIR}/protobuf && cmake -G "Unix Makefiles"  -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=${PROTOBUF_INSTALL_PATH} -B build && cmake --build build -j ${nproc} && cmake --build build --target install

    if [ $? -ne 0 ]; then
	    echo "build tutorial failed"
	    exit
    fi
    
    echo "BUILD tutorial COMPLETED"
}

function do_build()
{
    build_protobuf
}

function do_clean()
{
    echo "current do nothing"
}

if [[ $1 == "clean" ]]; then
    do_clean
else
    do_build
fi
