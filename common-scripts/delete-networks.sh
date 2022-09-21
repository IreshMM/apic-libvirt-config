#!/bin/bash

for network in $(yq -r '.networks[].name' networks.yaml); do
    virsh net-undefine $network
done
