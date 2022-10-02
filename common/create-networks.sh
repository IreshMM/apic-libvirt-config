#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../site-params.sh
export YGLU_ENABLE_ENV=1

NETWORKS_COUNT=$(($(yq '.networks | length' networks.yaml) - 1))
yglu networks.yaml > /tmp/networks.yaml

for net_num in $(seq 0 $NETWORKS_COUNT); do
    yq -y ".networks[$net_num]" /tmp/networks.yaml \
        | j2 --format=yaml network.xml.j2 \
        > /tmp/network-$net_num.xml
    virsh net-define /tmp/network-$net_num.xml --validate
    net_name=$(yq -r ".networks[$net_num].name" /tmp/networks.yaml)
    virsh net-autostart $net_name
    virsh net-start $net_name
done
