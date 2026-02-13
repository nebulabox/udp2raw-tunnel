## ISP load balancing

sometimes you might notice:

1. right after you establish udp2raw connection, the packet loss is high or latency is high
2. if you restart udp2raw with some chance it becomes significant better


this is not really udp2raw's fault. This is by ISP's load balancing mechanism, sometimes you are accidently allocated to a bad link.

#### workaround

you tried to restart/reconnect udp2raw for a few times, either by kill udp2raw or by the `--fifo` option, until you believe it's good enough.  Once it's good enough, leave it there and don't touch it any more.


## ISP punishment for long-term connection

sometimes you might notice:

1. right after you establish udp2raw connection, the packet loss and latency is good
2. after a day, you came back you see the packet-loss or latency becomes super bad
3. if you restart/reconnect udp2raw, it might recover.


#### workaround

when this happens, you can manually trigger a reconnect with the `--fifo` option.

It's better you write a script doing this. You monitor the packet loss of udp2raw via some script, if some condition is met your script tell udp2raw to reconnect with `--fifo`
