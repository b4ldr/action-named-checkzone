#!/bin/bash
set -eu

prefix=$1
zones_dir=$2
exclude=$3

pushd "${GITHUB_WORKSPACE}/${zones_dir}"
rc=0
for zonefile in "${prefix}"*
do
    if [[ "$zonefile" =~ "$exclude" ]]
    then
      continue
    fi
    zone=${zonefile#"${prefix}"}
    if ! named-checkzone -d -k fail -n fail -m fail -M fail $zone $zonefile
    then
      printf "%s: failed see output" "${zone}"
      rc=1
    fi
done
popd
exit $rc
