#!/bin/bash

virt-install --virt-type kvm --name=jump-host --ram 4096 --vcpus 2 --network network=management-network --graphics vnc,listen=0.0.0.0,port=5900 --audio none --disk backing_store=/data/cloud-images/Rocky-8-GenericCloud-8.6.20220702.0.x86_64.qcow2,format=qcow2,size=40,pool=vm-images --os-variant name=rocky8.6 --import --noautoconsole --cloud-init user-data=user-data.yaml,network-config=network-config.yaml
