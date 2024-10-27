
# 建立常用第三方库

参看:

- [git submodule的使用](https://zhuanlan.zhihu.com/p/657678855)

- [git submodule拉取指定tag](https://stackoverflow.com/questions/18755933/create-a-git-submodule-from-a-specific-repo-hash-or-tag)

- [git submodule卸载](https://blog.csdn.net/ppzzgg666/article/details/136430931)

- [Github personal token设置](https://github.com/settings/tokens)

- [优雅的删除子模块](https://www.jianshu.com/p/ed0cb6c75e25)

## 1. 如何拉取本仓库
<pre>
# git clone --depth 1 https://github.com/ivanzz1001/thirdparties.git
# git submodule init 
# git submodule update
</pre>

>ps: 也可以直接执行如下更新submodule
>    git submodule update --init --recursive



## 2. 相关第三方库列表

1) gflags
<pre>
# git submodule add https://github.com/gflags/gflags.git
# cd gflags
# git tag
v0.1
v0.2
v0.3
v0.4
v0.5
v0.6
v0.7
v0.8
v0.9
v1.0rc1
v1.0rc2
v1.1
v1.2
v1.3
v1.4
v1.5
v1.6
v1.7
v2.0
v2.1.0
v2.1.1
v2.1.2
v2.2.0
v2.2.1
v2.2.2
# git checkout tags/v2.2.2
# cd ..
# git add .gitmodules ./gflags
# git commit -m "add gflags v2.2.2" 
# git push
</pre>

2) glog
<pre>
# git submodule add https://github.com/google/glog.git
# cd glog
v0.1
v0.1.1
v0.1.2
v0.2
v0.2.1
v0.3.0
v0.3.1
v0.3.2
v0.3.3
v0.3.4
v0.3.5
v0.4.0
v0.5.0
v0.5.0-rc1
v0.5.0-rc2
v0.6.0
v0.6.0-rc1
v0.6.0-rc2
v0.7.0
v0.7.0-rc1

# git checkout tags/v0.7.0
# cd ..
# git add .gitmodules ./glog
# git commit -m "add glog v0.7.0"
# git push
</pre>


3) gtest
<pre>
# git submodule add https://github.com/google/googletest.git
# cd googletest
# git checkout tags/v1.14.0
# git add .gitmodules ./googletest
# git commit -m "add gtest v1.14.0" 
# git push
</pre>

4) gmock



5) protobuf

<pre>
# git submodule deinit -f protobuf
# git rm --cached protobuf
# git submodule add https://github.com/protocolbuffers/protobuf.git  
# git add .gitmodules ./protobuf
# git commit -m "add protobuf main"
# git push
</pre>
>ps: 这里protobuf版本号为v21.8



6) leveldb
<pre>
# git submodule add https://github.com/google/leveldb.git
# cd leveldb
# git tag
1.21
1.22
1.23
v1.10
v1.11
v1.12
v1.13
v1.14
v1.15
v1.16
v1.17
v1.18
v1.19
v1.20
v1.3
v1.4
v1.5
v1.6
v1.7
v1.8
v1.9
# git checkout tags/v21.8
# cd ..
# git add .gitmodules ./leveldb
# git commit -m "add leveldb v1.23"
# git push
</pre>



7) brpc

<pre>
# git submodule add https://github.com/apache/brpc.git incubator-brpc
# git add .gitmodules ./incubator-brpc
# git commit -m "add brpc"
# git push
</pre>


8) jsoncpp
<pre>
# git submodule add https://github.com/open-source-parsers/jsoncpp.git
# cd jsoncpp
# git tag
# git checkout tags/1.9.5
# cd ..
# git add .gitmodules ./jsoncpp
# git commit -m "add jsoncpp v1.9.5"
# git push
</pre>

9）rocksdb
<pre>
# git submodule add https://github.com/facebook/rocksdb.git 
# cd rocksdb
# git tag
1.5.7.fb
1.5.8.1.fb
1.5.8.2.fb
1.5.8.fb
1.5.9.1.fb
1.5.9.2.fb
1.5.9.fb
2.0.fb
2.1.fb
2.2.fb
2.3.fb
2.4.fb
2.5.fb
2.6.fb
2.7.fb
2.8.fb
3.0.fb
blob_st_lvl-pre
do-not-use-me2
rocksdb-3.1
rocksdb-3.10.1
rocksdb-3.10.2
rocksdb-3.11
rocksdb-3.11.1
rocksdb-3.11.2
# git checkout tags/v9.4.0
# cd ..
# git add .gitmodules ./rocksdb
# git commit -m "add rocksdb v9.4.0"
# git push 
</pre>

