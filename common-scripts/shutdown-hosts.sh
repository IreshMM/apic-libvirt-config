#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/host-data.sh

HOSTS=${@:-${HOSTS[@]}}

for host in $HOSTS; do
    declare -n host_dict=$host

    virsh shutdown apic-${host_dict[name]}-$SITE_NAME
done
