#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../site-params.sh

enable_routing() {
    SRC_SUBNET="$1"
    DST_SUBNET="$2"

    iptables -t nat -I POSTROUTING 1 -s "$SRC_SUBNET" -d "$DST_SUBNET" -j ACCEPT
    iptables -I FORWARD 1 -s "$SRC_SUBNET" -d "$DST_SUBNET" -j ACCEPT
}


SUBNETS="$(yglu networks.yaml | yq -r '.networks[] | "\( .gateway )/\( .suffix )"')"
for src_subnet in $SUBNETS; do 
    for dst_subnet in $SUBNETS; do
        if [ $src_subnet != $dst_subnet ]; then
            enable_routing $src_subnet $dst_subnet
        fi
    done
done


