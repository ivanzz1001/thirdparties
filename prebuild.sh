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



function build_jsoncpp()
{
    cd ${CURRENT_DIR}/jsoncpp && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=${PREBUILT_DIR} -B build && cmake --build build -j ${nproc} && cmake --build build --target install

    if [ $? -ne 0 ]; then
	    echo "build jsoncpp failed"
	    exit
    fi
    
    echo "BUILD jsoncpp COMPLETED"
}


# 如果要使用WITH_GTEST，那么需要下载gtest-1.8.1
# https://github.com/google/googletest/tree/release-1.8.1
function build_rocksdb_gtest(){
    ROCKSDB_GTEST_INSTALL=${CURRENT_DIR}/rocksdb-gtest-1.8.1/prebuilt_dir
    cd ${CURRENT_DIR}/rocksdb-gtest-1.8.1 && cmake -S . -DBUILD_GMOCK=OFF -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=${ROCKSDB_GTEST_INSTALL} -B build && cmake --build build -j ${nproc} && cmake --build build --target install

    if [ $? -ne 0 ]; then
	    echo "build rocksdb-gtest failed"
	    exit
    fi
    
    echo "BUILD rocksdb-gtest COMPLETED"
}

function build_rocksdb()
{
    build_rocksdb_gtest

    ROCKSDB_PREFIX_DIR=${CURRENT_DIR}/rocksdb-gtest-1.8.1/prebuilt_dir
    cd ${CURRENT_DIR}/rocksdb && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DROCKSDB_BUILD_SHARED=OFF -DCMAKE_PREFIX_PATH=${ROCKSDB_PREFIX_DIR} -DCMAKE_INSTALL_PREFIX=${PREBUILT_DIR} -B build && cmake --build build -j ${nproc} && cmake --build build --target install
 #   cd ${CURRENT_DIR}/rocksdb && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DROCKSDB_BUILD_SHARED=OFF -DWITH_TESTS=OFF -DWITH_BENCHMARK_TOOLS=OFF -DWITH_CORE_TOOLS=OFF -DWITH_TOOLS=OFF -DCMAKE_INSTALL_PREFIX=${PREBUILT_DIR} -B build && cmake --build build -j ${nproc} && cmake --build build --target install

    if [ $? -ne 0 ]; then
	    echo "build rocksdb failed"
	    exit
    fi
    
    echo "BUILD rocksdb COMPLETED"
}

function build_braft()
{
    BRAFT_PREFIX_PATH=${PREBUILT_DIR}\;${PREBUILT_DIR}/protobuf
    cd ${CURRENT_DIR}/braft && cmake -S . -DBUILD_GMOCK=OFF -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_PREFIX_PATH=${BRAFT_PREFIX_PATH} -DCMAKE_INSTALL_PREFIX=${PREBUILT_DIR} -B build && cmake --build build -j ${nproc} && cmake --build build --target install

    if [ $? -ne 0 ]; then
	    echo "build braft failed"
	    exit
    fi
    
    echo "BUILD braft COMPLETED"
}

function do_build()
{
   build_gflags
    build_glogs
    build_gtest
    build_protobuf
    build_leveldb
    build_brpc
    build_jsoncpp
    build_rocksdb 
    build_braft 
}

function do_clean()
{
    rm -rf ${CURRENT_DIR}/gflags/build
    rm -rf ${CURRENT_DIR}/glog/build
    rm -rf ${CURRENT_DIR}/googletest/build
    rm -rf ${CURRENT_DIR}/protobuf/build
    rm -rf ${CURRENT_DIR}/leveldb/build
    rm -rf ${CURRENT_DIR}/incubator-brpc/build
    rm -rf ${CURRENT_DIR}/jsoncpp/build
    rm -rf ${CURRENT_DIR}/rocksdb-gtest-1.8.1/build ${CURRENT_DIR}/rocksdb-gtest-1.8.1/prebuilt_dir
    rm -rf ${CURRENT_DIR}/rocksdb/build
    rm -rf ${CURRENT_DIR}/braft/build
    rm -rf ${CURRENT_DIR}/prebuilt_dir

    echo "current do nothing"
}

if [[ $1 == "clean" ]]; then
    do_clean
else
    do_build
fi
