#!/bin/bash

if [ $# -eq 0 ]; then
  echo -e "No input files"
  exit 1
fi

fbasename=$(basename -- "${@}")

time tar -I "zstd -T0 -19 -v --auto-threads=logical --long" -cf "${fbasename}.tar.zst" "${@}"
