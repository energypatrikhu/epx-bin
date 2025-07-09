#!/bin/bash

[ "$#" -eq 0 ] && echo -e "No input files" && return

fbasename=$(basename -- "$@")

time tar -I "zstd -T0 --ultra -22 -v --auto-threads=logical --long -M8192" -cf "${fbasename}.tar.zst" "$@"
