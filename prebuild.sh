#!/bin/bash

# cmake --version
# cmake version 3.22.1

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

function build_gtest()
{
    cd ${CURRENT_DIR}/googletest && cmake -S . -DBUILD_GMOCK=OFF -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=${PREBUILT_DIR} -B build && cmake --build build -j ${nproc} && cmake --build build --target install

    if [ $? -ne 0 ];then
        echo "build googletest failed"
        exit 
    fi

    echo "BUILD googletest COMPLETE" 
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


# leveldb会把gtest/gmock/benchmark都编译进来
function build_leveldb()
{
    cd ${CURRENT_DIR}/leveldb && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=${PREBUILT_DIR} -B build && cmake --build build -j ${nproc} && cmake --build build --target install

    if [ $? -ne 0 ]; then
	    echo "build leveldb failed"
	    exit
    fi
    
    echo "BUILD leveldb COMPLETED"
}

# brpc目前还没兼容 protobuf >= 22
# https://github.com/apache/brpc/issues/2350
function build_brpc()
{
    BRPC_PREFIX_PATH=${PREBUILT_DIR}\;${PREBUILT_DIR}/protobuf
    cd ${CURRENT_DIR}/incubator-brpc && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DWITH_SNAPPY=ON -DCMAKE_PREFIX_PATH=${BRPC_PREFIX_PATH} -DCMAKE_INSTALL_PREFIX=${PREBUILT_DIR} -B build && cmake --build build -j ${nproc} && cmake --build build --target install

    if [ $? -ne 0 ]; then
	    echo "build brpc failed"
	    exit
    fi
    
    echo "BUILD brpc COMPLETED"
}

# function build_jsoncpp()
# {

# }

function do_build()
{
    # build_gflags
    # build_glogs
    # build_gtest
    # build_protobuf
    # build_leveldb
    build_brpc
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
