# gflags的编译及使用

参看:

- [gflags官网](https://github.com/gflags/gflags)

- [How To Use gflags](https://gflags.github.io/gflags/)


## 1. gflags介绍
运行可执行程序的时候，用户可以通过命令行传递Commandline flags。例如：
<pre>
# fgrep -l -f /var/tmp/foo johannes brahms
</pre>
其中, `-l`和`-f /var/tmp/foo`为命令行flag， 而`johannes`与`brahms`为命令行arguements。

一般情况下，可执行程序会列出允许用户传递的flags，以及对应的flag是否可以传递参数。在上面的例子中，`-l`不能携带参数， 而`-f`可以携带参数。用户可以使用一些库来帮助解析命令行，并将这些flags存储到一些数据结构中。


