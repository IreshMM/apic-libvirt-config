#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../site-params.sh

for network in $(yglu networks.yaml | yq -r '.networks[].name'); do
    virsh net-undefine $network
done
