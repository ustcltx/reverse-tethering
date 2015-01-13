reverse-tethering
===============================

一个简单的,可以让安卓手机使用Linux电脑网络的脚本。

使用：./reverse-tethering.sh

依赖：本程序依赖 Android Debug Bridge (ADB) 
对于ubuntu可以这样安装：

$ sudo apt-get install android-tools-adb

使用步骤:

一、 将手机通过USB与电脑连接

二、 手机上打开USB网络共享和WIFI

三、 编辑linux电脑上已经自动新建的有线连接，将其设置里IPV4设置下的“方法”改成“与其他计算机共享”
<img src="http://i2.tietuku.com/d5850e4f81af9b9a.png" />

四、 运行脚本

PS: 脚本会自动提示你所缺少的环境和步骤



