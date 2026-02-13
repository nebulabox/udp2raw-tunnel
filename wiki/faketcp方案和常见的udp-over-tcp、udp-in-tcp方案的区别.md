### udp over tcp、udp in tcp方案是什么

udp over tcp、udp in tcp说的是一回事儿，是把udp协议封装到tcp协议里发送。 常见的有tcp模式的openvpn，还有$$R的tcp in udp模式。 这种方式是把udp数据包打包封装后用tcp协议来发送。 本质上是发送时把udp转换成tcp，然后在接收方恢复出来。

这种方案的缺点是会影响udp传输的速率和实时性，因为tcp有可靠传输、拥塞控制、按序到达等特性，这些特性都是会牺牲速率和实时性且无法关掉的。

###### udp in tcp方案的常见特点

1. 如果网络很好不丢包，那么udp in tcp方案会工作得很好；如果网路稍微有一点丢包，数据包的延迟会极大得增加。 （按序到达造成的副作用）

2. 如果带宽充足，udp in tcp方案也会工作得很好；如果udp数据发送的数据一但超过了tcp的带宽，连接就会卡住一段时间，有时候会造成超过10秒的时间无法发送数据。（可靠传输、拥塞控制造成的副作用）

### udp2raw的faketcp方案是什么

用raw socket给udp协议直接加上伪造的tcp包头，把udp伪装成tcp；本质上还是udp，不需要经过系统的tcp协议栈，所以不会引入上述的问题。

但是伪装成tcp的udp流量可以骗过运营商的防火墙，可以避免udp断流。 

faketcp跟udp in tcp方案相比的缺点是无法穿透tcp代理（包括反向tcp代理），比如haproxy。不过好在tcp代理并不常见，一些没有独立IP的VPS可能是用tcp代理实现的。

### 回答一些常见误解

Q : 既然OpenVPN本身就支持TCP模式，那么使用udp2raw +OpenVPN(udp模式)还有什么用，直接使用OpenVPN(tcp模式)不就可以了吗？

A : 因为前面提到的性能问题。

Q: kcptun是靠把tcp转换成udp提升速度，配合udp2raw后岂不是又转回去了，这样kcptun是不是就没有加速效果了？

A : udp2raw只会把udp伪装成tcp，本质上还是udp，所以不会影响kcptun的效果。

Q: 有人说用kcptun+udp2raw还不如直接用tcp？

A: 跟上一个问题同样的道理。udp2raw只是伪装协议，并不会把你的协议真的变成tcp。用kcptun+udp2raw后，你所使用的仍然是kcp+udp协议