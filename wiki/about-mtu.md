udp2raw introduces it's own header for faketcp, encryption, anti-replay and multiplex. As a result you have to decrease the MTU to "make room" for the extra overhead. (By the way, this is not only for udp2raw, this happens for almost all tunnels)

Since udp2raw itself doesn't have user space packet splitter, you have to tune the MTU at upper level appliation (for example: openvpn, wireguard, kcptun) to make sure they don't send packet too large for udp2raw.

udp2raw support mtu at most 13xx depends on the upper level application (e.g. what kind of VPN you are using), I suggest to use `1200` as a safe value.

However, if you are not happy with this or your upper level application doesn't allow you to tune MTU, there is indeed a way to by pass the MTU limitation, see [[https://github.com/wangyu-/udp2raw/wiki/bypass-mtu-limitation]]


#### if you simply want to disable the mtu warning
By default udp2raw will warn you if it sees a packet larger than 1375, if you belive your link can send large MTU and you simply want to disable the warning, you can use `--mtu-warn 9999`.