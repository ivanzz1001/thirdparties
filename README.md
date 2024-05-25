
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

2) glogs


3) gtest



4) protobuf

<pre>
# git submodule deinit -f protobuf
# git submodule add  -b master -f https://github.com/protocolbuffers/protobuf.git     
</pre>




5) brpc

<pre>
# git submodule add https://github.com/apache/brpc.git incubator-brpc
</pre>





