#!/bin/bash

virt-install --virt-type kvm --name=datapower-1 --ram 18432 --vcpus 4 --network network=gw-frontend-network --network network=gw-backend-network --graphics none --audio none --disk backing_store=/data/cloud-images/CentOS-7-x86_64-GenericCloud.qcow2,format=qcow2,size=100,pool=vm-images --os-variant name=centos7 --import --noautoconsole --cloud-init user-data=user-data.yaml,network-config=network-config.yaml
