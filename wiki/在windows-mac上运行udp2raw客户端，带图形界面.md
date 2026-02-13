##### UPDATED 2018/06/28 最新的udp2raw已经可以原生运行在windows/mac上了,见[这里](https://github.com/wangyu-/udp2raw-multiplatform)

## 以下是教程原文

目前udp2raw运行在windows/mac上需要借助虚拟机的帮助。不过，我已经把环境打包好了，几乎没有什么操作难度，也几乎不需要敲命令。

步骤：

##### 1. 在电脑上安装好vmware或virtualbox(100mb)。

##### 2. 去[releases](https://github.com/wangyu-/udp2raw-tunnel/releases)中下载打包好的镜像文件(15mb)：

![](https://github.com/wangyu-/files/blob/master/images/vm/Capture7.PNG)

双击，导入虚拟机镜像。

##### 3. 给虚拟机开机，查看虚拟机的ip:

![](https://github.com/wangyu-/files/blob/master/images/vm/Capture.PNG)

这里是192.168.100.94

##### 4. 在浏览器中键入 `http://192.168.100.94`

如果需要密码，输入123456。你将会进入到一个web页面。

![](https://github.com/wangyu-/files/blob/master/images/vm/Capture4.PNG)

##### 5. 选择，service -> udp2raw-tunnel。进入udp2raw界面

![](https://github.com/wangyu-/files/blob/master/images/vm/Capture3.PNG)

##### 6. 在servers manage页面，添加一个server地址, 填好端口、密码等。

![](https://github.com/wangyu-/files/blob/master/images/vm/Capture5.PNG)

##### 7. 在setting页面，选择刚才添加的 server地址，点save & apply， Running Status 那里会显示RUNNING。完成。

![](https://github.com/wangyu-/files/blob/master/images/vm/Capture6.PNG)

这样一个udp2raw隧道就建立好了。可以直接搭配kcptun/finalspeed/openvpn等程序使用。本例中，在windows/mac上用`192.168.100.94:8855`即可访问这个udp2raw隧道。在同一路由器下的其他设备，也一样可以用`192.168.100.94:8855`访问这个udp2raw隧道。

以后，如果你需要运行udp2raw客户端，只要把这个虚拟机开机就可以了，udp2raw客户端可以自动启动，不需要每次都进行以上的操作。

## 补充说明

重复 6. 7.步操作，可以同时运行多个udp2raw连接到不同的server

确保虚拟机运行在桥接模式（导入以后默认的模式应该就是桥接模式），桥接的网卡必须是你日常上网所用的网卡。

本文中的udp2raw图形界面的repo地址(如果对你有帮助，请去给作者点个star)：

https://github.com/sensec/luci-app-udp2raw
