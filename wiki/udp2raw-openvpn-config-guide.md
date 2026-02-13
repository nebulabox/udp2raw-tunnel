# udp2raw+openvpn config guide
![image_vpn](https://github.com/wangyu-/udp2raw-tunnel/blob/master/images/openvpn.PNG)

![image4](https://github.com/wangyu-/udp2raw-tunnel/blob/master/images/image4.PNG)

# udp2raw command
#### run at server side
```
./udp2raw_amd64 -s -l0.0.0.0:8855 -r 127.0.0.1:7777 -k "passwd" --raw-mode faketcp -a
```
#### run at client side
assume server ip is 45.66.77.88
```
./udp2raw_amd64 -c -l0.0.0.0:3333 -r 45.66.77.88:8855 -k "passwd" --raw-mode faketcp -a
```

#### hint
You can add `--cipher-mode xor` `--auth-mode simple` to **both** sides to obtain maximum performance(but poor security).

# openvpn config

#### client side config
```
client
dev tun100
proto udp

remote 127.0.0.1 3333
resolv-retry infinite 
nobind 
persist-key 
persist-tun  

ca /root/add-on/openvpn/ca.crt
cert /root/add-on/openvpn/client.crt
key /root/add-on/openvpn/client.key

keepalive 3 20
verb 3
mute 20

comp-lzo no   #this option is deprecated since openvpn2.4. For 2.4 and above, use "compress" instead
#compress

cipher none      ##### disable openvpn 's cipher and auth for maxmized peformance. 
auth none        ##### you can enable openvpn's cipher and auth,if you dont care about peformance,or you dont trust udp2raw 's encryption

fragment 1200       ##### very important    it's a conservative value, you can turn it up a bit
mssfix 1200         ##### very important

sndbuf 2000000      ##### important
rcvbuf 2000000      ##### important
txqueuelen 4000     ##### suggested
```


#### server side config
```
local 0.0.0.0
port 7777 
proto udp
dev tun 

ca /etc/openvpn/easy-rsa/2.0/keys/ca.crt
cert /etc/openvpn/easy-rsa/2.0/keys/server.crt
key /etc/openvpn/easy-rsa/2.0/keys/server.key
dh /etc/openvpn/easy-rsa/2.0/keys/dh1024.pem

server 10.222.2.0 255.255.255.0 
ifconfig 10.222.2.1 10.222.2.6

client-to-client
duplicate-cn 
keepalive 10 60 

max-clients 50

persist-key
persist-tun

status /etc/openvpn/openvpn-status.log

verb 3
mute 20  

comp-lzo no   #this option is deprecated since openvpn2.4. For 2.4 and above, use "compress" instead
#compress

cipher none      ##### disable openvpn 's cipher and auth for maxmized peformance. 
auth none        ##### you can enable openvpn's cipher and auth,if you dont care about peformance,or you dont trust udp2raw 's encryption

fragment 1200       ##### very important    it's a conservative value, you can turn it up a bit
mssfix 1200         ##### very important

sndbuf 2000000      ##### important
rcvbuf 2000000      ##### important
txqueuelen 4000     ##### suggested
```

# to transparently redirect traffic
Check this article,its same for udp2raw+OpenVPN :

https://github.com/wangyu-/UDPspeeder/wiki/UDPspeeder-openvpn-config-guide

#### Note
If you want to transparently redirect traffic by VPN, it's very important to add a route exception (on client side) so that the VPN won't hijack udp2raw's traffic. Since your VPN traffic goes throught udp2raw, if your VPN hijacks udp2raw's traffic then there will be a traffic loop and your udp2raw will lost connection.

#### Note2 
for the reason of a smaller MTU see https://github.com/wangyu-/udp2raw/wiki/about-mtu