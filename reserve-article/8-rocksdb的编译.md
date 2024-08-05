# rocksdb的编译

参看:
- [rocksdb install](https://github.com/facebook/rocksdb/blob/main/INSTALL.md)


## 1. 检查相应的依赖库是否安装
- snappy库
```
# apt list --installed | grep snappy
# ldconfig -p | grep snappy
        libsnappy.so.1 (libc6,x86-64) => /lib/x86_64-linux-gnu/libsnappy.so.1
        libsnappy.so (libc6,x86-64) => /lib/x86_64-linux-gnu/libsnappy.so
```



