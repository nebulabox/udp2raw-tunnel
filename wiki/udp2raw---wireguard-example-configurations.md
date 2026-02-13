[udp2raw+ wireguard example 1](https://gist.github.com/hamid-rostami/5ed34fe1948f40685f7035de36be7035)

[udp2raw+ wireguard example 2](https://www.procustodibus.com/blog/2022/02/wireguard-over-tcp/)

### Additional Note

If you wang to redirect 0.0.0.0/0 via VPN, it's very important to add a route exception (on client side) so that the VPN won't hijack udp2raw's traffic. 

(Since your VPN traffic goes throught udp2raw, if your VPN hijacks udp2raw's traffic then there will be a traffic loop and your udp2raw will lose connection.)


The route exception could be done by:

```
ip route add ${YOUR_SERVER_IP} via  ${YOUR_GATEWAY_IP}
```

If you don't know how to find YOUR_GATEWAY_IP, you can find an example in https://github.com/wangyu-/UDPspeeder/wiki/UDPspeeder-openvpn-config-guide