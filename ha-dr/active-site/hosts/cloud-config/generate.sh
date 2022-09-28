#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../../site-params.sh

rm -rf config 
[ "$1" = delete ] && exit 0;

export YGLU_ENABLE_ENV=1  

yglu config.yaml > /tmp/cloud_config.yaml

NUM_HOSTS=$(yq '.hosts.generators.nodes.items | length' /tmp/cloud_config.yaml)

for i in $(seq 0 $(($NUM_HOSTS -1 ))); do
    host_name=$(yq -r ".hosts.generators.nodes.items[$i].name" /tmp/cloud_config.yaml)
    mkdir -p config/$host_name
    echo "#cloud-config" > config/${host_name}/user-data.yaml
    yq -y ".hosts.generators.nodes.hosts[$i].cloud_config" /tmp/cloud_config.yaml >> config/${host_name}/user-data.yaml
    yq -y ".hosts.generators.nodes.hosts[$i].network_config" /tmp/cloud_config.yaml > config/${host_name}/network-config.yaml
done
