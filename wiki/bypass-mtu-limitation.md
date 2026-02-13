udp2raw by default support MTU max at around 13xx, depending on what kind of VPN you are using. (although I am usually suggesting 1200)

In case you need MTU >13xx, it's a well-known problem which can be near perfectly sloved by chaining [UDPspeeder](https://github.com/wangyu-/UDPspeeder) in between:

```
wireguard_client-->udpspeeder_client-->udp2raw_client---------(internet)---------->udp2raw_server-->udpspeeder_server-->wireguard_server
```

UDPspeeder (with `--mode 0`, the default mode) supports both user space packet splitting and FEC, it allows you to send large packet efficiently without enlarge the network packet loss (maybe this is the only efficient way ever).  But you might need to [tune parameters](https://github.com/wangyu-/UDPspeeder/wiki/Suggested-parameters) to get good performance.

In the above diagram, at the sender end UDPspeeder will split the large packet coming from wireguard into proper size, then pass it to udp2raw.  At the receiver, UDPspeeder will reassemble the packet comming from udp2raw, then pass the original large packet to wireguard.