### kcptun-raw
udp2raw was inspired by kcptun-raw,which modified kcptun to support tcp mode.

https://github.com/Chion82/kcptun-raw
### relayRawSocket
kcptun-raw was inspired by relayRawSocket. A simple  udp to raw tunnel,wrote in python

https://github.com/linhua55/some_kcptun_tools/tree/master/relayRawSocket
### kcpraw
another project of kcptun with tcp mode

https://github.com/ccsexyz/kcpraw

### icmptunnel
Transparently tunnel your IP traffic through ICMP echo and reply packets.

https://github.com/DhavalKapil/icmptunnel

### Tcp Minion
Tcp Minion is a project which modifid the code of tcp stack in kernel,and implemented real-time out-order udp packet delivery through this modified tcp stack.I failed to find the implementation,but there are some papers avaliable:

https://arxiv.org/abs/1103.0463

http://korz.cs.yale.edu/2009/tng/papers/pfldnet10.pdf

https://pdfs.semanticscholar.org/9e6f/e2306f4385b4eb5416d1fcab16e9361d6ba3.pdf

### Phantun

https://github.com/dndx/phantun

Transforms UDP stream into (fake) TCP streams that can go through Layer 3 & Layer 4 (NAPT) firewalls/NATs.

The most interesting part is, it uses the tun device for raw socket sending instead of raw_socket/libpcap. 

Light weight, better performance. Less function than udp2raw though.