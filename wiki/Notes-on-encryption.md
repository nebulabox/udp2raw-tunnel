### udp2raw supports the following encryption related features
* Encrypt your traffic with AES-128-CBC/AES-128-CFB.
* Protect data integrity by HMAC-SHA1 (or weaker MD5/CRC32).
* Defense replay attack with anti-replay window

### why does udp2raw support encryption

The initial purpose and primay reason for udp2raw to have encryption is to against DPI(Deep Packet Inspection). FakeTCP may be seen as a way to fool the internet provider, you won't want to see udp2raw's protocol easily being detected (and blocked). Some DPI implement will inspect your packets silently, others may initiatively send packets to you to actively detect what protocol you are using. Some firewalls may replay packets to try to mess up your state machine in the protocol.  Having encrption implemented can make the above bad attempts much harder.

The encryption of udp2raw is NOT designed to serve as a replacement of security mechanisms such as TLS/openssh/openvpn. udp2raw doesn't support Forward Secrecy, and udp2raw is not backended by a security team. udp2raw does provide some level of protection of data security, but not serious as TLS/openssh/openvpn. When serious security is necessary, I recommend you to use TLS/openssh/openvpn. It's worth mention that TLS/openssh/openvpn's security mechanisms doesn't conflict with udp2raw's encryption. For example, you can use udp2raw+ openvpn to tunnel IP traffic and you can use udp2raw+kcptun+TLS/openssh to tunnel https/ssh traffic.

### why does udp2raw implement its own encryption mechanism, instead of using security protocols such as TLS?
Existing encryption mechanisms usualy only cares about the secuirty of your data, they typically make little attempt on hiding the protocol itself from DPI. When your are using TLS/openssh/openvpn, an attacker may never know the data transfered via TLS/openssh/openvpn, but a firewall can easly know you are using TLS/openssh/openvpn to transfer data. (assume openvpn is not running with static key mode)

In udp2raw, not only the data but also udp2raw protocol itself will be obsecured by encryption. The network traffics of udp2raw will look like a bunch of random junks and reduce the possibility of being detected by DPI.

### about the implementation of udp2raw's encryption

When `md5` and `aes` are used, udp2raw use the hash-then-encrypt scheme, encrpyted hash is served as mac. The security is less than using hmac, but the md5 option is kept for compatiblity.

When `hmac-sha1` and `aes` are used, first udp2raw will use `PKCS5_PBKDF2` for key strenghing and `HKDF` for key deriving, then use the encrypt-then-mac scheme.

To prevent replay a whole connection, udp2raw client and server will challenge each other with random numbers.

To prevent replay the packets inside a connection,  udp2raw packages are sequenced and an anti-replay-widnows is used to filter duplicated packets. 

### Others

###### why not mentioning wireguard in this article
WireGuard is a more modern VPN compared to openvpn, it's indeed worth mentioning. The reason I only mentioned openvpn in this article is that I haven't look into the protocol of wireguard yet. I am not sure, but I think what I said for openvpn also applies to wireguard.

