# FlutterCI

iOS和Flutter混合工程的CI中的IOS工程示例。

具体可以参考https://www.jianshu.com/u/a3ae8888a19a

和官方的混合工程的区别主要是修改了，Podfile文件和添加了podhelper.rb文件.

在Podfile中你可以通过修改IOSONLY_MODE、PUBLISH_FLUTTER_PRODUCTION、USE_FLUTTER_PRODUCTION_TYPE三个参数来修改配置。

#是否在IOS开发环境下编译
IOSONLY_MODE=0

#是否发布flutter产物到git服务器
PUBLISH_FLUTTER_PRODUCTION=0

#在纯IOS开发环境下，使用Debug还是Release模式的Flutter产物
USE_FLUTTER_PRODUCTION_TYPE="Debug"

podhelper.rb文件主要作用就是修改flutter产物的pod的路径和在build phase中添加上传flutter产物的过程。
