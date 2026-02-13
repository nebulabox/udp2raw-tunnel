# 背景
如果你的宿主机通过直接插网线PPPOE拨号上，或者公司的网络不允许桥接，那么你将无法使用桥接模式的虚拟机。

这种情况也是有解决办法的。思路是用虚拟机提供的host-only网路，然后自己手动在Mac/Windows上设置NAT，把网络分享给虚拟机。

(注：不可以用虚拟机自带的NAT功能。无论是Vmware还是virtualBox的NAT，都不是真正的NAT)

# Macos + VirtualBox

### 虚拟机网络配置
在VirtualBox的全局设置里，新建一个host-only网络(默认名称为vboxnet0),使用默认设置(确保dhcp是开启的)

把虚拟机的网络设置成刚才创建的host-only网路

![](https://raw.githubusercontent.com/wangyu-/udp2raw-tunnel/master/images/wiki/mac_nat_vb1.PNG)

![](https://raw.githubusercontent.com/wangyu-/udp2raw-tunnel/master/images/wiki/mac_nat_vb4.PNG)

![](https://raw.githubusercontent.com/wangyu-/udp2raw-tunnel/master/images/wiki/mac_nat_vb3.PNG)

### mac上开启ipforward nat
在mac上运行：
```
sudo su # 先切换到root账号

sysctl -w net.inet.ip.forwarding=1  
sysctl -w net.inet.ip.fw.enable=1  ##这两条的命令是开启ip_forward

echo 'nat on en0 from 192.168.56.0/24 to any -> (en0)'  >1.tmp.rule   #新建一个文件, en0是的mac上网的网卡。 192.168.56.0/24是mac和虚拟机间host-only网络的子网
pfctl -d
pfctl -F all
pfctl -f 1.tmp.rule -e  #以上4条命令是为了开启nat
```
### 给虚拟机配置网关和dns

在虚拟机中运行：
```
ip route default via 192.168.56.1 dev eth0  #添加网关
echo `nameserver 8.8.8.8` >>/etc/resolv.conf #添加dns
```

### 总结

以上就是全部配置了。正确配置后虚拟机可以正常上网，udp2raw也可以稳定运行。

# Macos + VMware

按照上面的`Macos + VirtualBox`发挥一下。因为我的Mac上没有装vmware，就不演示了。

# Windows + VirtualBox/VMware

### 虚拟机网络配置（VirtualBox）
在VirtualBox的全局设置里，新建一个host-only网络,但是要关掉dhcp(因为windows网络共享功能会自带dhcp)。

把虚拟机的网络设置成刚才创建的host-only网路

注：因为virtualBox的原因，关掉dhcp后最好重启一下Windows，否则有可能没有真正关掉。

![](https://raw.githubusercontent.com/wangyu-/udp2raw-tunnel/master/images/wiki/windows_nat_vb1.PNG)

![](https://raw.githubusercontent.com/wangyu-/udp2raw-tunnel/master/images/wiki/windows_nat_vb2.PNG)

### 虚拟机网络配置（VMware）
在VMware的Edit-->virtual network editor里，新建一个host-only网络，关掉dhcp。

把虚拟机的网络设置成刚才创建的host-only网路。(setting--->network adapter,网络类型选custom，然后选刚才建立的host-only网络)

![](https://raw.githubusercontent.com/wangyu-/udp2raw-tunnel/master/images/wiki/windows_nat_vm2.PNG)

![](https://raw.githubusercontent.com/wangyu-/udp2raw-tunnel/master/images/wiki/windows_nat_vm1.PNG)

### 在Windows里设置网络共享

首先，在`网络`中找到你的Windows上网所用的网卡。右键-->properity-->sharing，勾选“allow other user....”，选择刚才创建的host-only网络所对应的网卡。

![](https://raw.githubusercontent.com/wangyu-/udp2raw-tunnel/master/images/wiki/windows_nat.PNG)

注意：设置网络分享后windows会接管这个host-only网络的dhcp，你的虚拟机ip可能会变，是正常的，windows分配的ip一般是192.168.137.xxx。

### 总结

以上就是全部配置了。正确配置后虚拟机可以正常上网，udp2raw也可以稳定运行。因为windows的网络分享功能自带dhcp和dns，所以设置方法和Mac稍有区别：在vmware/virtualbox的host-only网络设置中要关闭dhcp，在虚拟机中不需要自己添加路由和dns。


