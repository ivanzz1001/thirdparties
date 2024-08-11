#!/bin/bash

# cmake --version
# cmake version 3.22.1

CURRENT_DIR=$(pwd)
PREBUILT_DIR=${CURRENT_DIR}/prebuilt_dir
export PATH=${PREBUILT_DIR}:$PATH
nproc=2

# 这里编译gflags时带上CMAKE_CXX_FLAGS="-fPIC"参数，否则后面的BRAFT可能编译不过
# https://www.cnblogs.com/liyishui2003/p/18004268
function build_gflags()
{
    cd ${CURRENT_DIR}/gflags && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_CXX_FLAGS="-fPIC" -DCMAKE_INSTALL_PREFIX=${PREBUILT_DIR} -B build && cmake --build build -j ${nproc} && cmake --build build --target install 

    if [ $? -ne 0 ];then
        echo "build gflags failed"
        exit 
    fi

    echo "BUILD gflags COMPLETE"
}

function build_glogs()
{
    cd ${CURRENT_DIR}/glog && cmake -S . -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RelWithDebInfo -DWITH_GFLAGS=OFF -DWITH_GTEST=OFF -DCMAKE_INSTALL_PREFIX=${PREBUILT_DIR} -B build && cmake --build build -j ${nproc} && cmake --build build --target install

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

# 这里编译protobuf时带上CMAKE_CXX_FLAGS="-fPIC"参数，否则后面的BRAFT可能编译不过
# https://www.cnblogs.com/liyishui2003/p/18004268
function build_protobuf()
{
    # git submodule update --init --recursive
    PROTOBUF_INSTALL_PATH=${PREBUILT_DIR}/protobuf
    cd ${CURRENT_DIR}/protobuf && cmake -G "Unix Makefiles"  -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_CXX_FLAGS="-fPIC" -DCMAKE_INSTALL_PREFIX=${PROTOBUF_INSTALL_PATH} -B build && cmake --build build -j ${nproc} && cmake --build build --target install

    if [ $? -ne 0 ]; then
	    echo "build protobuf failed"
	    exit
    fi
    
    echo "BUILD protobuf COMPLETED"
}


# leveldb会把gtest/gmock/benchmark都编译进来
# 参看：https://blog.csdn.net/10km/article/details/133125114
function build_leveldb()
{
    cd ${CURRENT_DIR}/leveldb && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_CXX_FLAGS="-fPIC" -DCMAKE_INSTALL_PREFIX=${PREBUILT_DIR} -B build && cmake --build build -j ${nproc} && cmake --build build --target install

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
    cd ${CURRENT_DIR}/braft && cmake -S . -DBUILD_GMOCK=OFF -DLEVELDB_WITH_SNAPPY=1 -DBRPC_WITH_GLOG=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_PREFIX_PATH=${BRAFT_PREFIX_PATH} -DCMAKE_INSTALL_PREFIX=${PREBUILT_DIR} -B build && cmake --build build -j ${nproc} && cmake --build build --target install

    if [ $? -ne 0 ]; then
	    echo "build braft failed"
	    exit
    fi
    
    echo "BUILD braft COMPLETED"
}


function build_spdlog()
{
    cd ${CURRENT_DIR}/spdlog && cmake -S . -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=${PREBUILT_DIR} -B build && cmake --build build -j ${nproc} && cmake --build build --target install

    if [ $? -ne 0 ]; then
	    echo "build spdlog failed"
	    exit
    fi
    
    echo "BUILD spdlog COMPLETED"
}

# 这里我们的编译机是64位系统，编译32位会报错
function build_libaco()
{
    cd ${CURRENT_DIR}/libaco && mkdir output && bash make.sh -o no-valgrind -o no-m32
    if [ $? -ne 0 ]; then
	    echo "build libaco failed"
	    exit
    fi
    
    echo "BUILD libaco COMPLETED"
}

function build_isal()
{
    cd ${CURRENT_DIR}/erasure-code/isal && make -f Makefile.unx
    if [ $? -ne 0 ]; then
	    echo "build isal failed"
	    exit
    fi
    
    echo "BUILD isal COMPLETED"
}

function build_gfcomplete()
{
    cd ${CURRENT_DIR}/erasure-code/jerasure/gf-complete && ./autogen.sh && ./configure --prefix=${PREBUILT_DIR} && make && make install
    if [ $? -ne 0 ]; then
	    echo "build jerasure/gf-complete failed"
	    exit
    fi
    
    echo "BUILD gf-complete COMPLETED"
}

# 编译jerasure需要 autoconf 2.65以上
# 编译jerasure需要先编译gf-complete
function build_jerasure()
{
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${PREBUILT_DIR}/lib
    export LDFLAGS="-L${PREBUILT_DIR}/lib"
    export CFLAGS="-I${PREBUILT_DIR}/include"
    echo $LDFLAGS
    echo $CFLAGS 
    cd ${CURRENT_DIR}/erasure-code/jerasure/jerasure && autoreconf --force --install && ./configure --prefix=${PREBUILT_DIR} && make && make install
    if [ $? -ne 0 ]; then
	    echo "build jerasure failed"
	    exit
    fi
    
    echo "BUILD jerasure COMPLETED"
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
    build_spdlog
    build_libaco
    build_gfcomplete
    build_jerasure
}

function do_clean()
{
    dir_list=(gflags glog googletest protobuf leveldb incubator-brpc jsoncpp rocksdb braft spdlog)
    for dir in ${dir_list[*]}
    do 
        rm -rf ${CURRENT_DIR}/${dir}/build
    done 
    
    maked_dir=(rocksdb-gtest-1.8.1/build rocksdb-gtest-1.8.1/prebuilt_dir libaco/output)
    for dir in ${maked_dir[*]}
    do 
        rm -rf ${CURRENT_DIR}/${dir}
    done 

    rm -rf ${PREBUILT_DIR}
}

if [[ $1 == "clean" ]]; then
    do_clean
else
    do_build
fi
