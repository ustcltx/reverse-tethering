#!/bin/bash
check_command () {
    type "$1" &> /dev/null
    if [ $? -eq 1 ]; then
	echo "$1"" not found."
	exit
    fi
}

check_command adb
isADBWork=`adb devices  | grep -v "devices" | grep "device"`
if [ -z "$isADBWork" ];then
	adb kill-server > /dev/null && adb devices > /dev/null
else
	echo "成功识别您的安卓手机！"
fi

isBusyBoxExist=`adb shell "if [ -f /system/xbin/busybox ];then echo "exist";fi"`
if [ -z $isBusyBoxExist ];then
	echo "busybox not found."
	exit
fi

isEnableUSBTethering=`adb shell busybox ifconfig rndis0 | grep -v "not found" | grep "rndis0"`
if [ -z "$isEnableUSBTethering" ];then
        echo "请打开手机上网络共享！"
        exit
fi

isEnablePCShareNetwork=`LANG=C;/sbin/ifconfig usb0 | grep "addr:10.42.0.1"`
if [ -z "$isEnablePCShareNetwork" ];then
        echo "请在顶部NetworkManager里编辑新生成的有线连接，让选项“ipv4设置>方法”为“已其他计算机共享”"
        exit
fi
isEnableWifiOnMobile=`adb shell busybox ifconfig wlan0 | grep -v "not found" | grep "wlan0"`
if [ -z "$isEnableWifiOnMobile" ];then
        echo "请开启手机的WIFI,避免某些app以为无网络环境！"
        exit
fi
echo "将USB伪装成WIFI..."
adb shell busybox ifconfig wlan0 0.0.0.0
echo "正在给手机分配ip地址..."
adb shell netcfg rndis0 dhcp
echo "正在给手机设置网关..."
adb shell busybox route add default gw 10.42.0.1 dev rndis0
echo "手机已经接上PC网络！"







