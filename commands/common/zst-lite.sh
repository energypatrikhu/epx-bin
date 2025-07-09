#!/bin/bash

[ "$#" -eq 0 ] && echo -e "No input files" && return

fbasename=$(basename -- "$@")

time tar -I "zstd -T0 -19 -v --auto-threads=logical --long" -cf "${fbasename}.tar.zst" "$@"
