a simple method to keep udp2raw alive, in the case udp2raw quits

(This is actually basic linux usage, which is out of scope of udp2raw. I am keeping it here as a friendly reminder)

#### create run.sh
save the below content as run.sh
```
#! /bin/sh
while true
   do
   $@
   sleep 1
done
```

run `chmod 755 run.sh`

#### run udp2raw with run.sh

```
./run.sh ./udp2raw_amd64 -s -l0.0.0.0:4096 -r 127.0.0.1:7777  -a -k "passwd" --raw-mode faketcp
```