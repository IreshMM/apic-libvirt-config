#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../site-params.sh

NETWORKS_COUNT=$(($(yq '.networks | length' networks.yaml) - 1))

for net_num in $(seq 0 $NETWORKS_COUNT); do
    yglu networks.yaml | yq -y ".networks[$net_num]" \
        | j2 --format=yaml network.xml.j2 \
        > /tmp/network-$net_num.xml
    virsh net-define /tmp/network-$net_num.xml --validate
    net_name=$(yq -r ".networks[$net_num].name" networks.yaml)
    virsh net-autostart $net_name
    virsh net-start $net_name
done
