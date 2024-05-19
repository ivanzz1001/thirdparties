#!/bin/bash

CURRENT_DIR=$(pwd)
PREBUILT_DIR=${CURRENT_DIR}/prebuilt_dir
export PATH=${PREBUILT_DIR}:$PATH
nproc=2


function build_protobuf()
{
  cd ${CURRENT_DIR}/protobuf
}
