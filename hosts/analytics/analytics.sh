#!/bin/bash

virt-install --virt-type kvm --name=apic-analytics --ram 16384 --vcpus 4 --network network=subsys-network --graphics none --audio none --disk backing_store=/data/cloud-images/analytics.qcow2,format=qcow2,size=100,pool=vm-images,bus=sata --disk size=250,format=qcow2,bus=sata,pool=vm-images --os-variant name=ubuntu20.04 --import --noautoconsole --cdrom /data/apic-iso/pr-apic-anytcs.nsb.local.iso
