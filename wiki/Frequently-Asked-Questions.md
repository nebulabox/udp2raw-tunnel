### Q: What is the advantage of using udp2raw FakeTCP mode,why not use a TCP-based VPN(such as OpenVPN TCP mode)?
Answer: **TCP doesnt allow real-time/out-of-order delivery**. **If you use OpenVPN TCP mode to turn UDP traffic into TCP,there will be latency issue**:the loss of a single packet blocks all following packet until re-transmission is done. This will cause unacceptable delay for gaming and voice chatting.

**TCP also has re-transmission and congestion control which cant be disabled.** UDP programs usualy want to control packet sending rate by themselves. If you use OpenVPN TCP mode this cant be done because of the congestion control of underlying TCP protocol. Further more,with the re-transmission of underlying TCP,**if you send too many udp packets via an OpenVPN TCP connection,the connection will become completely unusable for a while**(It will eventually recover as most of the re-transmission is done,but it wont be very soon).

Those issues exist for almost all TCP-based VPNs.

For udp2raw there is no underlying TCP protocol,udp2raw just add TCP headers to UDP packets directly by using raw socket. It supports real-time/out-of-order delivery,there is no re-transmission and congestion control. **Udp2raw doesnt have all above issues**.

### Q: Is udp2raw designed for replacing VPN?
Answer: No. Udp2raw is designed for bypassing UDP restrictions. It doesnt have all of the features a VPN has(such as transparently redirect all traffic).

Instead of replacing VPN,udp2raw can be used with any UDP-based VPN together to grant UDP-based VPN the ablity of bypassing UDP restrictions,while not having the performance issue involved by a TCP-based VPN. Check [this link](https://github.com/wangyu-/udp2raw-tunnel#tunneling-any-traffic-via-raw-traffic-by-using-udp2raw-openvpn) for more info.