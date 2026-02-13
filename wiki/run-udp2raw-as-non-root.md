It's not secure to run a program as root. This page demonstrates how to run udp2raw as non-root.

You must have `setcap` utility as a prerequisite. `setcap` is shipped with most desktop linux distributions by default. But its seems to be missing on OpenWRT/LEDE.

1. grant udp2raw CAP_NET_RAW capability
```
sudo setcap cap_net_raw+ep udp2raw_amd64
```

2. run udp2raw with `-g` option instead of `-a`, then udp2raw will generate a iptables rule for you 
```
./udp2raw_amd64 -s -l0.0.0.0:4096 -r 127.0.0.1:7777  -k "passwd" --raw-mode faketcp -g    
```
3. add the generated iptables rule manually
```
sudo iptables -I INPUT -p tcp -m tcp --dport 4096 -j DROP     
```

4. then run udp2raw without `-g` option
```
# run udp2raw as current user 
./udp2raw_amd64 -s -l0.0.0.0:4096 -r 127.0.0.1:7777  -k "passwd" --raw-mode faketcp
```

or

```
# run udp2raw as nobody
sudo -u nobody ./udp2raw_amd64 -s -l0.0.0.0:4096 -r 127.0.0.1:7777  -k "passwd" --raw-mode faketcp
```
It works for both client and server.