#!/bin/bash

enable_routing() {
    SRC_SUBNET="$1"
    DST_SUBNET="$2"

    iptables -t nat -I POSTROUTING 1 -s "$SRC_SUBNET" -d "$DST_SUBNET" -j ACCEPT
    iptables -I FORWARD 1 -s "$SRC_SUBNET" -d "$DST_SUBNET" -j ACCEPT
}


SUBNETS="$(yq -r '.networks[] | "\( .gateway )/\( .suffix )"' networks.yaml)"
for src_subnet in $SUBNETS; do 
    for dst_subnet in $SUBNETS; do
        if [ $src_subnet != $dst_subnet ]; then
            enable_routing $src_subnet $dst_subnet
        fi
    done
done


