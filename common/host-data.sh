#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../site-params.sh
source ${SCRIPT_ROOT}/utils.sh

# Networks
MANAGEMENT_NETWORK=management-network-$SITE_NAME
SUBSYS_NETWORK=subsys-network-$SITE_NAME
GW_FE_NETWORK=gw-frontend-network-$SITE_NAME
GW_BE_NETWORK=gw-backend-network-$SITE_NAME
CLOUD_IMAGES_PATH=/data/cloud-images
ISO_PATH=/data/apic-iso

declare -A subsys_template=( \
    ["memory"]=16384 \
    ["network_1"]=$SUBSYS_NETWORK \
    ["disk_1_size"]=100 \
    ["disk_2_size"]=250 \
    ["os_variant"]="ubuntu20.04" \
    ["cpus"]=4 \
    ["bus"]="sata" \
)

declare -A _management=( \
    ["name"]=management \
    ["image"]=${CLOUD_IMAGES_PATH}/APIConnect-management.qcow2 \
    ["iso"]=${ISO_PATH}/mgmt-${SITE_NAME}-plan-out/*.iso \
)

declare -A _analytics=( \
    ["name"]=analytics \
    ["image"]=${CLOUD_IMAGES_PATH}/APIConnect-analytics.qcow2 \
    ["iso"]=${ISO_PATH}/analyt-${SITE_NAME}-plan-out/*.iso \
)

declare -A _portal=( \
    ["name"]=portal \
    ["image"]=${CLOUD_IMAGES_PATH}/APIConnect-portal.qcow2 \
    ["iso"]=${ISO_PATH}/port-${SITE_NAME}-plan-out/*.iso \
)

declare -A analytics management portal

merge_dict analytics subsys_template _analytics
merge_dict management subsys_template _management
merge_dict portal subsys_template _portal


declare -A datapower_template=( \
    ["cpus"]=4
    ["memory"]=8192 \
    ["network_1"]=$GW_FE_NETWORK \
    ["network_2"]=$GW_BE_NETWORK \
    ["disk_1_size"]=24 \
    ["os_variant"]="centos7" \
    ["image"]=${CLOUD_IMAGES_PATH}/DataPower-10.0.4-CentOS-7-x86_64-GenericCloud.qcow2 \
    ["cloud-init"]=1
)

declare -A _datapower_1=( \
    [name]=datapower-1 
)

declare -A _datapower_2=( \
    [name]=datapower-2
)

declare -A _datapower_3=( \
    [name]=datapower-3 
)

declare -A datapower_1
declare -A datapower_2
declare -A datapower_3

merge_dict datapower_1 datapower_template _datapower_1
merge_dict datapower_2 datapower_template _datapower_2
merge_dict datapower_3 datapower_template _datapower_3

declare -A dns_host=( \
    [name]=dns-host 
    [memory]=2048
    [cpus]=2
    [disk_1_size]=40
    [network_1]=$MANAGEMENT_NETWORK
    [image]=${CLOUD_IMAGES_PATH}/jammy-server-cloudimg-amd64-disk-kvm.img
    [os_variant]=ubuntu22.04
    [cloud-init]=1
)

declare -A jump_host=(
    [name]=jump-host
    [memory]=4096
    [cpus]=2
    [disk_1_size]=40
    [network_1]=$MANAGEMENT_NETWORK
    [image]=${CLOUD_IMAGES_PATH}/Rocky-8-GenericCloud-8.6.20220702.0.x86_64.qcow2
    [os_variant]=rocky8.6
    [graphics]=1
    [cloud-init]=1
)

declare -A nginx_lb_host=(
    [name]=nginx-lb-host
    [memory]=2048
    [cpus]=2
    [disk_1_size]=40
    [network_1]=$GW_FE_NETWORK
    [network_2]=$GW_BE_NETWORK
    [image]=${CLOUD_IMAGES_PATH}/jammy-server-cloudimg-amd64-disk-kvm.img
    [os_variant]=ubuntu22.04
    [cloud-init]=1
)

