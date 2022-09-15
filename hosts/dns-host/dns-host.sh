#!/bin/bash

virt-install --virt-type kvm --name=dns-host --ram 2048 --vcpus 2 --network network=management-network --graphics none --audio none --disk backing_store=/data/cloud-images/jammy-server-cloudimg-amd64-disk-kvm.img,format=qcow2,size=40,pool=vm-images --os-variant name=ubuntu22.04 --import --noautoconsole --cloud-init user-data=user-data.yaml,network-config=network-config.yaml
