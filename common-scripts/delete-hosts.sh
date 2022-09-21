#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/host-data.sh

HOSTS=${@:-${HOSTS[@]}}

for host in $HOSTS; do
    declare -n host_dict=$host

    virsh destroy apic-${host_dict[name]}-$SITE_NAME
    virsh undefine apic-${host_dict[name]}-$SITE_NAME --remove-all-storage
done
