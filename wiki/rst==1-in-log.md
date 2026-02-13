You may get rst==1 in the following scenes:

#### 1. You didnt run udp2raw with `-a` option, nor did you add the necessary iptables rule manually. Or you deleted the iptables rules after udp2raw added it. Then you may get rst==1 from any sides.

In this case,its not suggested to ignore it, you have to run udp2raw with `-a` option, or add iptables-rules manually  with the help of `-g` option (suggested).

#### 2. You killed udp2raw client after a connection has already established to server. Then you may get rst==1 from server log.

In this case, it's not perfect but it's as expected.  In most case it doesn't cause a problem.

If you want to be perfect, it's suggested to use `-g` instead, add the rule manually and permanently.

#### 3. You killed udp2raw server while udp2raw client is running. Or you are using udp2raw to connect to an non-existed server. Then you may get rst==1 from client log. 

Start your server. And ignore the previous rst==1 logs.

#### 4. Not covered by the above scenes, but you still got rst==1

Maybe the NAT middle-box or firewalls is trying to obstruct your connection. You can post a Issue for help. 