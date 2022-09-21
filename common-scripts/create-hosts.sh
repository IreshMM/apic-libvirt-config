#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/host-data.sh

HOSTS=${@:-${HOSTS[@]}}

for host in $HOSTS; do
    declare -n host_dict=$host

    echo ---------------------------------------------------------------------------
    INSTALL_CMD="virt-install \
        --virt-type kvm \
        --name=apic-${host_dict[name]}-$SITE_NAME \
        --ram ${host_dict[memory]} \
        --vcpus ${host_dict[cpus]} \
        --network network=${host_dict[network_1]} \
        $([ -v 'host_dict[network_2]' ] && echo --network network=${host_dict[network_2]} ) \
        $([ -v 'host_dict[vnc_port]' ] && echo --graphics vnc,listen=0.0.0.0,port=${host_dict[vnc_port]} || echo --graphics none ) \
        --audio none \
        --disk backing_store=${host_dict[image]},format=qcow2,size=${host_dict[disk_1_size]},pool=vm-images$([ -v 'host_dict[bus]' ] && echo ,bus=${host_dict[bus]}) \
        $([ -v 'host_dict[disk_2_size]' ] && echo --disk size=${host_dict[disk_2_size]},format=qcow2,pool=vm-images$([ -v 'host_dict[bus]' ] && echo ,bus=${host_dict[bus]})) \
        --os-variant name=${host_dict[os_variant]} \
        $([ -v 'host_dict[iso]' ] && echo --cdrom ${host_dict[iso]} ) \
        $([ -v 'host_dict[user_data]' ] && echo --cloud-init user-data=${host_dict[user_data]},network-config=${host_dict[network_config]}) \
        --events on_reboot=restart,on_poweroff=destroy,on_crash=destroy \
        --import \
        --noautoconsole"
    $INSTALL_CMD
done