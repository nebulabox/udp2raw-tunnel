### Send/Receive UDP Packets with ICMP/FakeTCP/UDP headers
ICMP/FakeTCP headers help you bypass UDP blocking, UDP QOS or improper UDP NAT behavior on some ISPs. In ICMP header mode,udp2raw works like an ICMP tunnel.

UDP headers are also supported. In UDP header mode, it behaves just like a normal UDP tunnel, and you can just make use of the other features (such as encryption, anti-replay, or connection stalization).

### Simulated TCP with Real-time/Out-of-Order Delivery
In FakeTCP header mode,udp2raw simulates 3-way handshake while establishing a connection,simulates seq and ack_seq while data transferring. It also simulates following TCP options: `MSS`, `sackOk`, `TS`, `TS_ack`, `wscale`.Firewalls will regard FakeTCP as a TCP connection, but its essentially UDP: it supports real-time/out-of-order delivery(just as normal UDP does), no congestion control or re-transmission. So there wont be any TCP over TCP problem when using OpenVPN.

### Encryption, Anti-Replay
* Encrypt your traffic with AES-128-CBC.
* Protect data integrity by HMAC-SHA1 (or weaker MD5/CRC32).
* Defense replay attack with an anti-replay window, smiliar to IPSec and OpenVPN.

### Failure Dectection & Stablization (Connection Recovery)
Conection failures are detected by heartbeats. If timed-out, client will automatically change port number and reconnect. If reconnection is successful, the previous connection will be recovered, and all existing UDP conversations will stay vaild.

For example, if you use udp2raw + OpenVPN, OpenVPN won't lose connection after any reconnect, **even if network cable is re-plugged or WiFi access point is changed**.