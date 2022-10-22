#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export YGLU_ENABLE_ENV=1

enable_routing() {
    SRC_SUBNET="$1"
    DST_SUBNET="$2"

    iptables -t nat -I POSTROUTING 1 -s "$SRC_SUBNET" -d "$DST_SUBNET" -j ACCEPT
    iptables -I FORWARD 1 -s "$SRC_SUBNET" -d "$DST_SUBNET" -j ACCEPT
}


source ${SCRIPT_ROOT}/../active-site/site-params.sh
ACTIVE_SUBNETS=($(yglu networks-active.yaml | yq -r '.networks[] | select(.name | contains("subsys")) | "\( .gateway )/\( .suffix )"'))
PASSIVE_SUBNETS=($(yglu networks-passive.yaml | yq -r '.networks[] | select(.name | contains("subsys")) | "\( .gateway )/\( .suffix )"'))

for i in "${!ACTIVE_SUBNETS[@]}"; do
    enable_routing "${ACTIVE_SUBNETS[$i]}" "${PASSIVE_SUBNETS[$i]}"
    enable_routing "${PASSIVE_SUBNETS[$i]}" "${ACTIVE_SUBNETS[$i]}"
done

# DNS servers primary secondary communication
enable_routing "10.1.2.5/32" "10.1.4.5/32"
enable_routing "10.1.4.5/32" "10.1.2.5/32" 
