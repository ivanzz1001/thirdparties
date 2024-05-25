#!/bin/bash

CURRENT_DIR=$(pwd)
PREBUILT_DIR=${CURRENT_DIR}/prebuilt_dir
export PATH=${PREBUILT_DIR}:$PATH
nproc=2


function build_gflags()
{
    cd ${CURRENT_DIR}/gflags && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=${PREBUILT_DIR} -B build && cmake --build build -j ${nproc} && cmake --build build --target install 

    if [ $? -ne 0 ];then
        echo "build gflags failed"
        exit 
    fi

    echo "BUILD gflags COMPLETE"
}

function build_glogs()
{
    cd ${CURRENT_DIR}/glog && cmake -S . -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RelWithDebInfo -DWITH_GFLAGS=OFF -DCMAKE_INSTALL_PREFIX=${PREBUILT_DIR} -B build && cmake --build build -j ${nproc} && cmake --build build --target install

    if [ $? -ne 0 ];then
        echo "build glog failed"
        exit 
    fi

    echo "BUILD glog COMPLETE" 
}

function build_protobuf()
{
    # git submodule update --init --recursive
    PROTOBUF_INSTALL_PATH=${PREBUILT_DIR}/protobuf
    cd ${CURRENT_DIR}/protobuf && cmake -G "Unix Makefiles"  -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=${PROTOBUF_INSTALL_PATH} -B build && cmake --build build -j ${nproc} && cmake --build build --target install

    if [ $? -ne 0 ]; then
	    echo "build protobuf failed"
	    exit
    fi
    
    echo "BUILD protobuf COMPLETED"
}

function do_build()
{
    # build_gflags
    build_glogs
    # build_protobuf
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
