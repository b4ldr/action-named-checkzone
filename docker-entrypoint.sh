#!/bin/bash
set -exu

prefix=$1
zones_dir=$2

pushd "$zones_dir"
rc=0
for zonefile in "${zones_dir}/${prefix}*"
do
    zone=${zonefile#"${prefix}"}
    if ! named-checkzone -d -k fail -n fail -m fail -M fail $zone $zonefile
    then
      printf "%s: failed see output" "${zone}"
      rc=1
    fi
done

exit $rc
