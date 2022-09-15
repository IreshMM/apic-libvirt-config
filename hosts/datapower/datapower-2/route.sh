IP=172.22.10.12
GATEWAY=172.22.10.1
SUFFIX=25
ETH=eth0
ip route add ${GATEWAY}/${SUFFIX} dev $ETH src $IP table rt2
ip route add default via $GATEWAY dev $ETH table rt2
ip rule add from ${IP}/32 table rt2
ip rule add to ${IP}/32 table rt2
