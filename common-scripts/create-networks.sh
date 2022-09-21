#!/bin/bash

NETWORKS_COUNT=$(($(yq '.networks | length' networks.yaml) - 1))

for net_num in $(seq 0 $NETWORKS_COUNT); do
    yq -y ".networks[$net_num]" networks.yaml \
        | j2 --format=yaml network.xml.j2 \
        > /tmp/network-$net_num.xml
    virsh net-define /tmp/network-$net_num.xml --validate
    net_name=$(yq -r ".networks[$net_num].name" networks.yaml)
    virsh net-autostart $net_name
    virsh net-start $net_name
done
