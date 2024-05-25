
# 建立常用第三方库

参看:

- [git submodule的使用](https://zhuanlan.zhihu.com/p/657678855)

- [git submodule拉取指定tag](https://stackoverflow.com/questions/18755933/create-a-git-submodule-from-a-specific-repo-hash-or-tag)

- [git submodule卸载](https://blog.csdn.net/ppzzgg666/article/details/136430931)

- [Github personal token设置](https://github.com/settings/tokens)


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
# git submodule add  -b master -f https://github.com/protocolbuffers/protobuf.git     
</pre>




5) brpc

<pre>
# git submodule add https://github.com/apache/brpc.git incubator-brpc
</pre>





