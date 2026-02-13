### Huge packet warning
Upd2raw client and server communicates with raw socket, which doesn't support IP fragment. You can't send packets larger than network MTU through udp2raw. You need to make sure you set MTU parameters correctly at upper level application.

Some times you will get "Huge packet" warnings even if you have set MTU correctly everywhere. It might be caused by the GRO feature of network drivers, you can try to add the `--fix-gro` on both sides to fix it.

Related issue:
https://github.com/wangyu-/udp2raw-tunnel/issues/226

### udp2raw server running on a common port (such as 443)

If you run you udp2raw server on a common port such as 443, do not let udp2raw listen on `0.0.0.0`, let it listen on the specific IP instead.

For example, change:
```
udp2raw -s -l0.0.0.0:443 -r127.0.0.1:1234      
```
to
```
udp2raw -s -l${your_server_ip}:443 -r127.0.0.1:1234      
```
Otherwise sometimes there will be some subtle problems hard to debug.

Related issue:
https://github.com/wangyu-/udp2raw-tunnel/issues/389

### VPN over udp2raw, traffic loop
Sometimes you might want to make VPN connections through udp2raw. For example you run your VPN client and udp2raw client on the same machine. 

VPN client usually provides some way to let you route your traffics through the VPN connection, or you can do it manually by your self with `ip route` rules.  No matter how you route your traffics,  make sure don't let VPN hijack udp2raw's traffic.  Otherwise, suppose your VPN is running through udp2raw and your udp2raw traffic is hijacked back to VPN, there will be a traffic loop.

Usually you can avoid traffic loop by adding a route exception, for example on linux:
```
ip route add ${udp2raw_server_ip} via ${default_network_gateway}
```

### Run inside virtual machine
make sure your virtual machine's virtual network adapter is running as bridged mode, other mdoes are not guaranteed to work.

### Run inside docker
only works on linux and `--network=host` is used.

It doesn't work on other OS, since other OS's docker doesnt support raw socket.