需要gtest的话，要使用gtest-1.8.1版本：
<pre>
# git submodule add https://github.com/google/googletest.git rocksdb-gtest-1.8.1
# cd rocksdb-gtest-1.8.1
# git checkout release-1.8.1
# cd ..
# git add .gitmodules 
# git add  rocksdb-gtest-1.8.1
# git commit -m "add gtest1.8.1"
# git push
</pre>


10) braft
<pre>
# git submodule add https://github.com/baidu/braft.git
# cd braft
# git tag
v1.0.0
v1.0.1
v1.0.2
v1.1.0
v1.1.1
v1.1.2
# git checkout v1.1.2
# cd ..
# git add .gitmodules
# git add braft
# git commit -m "add braft"
# git push
</pre>

11）spdlog的编译
<pre>
# git submodule add https://github.com/gabime/spdlog.git
# cd spdlog
# git tag
v0.10.0
v0.11.0
v0.12.0
v0.13.0
v0.14.0
v0.16.0
v0.16.1
v0.16.2
v0.16.3
v0.17.0
v0.9.0
v1.0.0
v1.1.0
v1.10.0
v1.11.0
v1.12.0
v1.13.0
v1.14.0
v1.14.1
v1.2.0
v1.2.1
v1.3.0
v1.3.1
v1.4.0
v1.4.1
v1.4.2
v1.5.0
v1.6.0
v1.6.1
v1.7.0
v1.8.0
v1.8.1
v1.8.2
v1.8.3
v1.8.4
v1.8.5
v1.9.0
v1.9.1
v1.9.2
# git checkout v1.14.1
# cd ..
# git add .gitmodules
# git add spdlog
# git commit -m "add spdlog"
# git push
</pre>

12) libaco
<pre>
# git submodule add https://github.com/hnes/libaco.git
# cd libaco
# git tag
v1.0
v1.1
v1.2.0
v1.2.1
v1.2.2
v1.2.3
v1.2.4
# git checkout v1.2.4
# cd ..
# git add .gitmodules
# git add libaco
# git commit -m "add libaco"
# git push
</pre>

13) erasure-code/isal
<pre>
# git submodule add https://github.com/intel/isa-l.git erasure-code/isal
# cd erasure-code/isal
# git tag
v2.14.1
v2.15.0
v2.16.0
v2.17.0
v2.18.0
v2.19.0
v2.20.0
v2.21.0
v2.22.0
v2.23.0
v2.24.0
v2.25.0
v2.26.0
v2.27.0
v2.28.0
v2.29.0
v2.30.0
v2.31.0
# git checkout v2.31.0
# cd ../..
# git add .gitmodules
# git add erasure-code/isal
# git commit -m "add erasure-code/isal"
# git push
</pre>


14) erasure-code/jerasure
<pre>
# git submodule deinit -f erasure-code/jerasure/jerasure
# git rm --cached erasure-code/jerasure/jerasure
# rm -rf erasure-code/jerasure
# rm -rf .git/modules/erasure-code/jerasure
 （记得编辑.git/config）
# 
# git submodule add https://github.com/ceph/jerasure.git erasure-code/jerasure/jerasure
# cd erasure-code/jerasure/jerasure/
# git tag
v0.9.10
v1.0
v1.0-rc1
v1.0-rc2
v1.0-rc3
v1.0.1
v1.0.3
v1.0.4
v1.0.5
v1.0.6
v1.0.7
v1.0.8
v1.0.9
v1.1.0
v1.1.1
# git checkout v1.1.1
# cd ../../..
# git add .gitmodules
# git add erasure-code/jerasure/jerasure
# git commit -m "add erasure-code/jerasure/jerasure"
# git push
</pre>

15) erasure-code/gf-complete
编译jerasure之前需要先安装gf-complete:
<pre>
# git submodule add https://github.com/ceph/gf-complete.git erasure-code/jerasure/gf-complete
# cd erasure-code/jerasure/gf-complete/
# git tag
# cd ../../..
# git add .gitmodules
# git add erasure-code/jerasure/gf-complete
# git commit -m "add erasure-code/jerasure/gf-complete"
# git push
</pre>
